# DataCleaning Project

# run_analysis.R

# License:
# ========
# Use of this dataset in publications must be acknowledged by referencing the following publication [1] 
# [1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

# Stage 1 - setup parameters

# 0. Set working Dir
        cd <- getwd()
      setwd("E:/Users/duncan//R Programming//R DataCleaning//Data Cleaning Project//data")

#  1. Get the data
#  Made the assumption we have the data and have unzipped it
#  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = ".././ProjectData.zip", method = "curl")
#  dateDownloaded <- date()
#  dateDownloaded
#  [1] "Thu Dec 18 22:38:30 2014"

#  2. Unzip data
#  if (!file.exists("data")) {
#         dir.create("data")
#  } 
#  unzip("./ProjectData.zip", exdir = "./data/")

#  Assuming the directory structure and file locations are known - this might not be true in normal practice

        setwd("./UCI HAR Dataset")

# Get the required features columns (variables)
        features <- read.table(file = "./features.txt")
# Store the mean and std indexes for later
        wantedcols <- grep("(mean|std)\\(\\)",features$V2)

# Make the activity variable by combining the y_test and y_train files
        ytrain <- read.table(file = "./train//y_train.txt")
        ytest <- read.table(file = "./test/y_test.txt")
        activity <- rbind(ytest,ytrain)

# Prepare an activity names column by mapping the ids to names
        activitylabels <- read.table(file = "activity_labels.txt")
        activitynames <- as.character(activitylabels$V2)[activity$V1]

# Get the two subject files and set up the Subject column
        testsubject <- read.table(file = "./test//subject_test.txt")
        trainsubject <- read.table(file = ".//train//subject_train.txt")
        subject <- rbind(testsubject, trainsubject)

# Get the big test set of data
        xtest <- read.table(file = "./test/X_test.txt")
# Set the names for the test data
        colnames(xtest) <- features$V2
# Get the big train set of data
        xtrain <- read.table(file = "./train/X_train.txt")
# Set the names for the train data
        colnames(xtrain) <- features$V2

# Add a variable type to show whether test or train data
        type <- character(nrow(xtest)+nrow(xtrain))
        type[1:nrow(xtest)] <- "Test"
        type[nrow(xtest)+1:nrow(xtrain)] <- "Train"

# Create the big set of data
        data <- rbind(xtest,xtrain)
# Capture the current names of the data
        names <- names(data)
# Join the data with the subject, activity and activity name ( for easier reading)
        data <- cbind(subject,activity,activitynames,type,data)
# Update the names
        colnames(data) <-c("Subject","Activity","ActivityName","Type", as.character(names))

# Use previously selected active columns to remove anything but mean or std
        data2 <-data[,c(1:4,wantedcols+4)]

# Clean the variable names to get rid of non alpha chars
        names2 <-names(data2)
        names2 <- gsub(names2,pattern = "[-(),]", replacement = ""  )
        names(data2) <- names2

# Load dplyr
        library(dplyr)

# Group the data by Activity and then Subject
        tidy <- group_by(data2, ActivityName, Subject)

# Produce a tidyoutput with the group by names and averages of each variable
        tidyoutput <-summarise_each(tbl = tidy, funs(mean), c(-Type,-Activity))

# Write out the tidy data
        write.table( tidyoutput, row.name=FALSE ,file = "./tidyoutput.txt")

# Reset the working dir
        setwd(cd)

# To read the file back in use
#       View( read.table(file="tidyoutput.txt", header=T) )