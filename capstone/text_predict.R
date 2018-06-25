# file: text_process.R
# date: 26 November 2017
# author: Dushan Yovetich
# description:
# functions for performing next-word prediction.

#load libraries
library(tidyverse)
library(data.table)

#load and sort processed corpus
kn_corpus <- readRDS("kn_corpus.rds")
kn_corpus <- kn_corpus[order(-p_mkn)]

#split text input and return words.
split_text <- function(text_input){
  t <- text_input %>% 
    stringr::str_to_lower(locale = "en") %>% 
    stringr::str_split(" ", simplify = TRUE) %>% 
    as.vector()
  
  if (length(t) >= 2){
    tail(t,2)
  } else {
    t
  }
  
}

#get next word from corpus, based on probability
get_word <- function(a,b,n=3){
  
  if (missing(b)){
    kn_corpus[w2 == a,.SD[which.max(p_mkn)],by = w3][,.SD[1:n]][,w3]
  } else {
    kn_corpus[w1 == a & w2 == b,.SD[which.max(p_mkn)],by = w3][,.SD[1:n]][,w3]
  }
  
}

#get word prediction
predict_word <- function(text_input){
  w <- split_text(text_input)
  
  if (length(w) >= 2){
    nw <- get_word(w[1],w[2])
  } else {
    nw <- get_word(w)
  }
  
  if (anyNA(nw)){
    num_words <- sum(is.na(nw))
    nw[is.na(nw)] <- get_word(a = w[2],n=num_words)
  }
  nw
}

predict_word(readline("enter something: "))
