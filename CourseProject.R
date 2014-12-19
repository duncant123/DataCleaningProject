# DataCleaning Project


# 0. Set working Dir
setwd("/Users/duncan/Documents/R Programming/R - Data Cleaning/")

# 1. Get the data

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "./ProjectData.zip", method = "curl")
> dateDownloaded <- date()
> dateDownloaded
[1] "Thu Dec 18 22:38:30 2014"

# 2. Unzip data
if (!file.exists("data")) {
        dir.create("data")
}
unzip("./ProjectData.zip", exdir = "./data/")
