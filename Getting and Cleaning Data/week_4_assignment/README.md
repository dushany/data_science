# Getting and Cleaning Data Project

This is the project assigment for week 4 of the course, Getting and Cleaning Data. The assignment
uses data collected from accelerometers of Samsung Galaxy S smartphones carried by 30 subjects who 
volunteered to participate in a Human Activity Recognition (HAR) study. For more information on the
study, refer to the following link: [UCI HAR Dataset](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The purpose of the assignment is to take the raw data from the study and transform it into a tidy data set. 
The R script, `run_analysis.R`, developed for this task specifically does the following:

1. Downloads the dataset from the Machine Learning Repository, if it does not exist in the working directory.
2. Loads the "test" set and "train" set for measurements and combines them into one dataset.
3. Loads the variable names, adds them to the dataset created for measurements, subsets the dataset to obtain mean
   and standard deviation measurements.
4. Loads activity data for the "test" set and "train" set and combines them into one dataset. Loads activity descriptions
   and merges the descriptions with the activity dataset.
5. Loads subject IDs for the "test" set and "train" set and combines them into one dataset. 
6. Combines the datasets created in steps 3,4, and 5 to create a single dataset.
7. Creates a second tidy dataset with the averages of each mean and standard deviation measurement, grouped by acitivity and
   subject.

The resulting tidy dataset has been written to a text file. See `tidy_dataset.txt`.
