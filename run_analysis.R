# USAGE: source("run_analysis.R")
library(plyr)
library(reshape2)

# Read 'features_info.txt'
# File captures the information about the variables used on the feature vector.
print("Reading FEATURE file...")
flush.console()
feature <- read.table("./features.txt", header = FALSE, col.names=c("id","name"))
reqCol <- grepl("mean\\(\\)|std\\(\\)", feature$name) 

# Read 'activity_labels.txt'
# File captures the the class labels with their activity name.
print("Reading ACTIVITY file...")
flush.console()
activity <- read.table("./activity_labels.txt", header = FALSE, col.names=c("id","Activity"))

# Rename Columns
feature$name <- gsub("tBody", "Time.Body", feature$name)
feature$name <- gsub("tGravity", "Time.Gravity", feature$name)
feature$name <- gsub("fBody", "FFT.Body", feature$name)
feature$name <- gsub("fGravity", "FFT.Gravity", feature$name)
feature$name <- gsub("\\-mean\\(\\)\\-", ".Mean.", feature$name)
feature$name <- gsub("\\-std\\(\\)\\-", ".Std.", feature$name)
feature$name <- gsub("\\-mean\\(\\)", ".Mean", feature$name)
feature$name <- gsub("\\-std\\(\\)", ".Std", feature$name)

# Read TEST file
# - 'test/X_test.txt': Test set.
# - 'test/y_test.txt': Test labels.
# - 'test/subject_test.txt": List of test subjects
# - Each feature vector is a row on the text file.
print("Reading TEST files...")
flush.console()
valTest <- read.table("./test/X_test.txt", header = FALSE, col.names=feature[,2]) ## REQ 4.Appropriately labels the data set with descriptive variable names.
valTest <- valTest[,reqCol] ## REQ 2: Extracts only the measurements on the mean and standard deviation for each measurement.
subTest <- read.table("./test/subject_test.txt", header = FALSE, col.names=c("Subject"))
idTest <- read.table("./test/y_test.txt", header = FALSE, col.names=c("Activity.ID"))
dataTest <- cbind(subTest, idTest, valTest) #Bind to a single data set, with Subject, Activity and Features

# Read TRAIN file
# - 'train/X_train.txt': Training set.
# - 'train/y_train.txt': Training labels.
# - 'train/subject_train.txt": List of training subjects
# - Each feature vector is a row on the text file.
print("Reading TRAIN files...")
flush.console()
valTrain <- read.table("./train/X_train.txt", header = FALSE, col.names=feature[,2]) ## REQ 4: Appropriately labels the data set with descriptive variable names. 
valTrain <- valTrain[,reqCol] ## REQ 2: Extracts only the measurements on the mean and standard deviation for each measurement.
subTrain <- read.table("./train/subject_train.txt", header = FALSE, col.names=c("Subject"))
idTrain <- read.table("./train/y_train.txt", header = FALSE, col.names=c("Activity.ID"))
dataTrain <- cbind(subTrain, idTrain, valTrain)

# Merge TEST and TRAIN data
## REQ 1: Merges the training and the test sets to create one data set.
tidy <- rbind(dataTest, dataTrain)

## REQ 3: Uses descriptive activity names to name the activities in the data set
tidy <- merge(tidy, activity, by.x="Activity.ID", by.y="id")

## REQ 5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
idLabels   <- c("Subject", "Activity.ID", "Activity")
dataLabels <- setdiff(colnames(tidy), idLabels)
meltData <- melt(tidy, id = idLabels, measure.vars = dataLabels)
# Apply mean function to dataset using dcast function
tidyMean <- dcast(meltData, Subject + Activity.ID + Activity ~ variable, mean)

# Write output into a file
print("Writing Tidy + Mean file...")
flush.console()
write.table(tidyMean, file="./tidy_mean.txt", sep="\t", row.names=FALSE)
write.table(tidy, file="./tidy.txt", sep="\t", row.names=FALSE)