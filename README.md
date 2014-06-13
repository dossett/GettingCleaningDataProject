GettingCleaningDataProject
==========================

This project is capable of reading data from the Human Activity Recognition Using Smartphone Data Set from the UCI Machine Learning Repository.  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The testing and training data is merged together and a subset of the data is output in a tidy format that averages the means and standard deviations of several measurements.  See below for more details about this process.

Running the Program
===================

Extract data from the UCI Machine learning repository and execute the run_analysis.R script in that directory.  A file called "output" will be written to the same directory.  This file can be read by R with the read.table() function.

Data Analysis and Transformation
================================

## Step 1 - Merging the Training and Testing data sets
