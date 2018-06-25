# Code Book
## Getting and Cleaning Data Week 4 Assignment
Summary of data produced by the script, `run_analysis.R` and presented in the file, `tidy_dataset.txt`.

##Data Source(s)
The data is from the “Human Activity Recognition Using Smartphones Data Set” made available through the UCI Machine Learning Repository. See the link [here]( https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) for the original raw data.

The data is from a study carried out with a group of 30 volunteers between the ages of 19-48 years.  The data is a record of linear acceleration and angular velocity measurements obtained from smartphones (Samsung Galaxy S II) carried by the participants while performing six different activities.  The original raw data has been partitioned into separate data sets.

Files used from the original data set were:

| File | Description |
| ----|--------------|
|`features.txt:`  | Variable names for measurements classified as list of features.|
|`activity_labels.txt:` | Activity code and name of activity.|
|`train/X_train.txt:` | Measurements taken from smartphones and added to “train” data set.|
|`train/y_train.txt:` | Activity codes for measurements added to “train” data set.|
|`test/X_test.txt:` | Measurements taken from smartphones and added to “test” data set.|
|`test/y_test.txt:` | Activity codes for measurements added to “train” data set.|
|`train/subject_train.txt:` | Identifies subject who performed activity for each group of measurements.|

## Data Set Description
The rows in `tidy_dataset.txt` represent summarized data for a given subject and activity. Each column represents a single variable. The summarized data consists of the average values of the mean and standard deviations for each set of measurements. 

The identifying variables are as follows:

| Variable | Type | Description |
| ---------| ---- | ------------|
|`activity.name` | Character | Activity performed by subject of study.  Activities include:  WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, and LAYING.|
|`subject` | Integer| ID number between 1 and 30 representing the subject in the study.|

 The measurement variables for each participant and activity are below. In total, there are 66 measurements included in the tidy dataset. For more information on the measurement variable, refer to the ` features_info.txt` file included in the original data set from UCI Machine Learning Repository. The variable names from the original data has been modified (e.g. tBodyAcc-mean()-X --> tBodyAccmeanX). Note the variables were averaged by acitivity and subject. All measurements are in units of time and frequency (prefix 't' denotes time domain signals. prefix 'f' denotes frequency domain signals). 

