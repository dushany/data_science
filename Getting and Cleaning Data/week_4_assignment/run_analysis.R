# Assigment for week 4 of the course, Getting and Cleaning Data. The script
# takes data collected from accelerometers from the Samsung Galaxy S smartphone
# of subjects in the study, loads the datasets, and combines them
# into a single dataset. Also, it creates a tidy dataset with the averages of
# the means and standards deviations for measurements collected, grouped by 
# activity and subject.

library(readr)
library(plyr)
library(dplyr)
library(tidyr)

# download zip file with all data if not already completed. Set path to files
# as working directory.

if (!file.exists("UCI HAR Dataset")){
    temp <- tempfile()
    fileUrl <- paste0("https://d396qusza40orc.cloudfront.net/getdata",
                      "%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
    
    download.file(fileUrl,temp,quiet = TRUE,mode = "wb")
    downloadDate <- date()
    cat("Download completed ", downloadDate, "\n")
    unzip(temp)
    cat("Files unzipped to", getwd(), "\n")
}

setwd("./UCI HAR Dataset")

# Merge the training and the test measurement sets to create one meaurement 
# dataset.
x.train <- read_table("./train/x_train.txt",col_names = FALSE)
x.test <- read_table("./test/x_test.txt",col_names = FALSE)
x.set <- rbind(x.train,x.test)

# Load variable names and add to the columns of the measurement dataset.
# Subset measurement dataset to obtain the mean and standard deviation for each
# measurement. Remove "-()" from variables names to make tidier.
dataColNames <- read_table("features.txt", col_names = FALSE)
dataColNames <- separate(dataColNames,X1,into = c("ID","feature"), sep = " ")
names(x.set) <- dataColNames$feature
indCols <- grep("mean[()]|std[()]",names(x.set))
x.set <- x.set[,indCols]
names(x.set) <- gsub('[-()]','',names(x.set))


# Merge the activity data for the training and the test sets to create one 
# activity dataset.
# Load descriptive activity names and merge with activity data set.
y.train <- read_table("./train/y_train.txt",col_names = FALSE)
y.test <- read_table("./test/y_test.txt",col_names = FALSE)
y.set <- rbind(y.train,y.test)
names(y.set) <- "activity"

activityNames <- read_table("activity_labels.txt",col_names = FALSE)
names(activityNames) <- c("activity","activity.name")

y.set <- join(y.set,activityNames,by = "activity")

# Merge the subject data for the training and the test sets to create one 
# subject dataset.
subject.train <- read_table("./train/subject_train.txt",col_names = FALSE)
subject.test <- read_table("./test/subject_test.txt",col_names = FALSE)
subject.set <- rbind(subject.train,subject.test)
names(subject.set) <- "subject"

# Combine the subject, activity, and measurement datasets to create one dataset
# with all required data.
dataset <- cbind(subject.set,y.set,x.set)

# Create a second independent tidy data set with average of each variable by 
# activity and subject. 
by.subj.act <- dataset %>% group_by(activity.name,subject)
tidy.dataset <- by.subj.act %>% select(-activity) %>% summarize_each(funs(mean))

# remove temporary variables and reset path to top working directory
rm(list = setdiff(ls(),c("dataset","tidy.dataset","downloadDate")))
setwd("../")

# Write tidy dataset to text file.
write.table(tidy.dataset,file="tidy_data.txt",quote=FALSE,row.names = FALSE)
