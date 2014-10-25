GettingCleaningDataProject
==========================

######
### Introduction
######

The purpose of this project is to collect, work with, and clean a data set. 
The goal is to prepare tidy data that can be used for later analysis. 

One of the most exciting areas in all of data science right now is wearable computing.
Ref Article: http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/

Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. 
The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 
A full description is available at the site where the data was obtained:
	http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Data for the project:
	https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

######
### Assignment
######

To create one R script called run_analysis.R that does the following. 
	1. Merges the training and the test sets to create one data set.
	2. Extracts only the measurements on the mean and standard deviation for each measurement. 
	3. Uses descriptive activity names to name the activities in the data set
	4. Appropriately labels the data set with descriptive variable names. 
	5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

######
### The Sciprt: run_analysis.R
######

Step 1: Load 'features_info.txt'. The File captures the information about the variables used on the feature vector.
Step 2: Load 'activity_labels.txt'. The File captures the the class labels with their activity name.
Step 3: Rename the Columns (activity labels) to desciptive activity names
Step 4: Load TEST data files. Each feature vector is a row on the text file. 
	Extracts only the measurements on the mean and standard deviation for each measurement.
	- 'test/X_test.txt': Test set.
	- 'test/y_test.txt': Test labels.
	- 'test/subject_test.txt": List of test subjects
Step 5: Load TRAIN data files. Each feature vector is a row on the text file. 
	Extracts only the measurements on the mean and standard deviation for each measurement.
	- 'train/X_train.txt': Training set.
	- 'train/y_train.txt': Training labels.
	- 'train/subject_train.txt": List of training subjects
Step 6: Merges the training and the test sets to create one data set.
Step 7: Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Step 8: Write output into a file