| Variable | Type | Description |
| -------- | ---- | ----------- |
|`tBodyAccmeanX`| Numeric | Average mean value for body acceleration signals for X direction.|
|`tBodyAccmeanY`| Numeric | Average mean value for body acceleration signals for Y direction.|
|`tBodyAccmeanZ`| Numeric | Average mean value for body acceleration signals for Z direction.|
|`tBodyAccstdX` | Numeric | Average standard deviation value for body acceleration signals for X direction.|
|`tBodyAccstdY` | Numeric | Average standard deviation value for body acceleration signals for Y direction.|
|`tBodyAccstdZ` | Numeric | Average standard deviation value for body acceleration signals for Z direction.|
|`tGravityAccmeanX`| Numeric | Average mean value for gravity acceleration signals for X direction.|
|`tGravityAccmeanY`| Numeric | Average mean value for gravity acceleration signals for Y direction.|
|`tGravityAccmeanZ`| Numeric | Average mean value for gravity acceleration signals for Z direction.|
|`tGravityAccstdX` | Numeric | Average standard deviation value for gravity acceleration signals for X direction.|
|`tGravityAccstdY` | Numeric | Average standard deviation value for gravity acceleration signals for Y direction.|
|`tGravityAccstdZ` | Numeric | Average standard deviation value for gravity acceleration signals for Z direction.|
|`tBodyAccJerkmeanX` | Numeric | Average mean value for body acceleration jerk signals for X direction.|
|`tBodyAccJerkmeanY` | Numeric | Average mean value for body acceleration jerk signals for Y direction.|
|`tBodyAccJerkmeanZ` | Numeric | Average mean value for body acceleration jerk signals for Z direction.|
|`tBodyAccJerkstdX` | Numeric | Average standard deviation value for body acceleration jerk signals for X direction.|
|`tBodyAccJerkstdY`| Numeric | Average standard deviation value for body acceleration jerk signals for Y direction.|
|`tBodyAccJerkstdZ`| Numeric | Average standard deviation value for body acceleration jerk signals for Z direction.|
|`tBodyGyromeanX`| Numeric | Average mean value for body gyroscope signals for X direction.|
|`tBodyGyromeanY`| Numeric | Average mean value for body gyroscope signals for Y direction.|
|`tBodyGyromeanZ`| Numeric | Average mean value for body gyroscope signals for Z direction.|
|`tBodyGyrostdX`| Numeric | Average standard deviation for body gyroscope signals for X direction.|
|`tBodyGyrostdY`| Numeric | Average standard deviation for body gyroscope signals for Y direction.|
|`tBodyGyrostdZ`| Numeric | Average standard deviation for body gyroscope signals for Z direction.|
|`tBodyGyroJerkmeanX`| Numeric | Average mean value for body gyroscope jerk signals for X direction.|
|`tBodyGyroJerkmeanY`| Numeric | Average mean value for body gyroscope jerk signals for Y direction.|
|`tBodyGyroJerkmeanZ`| Numeric | Average mean value for body gyroscope jerk signals for Z direction.|
|`tBodyGyroJerkstdX`| Numeric | Average standard deviation for body gyroscope jerk signals for X direction.|
|`tBodyGyroJerkstdY`| Numeric | Average standard deviation for body gyroscope jerk signals for Y direction.|
|`tBodyGyroJerkstdZ`| Numeric | Average standard deviation for body gyroscope jerk signals for Z direction.|
|`tBodyAccMagmean`| Numeric | Average mean value for body acceleration magnitude signals.|
|`tBodyAccMagstd`| Numeric | Average standard deviation for body acceleration magnitude signals.|
|`tGravityAccMagmean`| Numeric | Average mean value for gravity acceleration magnitude signals.|
|`tGravityAccMagstd`| Numeric | Average standard deviation for gravity acceleration magnitude signals.|
|`tBodyAccJerkMagmean`| Numeric | Average mean value for body acceleration jerk magnitude signals.|
|`tBodyAccJerkMagstd`| Numeric | Average standard deviation for body acceleration jerk magnitude signals.|
|`tBodyGyroMagmean`| Numeric | Average mean value for body gyroscope magnitude signals.|
|`tBodyGyroMagstd`| Numeric | Average standard deviation for body gyroscope magnitude signals.|
|`tBodyGyroJerkMagmean`| Numeric | Average mean value for body gyroscope jerk magnitude signals.|
|`tBodyGyroJerkMagstd`| Numeric | Average standard deviation for body gyroscope jerk magnitude signals.|
|`fBodyAccmeanX`| Numeric | Average mean value for body acceleration signals with Fast Fournier Transform for X direction.|
|`fBodyAccmeanY`| Numeric | Average mean value for body acceleration signals with Fast Fournier Transform for Y direction.|
|`fBodyAccmeanZ`| Numeric | Average mean value for body acceleration signals with Fast Fournier Transform for Z direction.|
|`fBodyAccstdX`| Numeric | Average standard deviation value for body acceleration signals with Fast Fournier Transform for X direction.|
|`fBodyAccstdY`| Numeric | Average standard deviation value for body acceleration signals with Fast Fournier Transform for Y direction.|
|`fBodyAccstdZ`| Numeric | Average standard deviation value for body acceleration signals with Fast Fournier Transform for Z direction.|
|`fBodyAccJerkmeanX`| Numeric | Average mean value for body acceleration jerk signals with Fast Fournier Transform for X direction.|
|`fBodyAccJerkmeanY`| Numeric | Average mean value for body acceleration jerk signals with Fast Fournier Transform for Y direction.|
|`fBodyAccJerkmeanZ`| Numeric | Average mean value for body acceleration jerk signals with Fast Fournier Transform for Z direction.|
|`fBodyAccJerkstdX`| Numeric | Average standard deviation for body acceleration jerk signals with Fast Fournier Transform for X direction.|
|`fBodyAccJerkstdY`| Numeric | Average standard deviation for body acceleration jerk signals with Fast Fournier Transform for Y direction.|
|`fBodyAccJerkstdZ`| Numeric | Average standard deviation for body acceleration jerk signals with Fast Fournier Transform for Z direction.|
|`fBodyGyromeanX`| Numeric | Average mean value for body gyroscope signals with Fast Fournier Transform for X direction.|
|`fBodyGyromeanY`| Numeric | Average mean value for body gyroscope signals with Fast Fournier Transform for Y direction.|
|`fBodyGyromeanZ`| Numeric | Average mean value for body gyroscope signals with Fast Fournier Transform for Z direction.|
|`fBodyGyrostdX`| Numeric | Average standard deviation for body gyroscope signals with Fast Fournier Transform for X direction.|
|`fBodyGyrostdY`| Numeric | Average standard deviation for body gyroscope signals with Fast Fournier Transform for Y direction.|
|`fBodyGyrostdZ`| Numeric | Average standard deviation for body gyroscope signals with Fast Fournier Transform for Z direction.|
|`fBodyAccMagmean`| Numeric | Average mean value for body acceleration magnitude signals with Fast Fournier Transform.|
|`fBodyAccMagstd`| Numeric | Average standard deviation for body acceleration magnitude signals with Fast Fournier Transform.|
|`fBodyBodyAccJerkMagmean`| Numeric | Average mean value for body acceleration jerk magnitude signals with Fast Fournier Transform.|
|`fBodyBodyAccJerkMagstd`| Numeric | Average standard deviation for body acceleration jerk magnitude signals with Fast Fournier Transform.|
|`fBodyBodyGyroMagmean`| Numeric | Average mean value for body gyroscope magnitude signals with Fast Fournier Transform.|
|`fBodyBodyGyroMagstd`| Numeric | Average standard deviation for body gyroscope magnitude signals with Fast Fournier Transform.|
|`fBodyBodyGyroJerkMagmean`| Numeric | Average mean value for body gyroscope jerk magnitude signals with Fast Fournier Transform.|
|`fBodyBodyGyroJerkMagstd`| Numeric | Average standard deviation for body gyroscope jerk magnitude signals with Fast Fournier Transform.|

