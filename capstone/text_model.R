# file: text_model.R
# date: 7 November 2017
# author: Dushan Yovetich
# description:
# Modified Kneser-Ney Interpolation model for Coursera Capstone Project.

# Libraries:
# library(tidyverse)
# library(data.table)

#Calculate the discounts D(c) for modified Kneser-Ney Interpolation
calculate_discounts <- function(dt, ng_cols){
  
  dt <- copy(dt)
  
  #Get count c(w)
  dt[,nw := .N, by = get(ng_cols)]
  
  #Calculate N(c) counts for n-grams
  n <-  dt[,list(n1 = sum(nw == 1), n2 = sum(nw == 2),
                 n3 = sum(nw == 3), n4 = sum(nw == 4))]
  
  #Calculate D(c) discounts
  y <- n$n1/(n$n1+(2*n$n2))
  list(
    d1 = 1-2*y*(n$n2/n$n1),
    d2 = 2-3*y*(n$n3/n$n2),
    d3 = 3-4*y*(n$n4/n$n3)
  )
  
}

#Modified Kneser-Ney Interpolation for n-gram probabilities
modified_kneser_ney <- function(dt, ng_cols){
  
  n_tbl <- copy(dt)
  setkeyv(n_tbl, ng_cols)
  
  # create a hold-out sample to optimize discount D(c)
  samp_index <- n_tbl[,sample(.N, floor(.N * 0.9))]
  n_gram <- n_tbl[samp_index]
  n_gram_d <- n_tbl[-samp_index] 
  
  #Get discount D(c)
  d <- calculate_discounts(n_gram_d, ng_cols)
  
  #Get Wi
  wi <- tail(ng_cols,1)
  
  for (i in seq_along(ng_cols)){
    
    if (i == 1L){
      
      #Get counts N1+(*Wi), N1+(**)
      n_gram[,n_cont := uniqueN(.SD), by = get(wi)]
      n_gram[,n_types := uniqueN(n_gram)]
      
      #Calculate P_mkn(Wi) for lowest order n-grams
      n_gram[,p_mkn := n_cont/n_types]
      
    } else {
      
      #Get Wi-1
      wi_1 <- head(tail(ng_cols,i),i-1)
      
      #Get counts c(Wi,i-n+1)
      n_gram[,cwi := .N, by = mget(c(wi_1, wi))]
      
      #Get discounts D(c) to be used
      n_gram[cwi == 0L, D := 0][
        cwi == 1L, D := d[[1]]][
          cwi == 2L, D := d[[2]]][
            cwi > 2L, D := d[[3]]]
      
      #Get counts N1(Wi-1,i-n+1*), N2(Wi-1,i-n+1*), N3(Wi-1,i-n+1*)
      #used for calculating lambda weight y(Wi-1,i-n+1) for higher/est orders
      n_gram[, nwi_1 := uniqueN(get(wi)), by = mget(wi_1)]
      
      if (i == length(ng_cols)){
        
        #Get counts c(Wi-1,i-n+1)
        n_gram[,cwi_1 := .N, by = mget(wi_1)]
        
        #Calculate lambda weight for highest orders y(Wi-1,i-n+1)
        n_gram[,y_high := (nwi_1 * D)/cwi_1]
        
        #Calculate P_mkn(Wi|Wi-1) for highest order n-grams
        n_gram[,p_mkn := pmax(cwi - D,0)/ cwi_1 + (y_high * p_mkn)]
        
        
      } else {
        
        #Get counts N1+(*Wi,i-n+1) and N1+(*Wi-1,i-n+1*)
        n_gram[, n1 := uniqueN(.SD), by = mget(c(wi_1,wi))]
        n_gram[, n2 := uniqueN(.SD), by = mget(wi_1)]
        
        #Calculate lambda weight for highest orders y(Wi-1,i-n+1)
        n_gram[,y_low := (nwi_1 * D)/n2]
        
        #Calculate P_mkn(Wi|Wi-1) for higher order n-grams
        n_gram[,p_mkn := pmax(n1 - D,0)/n2 + (y_low * p_mkn)]
        
      }
    }
  }
  
  #Return original columns and Pmkn(Wi|Wi-1). Also, eliminating n-grams with 
  #c(Wi) less than 1 to free up space.
  rtn_cols <- c(ng_cols,"p_mkn")
  n_gram[cwi > 1,mget(rtn_cols)]
}
