# 
# This program reads data from the Human Activity Recognition Using Smartphone
# Data Set from the UCI Machine Learning Repository
# 
# This script should be executed from a directory containing the files from this
# archive: 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# 
# It reads data from the test and train directories and outputs a tidy subset of
# the data. See README.md for more details about what data is extracted and why
# 
library(reshape2)

#rowLimit = 100  #For testing on a small set of data
rowLimit = ""  #For full data

### Merge the training and testing data

#Get set of attributes and descriptions
Xmeta = read.delim("features.txt", sep="", header=F, 
                   col.names=c("index", "attr"))

#Strip off the () from attr names for simplicity
Xmeta$attrClean = gsub("\\(\\)","",Xmeta$attr)

## Load test data with useful column names
testSubjectData = read.delim("test//subject_test.txt",header=F, nrow=rowLimit, 
                             col.names=c("Subject"))
testXData = read.delim("test//X_test.txt", header=F, sep="", nrow=rowLimit, 
                       col.names=Xmeta$attrClean)
testYData = read.delim("test//y_test.txt", header=F, nrow=rowLimit, 
                       col.names=c("ActivityCode"))

##Load training data with useful column names
trainSubjectData = read.delim("train//subject_train.txt",header=F, nrow=rowLimit, 
                              col.names=c("Subject"))
trainXData = read.delim("train//X_train.txt", header=F, sep="", nrow=rowLimit,
                        col.names=Xmeta$attrClean)
trainYData = read.delim("train//y_train.txt", header=F, nrow=rowLimit, 
                        col.names=c("ActivityCode"))

### Keep only the XData columns we really care about, the mean() and std() measures
### See README.md for more details
meanAttrs = grep("mean\\(\\)", Xmeta$attr)
stdAttrs= grep("std\\(\\)", Xmeta$attr)
keepAttrs = sort(union(meanAttrs, stdAttrs))

testXData = testXData[,keepAttrs]
trainXData = trainXData[,keepAttrs]

### Merge the data
## - Merge all of test data (subject, activity, measurements)
## - Merge all of training data (same order)
## - Merge test and training into one set
fullTest = cbind(testSubjectData, testYData, testXData)
fullTrain = cbind(trainSubjectData, trainYData, trainXData)
completeData = rbind(fullTest, fullTrain)

### Translate activity codes into activity descriptions, then drop the code column
activityLookup = read.delim("activity_labels.txt", header=F, sep="", 
                            col.names=c("ActivityCode", "ActivityDescription"))
completeData = merge(completeData, activityLookup, by.x="ActivityCode", 
                     by.y="ActivityCode")
completeData$ActivityCode <- NULL

### Average all of the measurements
melted = melt(data=completeData, id=c("Subject", "ActivityDescription"))
recastData = dcast(melted, Subject + ActivityDescription ~ variable, mean)

### Output tidy data set, averaged by subject and activity
print(write.table(recastData, file="output.txt", row.names=F))
