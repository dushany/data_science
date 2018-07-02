rankhospital <- function(state, outcome, num = "best"){
    ## Read outcome data
    hdata <- read.csv("outcome-of-care-measures.csv",colClasses = "character",
                      na.strings="Not Available")
    
    
    ## Check that state and outcome are valid
    if (!state %in% hdata[,7]){
        text <- paste("No such value for state as",state,sep=" ")
        stop(text)
    }
    
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
    
    ## filter based on state and remove NAs. order the data by 
    ## outcome and then hospital.
    sub.data <- hdata[(hdata[,7]==state & complete.cases(hdata)),]
    sub.data[,cat.col] <- as.numeric(sub.data[,cat.col])
    sub.data[,2] <- as.character(sub.data[,2])
    
    hosp <- sub.data[order(sub.data[,cat.col],sub.data[,2]),]
    
    ## Check that num is valid
    if (num == "best"){
        indx <- 1
    } else if (num == "worst"){
        indx <- nrow(hosp)
    } else {
        indx <- num
    }
    
    ## Return hospital name in that state with the given rank
    ## 30-day death rate
    hosp[indx,2]
}
