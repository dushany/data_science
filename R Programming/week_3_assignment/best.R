best <- function(state, outcome) {
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
        col <- 11
    } else if (outcome == "Heart Failure"){
        col <- 17
    } else {
        col <- 23
    }
        
    
    ## Return hospital name in that state with lowest 30-day death
    ## rate
    sub.data <- hdata[(hdata[,7]==state & complete.cases(hdata)),]
    sub.data[,col] <- as.numeric(sub.data[,col])
    sub.data[,2] <- as.character(sub.data[,2])
    
    hosp <- sub.data[order(sub.data[,col],sub.data[,2]),]
    hosp[1,2]
    
}
