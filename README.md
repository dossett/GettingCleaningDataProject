GettingCleaningDataProject
==========================

This project is capable of reading data from the Human Activity Recognition Using Smartphone Data Set from the UCI Machine Learning Repository.  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The testing and training data is merged together and a subset of the data is output in a tidy format that averages the means and standard deviations of several measurements.  See below for more details about this process.

Running the Program
===================

Extract data from the UCI Machine learning repository and execute the run_analysis.R script in that directory.  A file called "output" will be written to the same directory.  This file can be read by R with the read.table() function.

Data Analysis and Transformation to a Tidy Data Set
===================================================

## Merging the Training and Testing data sets
These two data sets are combined into a single data set
## Extract the mean and standard devitation measures
The list of measurements is defined in the features.txt file from the UCI data set.  We extract the measurements containing the strings "mean()" and "std()" but not measurements like meanFreq().  Per several discussions in the class discussion board, including or excluding these measurements is acceptable if documented.
## Translate the Activity Codes (1, 2, 3,...) into Descriptions ("WALKING", "WALKING_UPSTAIRS", ...)
The file activity_labels.txt contains this mapping.  The data sets contain codes which are translated according to this mapping
## Apply data lables
The original data sets do not contain data lables, but the variable names are specified in features.txt.  These variable names are applied to the data.  NOTE: The "()" characters are removed from the variable names since they are not cleanly translated in R.
## Create the final tidy data set that averages each variable
All of the variables that we keep (the mean() and std() variables) are averaged by (subject, activity) pair and written out to the "output" file.  For example, before summarization we could have ten rows for (subject 1, walking) and after summarization we will have one row and the variables will represent each variable's average from those original 10 rows
