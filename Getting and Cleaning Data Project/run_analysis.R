#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
#destfile = "getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
#method = "curl")

#unzip("getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
library(dplyr)


#read data from directory
Features <- read.table("./UCI HAR Dataset/features.txt")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

#1.-Merges the training and the test sets to create one data set.
x <- rbind(X_train,X_test)
y <- rbind(Y_train,Y_test)
subject <- rbind(subject_train,subject_test)



#2.-Extracts only the measurements on the mean and standard deviation 
#for each measurement.

#search for variable names that contain "mean" or "std"
index_mean_sd <- grep("[Mm]ean\\(\\)|[Ss]td\\(\\)",Features$V2)

#assign selected set to x_mean_sd
x_mean_sd <- x[,index_mean_sd]



#3.-Uses descriptive activity names to name the activities in the data set

#transforms everything to lowercase
activity_labels$V2 <- tolower(gsub("_", "", activity_labels$V2))

#Change letters in specific to capital
substr(activity_labels$V2[2],8,8) <- toupper(substr(activity_labels$V2[2],8,8))
substr(activity_labels$V2[3],8,8) <- toupper(substr(activity_labels$V2[3],8,8))

#assign the names of the activities to y_label
y_label <- data.frame((activity_labels[y[,1],2]))

#Assigns names to y_label and subject
names(y_label) <- "activity"
names(subject) <- "subject"



#4.-Appropriately labels the data set with descriptive variable names.
#select variables containing mean and std
Features_mean_sd<-Features[index_mean_sd,]

#improves the names of the selected variables
names(x_mean_sd) <- Features_mean_sd$V2
names(x_mean_sd) <- gsub("\\(\\)", "", Features_mean_sd$V2)
names(x_mean_sd) <- gsub("std", "Std", names(x_mean_sd))
names(x_mean_sd) <- gsub("mean", "Mean", names(x_mean_sd))
names(x_mean_sd) <- gsub("-", "", names(x_mean_sd))

#merge the data into a single data set
Data_mean_sd <- cbind(subject,y_label,x_mean_sd)



#5.-From the data set in step 4, creates a second, independent tidy data set with the
#average of each variable for each activity and each subject.

#detects the values of the dimensions of the variables
sub_dim <- length(table(subject)) 
act_dim <- dim(activity_labels)[1] 
dms_dim <- dim(Data_mean_sd)[2]

#define variable and names to save the final result
tidy_data_set <- matrix(NA, nrow=sub_dim*act_dim, ncol=dms_dim) 
tidy_data_set <- as.data.frame(tidy_data_set)
colnames(tidy_data_set) <- colnames(Data_mean_sd)
row <- 1

#for loop to store the measurement averages for each subject and each activity
for(i in 1:sub_dim) {
      for(j in 1:act_dim) {
            tidy_data_set[row, 1] <- sort(unique(subject)[, 1])[i]
            tidy_data_set[row, 2] <- activity_labels[j, 2]
            bool1 <- i == Data_mean_sd$subject
            bool2 <- activity_labels[j, 2] == Data_mean_sd$activity
            tidy_data_set[row, 3:dms_dim] <- colMeans(Data_mean_sd[bool1&bool2, 3:dms_dim])
            row <- row + 1
      }
}

#save the result in "tidy_data_set_means.txt"
write.table(tidy_data_set, "tidy_data_set_means.txt",row.names = FALSE)
