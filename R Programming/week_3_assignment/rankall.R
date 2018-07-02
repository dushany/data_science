rankall <- function(outcome,num="best"){
    ## Read outcome data
    hdata <- read.csv("outcome-of-care-measures.csv",colClasses = "character",
                      na.strings="Not Available")
    
    ## Check that state and outcome are valid
    category <- c("Heart Attack","Heart Failure","Pneumonia")
    
    if (!outcome %in% category){
        text <- paste("No such category as",outcome,sep=" ")
        stop(text)
    }
    
    ## convert outcome to column name
    if (outcome == "Heart Attack"){
        cat.col <- 11
    } else if (outcome == "Heart Failure"){
        cat.col <- 17
    } else {
        cat.col <- 23
    }
    
    
    ## For each state, find the hospital of the given rank
    state <- sort(unique(hdata[,7]))
    hosp.all <- data.frame()
    
    for (x in seq_along(state)){
        ## filter based on state. order the data by 
        ## outcome and then hospital.
        sub.data <- hdata[(hdata[,7]==state[x]&!is.na(hdata[,cat.col])),]
        sub.data[,cat.col] <- as.numeric(sub.data[,cat.col])
        sub.data[,2] <- as.character(sub.data[,2])
        
        hosp <- sub.data[order(sub.data[,cat.col],sub.data[,2]),]
        
        ## Evaluate num for what to return
        if (num == "best"){
            indx <- 1
        } else if (num == "worst"){
            indx <- nrow(hosp)
        } else {
            indx <- num
        }
        
        ## Return hospital name in that state with the given rank
        ## 30-day death rate
        hosp.all <- rbind(hosp.all,cbind(hosp[indx,2],state[x]))
    }
    
    
    ## Return a data frame with the hospital names and the
    ## (abbreviated) state name
    names(hosp.all) <- c("Hospital","State")
    hosp.all
    
}