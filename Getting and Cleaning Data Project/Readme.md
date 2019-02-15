# Getting and Cleaning Data Project
### Download the file "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
### Unzip file
### Load library dplyr
### Read data from directory

## 1.-Merges the training and the test sets to create one data set.

## 2.-Extracts only the measurements on the mean and standard deviation for each measurement.
### Search for variable names that contain "mean" or "std"
### Assign selected set to x_mean_sd

## 3.-Uses descriptive activity names to name the activities in the data set
### Transforms everything to lowercase
### Change letters in specific to capital
### Assign the names of the activities to y_label
### Assigns names to y_label and subject

## 4.-Appropriately labels the data set with descriptive variable names.
### Select variables containing mean and std
### Improves the names of the selected variables
### Merge the data into a single data set

## 5.-From the data set in step 4, creates a second, independent tidy data set with the
### Average of each variable for each activity and each subject.
### Detects the values of the dimensions of the variables
### Define variable and names to save the final result
### For loop to store the measurement averages for each subject and each activity
### Save the result in "tidy_data_set_means.txt"

