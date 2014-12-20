# DataCleaning Project


#License:
#========
#Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[#1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

# Stage 1 - setup parameters

# 0. Set working Dir
        cd <- getwd()
        setwd("/Users/duncan/Documents/R Programming/R - Data Cleaning/CourseProject/data/")

# 1. Get the data

#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = ".././ProjectData.zip", method = "curl")
#> dateDownloaded <- date()
#> dateDownloaded
#[1] "Thu Dec 18 22:38:30 2014"

# 2. Unzip data
# if (!file.exists("data")) {
#         dir.create("data")
# } 
# unzip("./ProjectData.zip", exdir = "./data/")

# Assuming the directory structure and file locations are known - this might not be true in normal practice

setwd("./UCI HAR Dataset")

activitylabels <- read.table(file = "./Documents/R Programming/R - Data Cleaning/data/UCI HAR Dataset/features.txt")
# Get the required activity columns
actcols <- grep("(mean|std)\\(\\)",activitylabels$V2)
activitylabels[,2] <- gsub(activitylabels[,2],pattern = "[-(),]", replacement = ""  )
# read labels file
collabels <- read.table(file = "./Documents/R Programming/R - Data Cleaning/data/UCI HAR Dataset/features.txt")
# Get rid of invalid text in labels
collabels[,2] <- gsub(collabels[,2] ,pattern = "[-(),]", replacement = ""  )
colnames(testxset) <- collabels[,2]

#duplicated columns
collabels$V2[duplicated(collabels$V2)]
collabels$V2[grep("std|mean", collabels$V2)]

# Need to get measurements on mean & sd of data
# So can discard everything tht doesn't have mean and std in them



setwd(cd)