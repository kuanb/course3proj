coursera-getting-and-cleaning-data
==================================

Run Analysis Assignment

Introduction
------------
This repo holds the work of Kuan B. for the course project for the Coursera course "Getting and Cleaning data", part of the Data Science specialization.

About raw data
--------------

Test data set:
561 vars are unlabeled and held under x_test.txt. 
Activity labels for these vars are in the y_test.txt file.
Test subjects identification (nums 1:30) are in the subject_test.txt file.

Training set is same.

Length observations of train data set is 7352.
Length observations of test data set is 2947.

About script
------------
Script included called run_analysis.R which will merge the test and training sets together. What it does:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

About Code Book
---------------
CodeBook.md file describes the variables, the data, and any transformations or work that you performed to clean up the data.
