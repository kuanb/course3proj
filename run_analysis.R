
# You should create one R script called run_analysis.R that does the following:

# 1. Merges the training and the test sets to create one data set.

# Open the txt files as tables
subj_test <- read.table("/Users/kuanbutts/Documents/MIT/Summer2014/Coursera/Course 3/course3proj/ucidataset/test/subject_test.txt")
subj_train <- read.table("/Users/kuanbutts/Documents/MIT/Summer2014/Coursera/Course 3/course3proj/ucidataset/train/subject_train.txt")

# Join data together using row bind, to reconnect test and training data (for x first, then y later)
x_test <- read.table("/Users/kuanbutts/Documents/MIT/Summer2014/Coursera/Course 3/course3proj/ucidataset/test/X_test.txt")
x_train <- read.table("/Users/kuanbutts/Documents/MIT/Summer2014/Coursera/Course 3/course3proj/ucidataset/train/X_train.txt")
com_x <- rbind(cbind(subj_test, x_test), cbind(subj_train, x_train))

# Apply the column titles via features.txt file
features <- read.table("/Users/kuanbutts/Documents/MIT/Summer2014/Coursera/Course 3/course3proj/ucidataset/features.txt")
names(com_x) <- c(c("subj_num", as.character(features[,2])))

y_test <- read.table("/Users/kuanbutts/Documents/MIT/Summer2014/Coursera/Course 3/course3proj/ucidataset/test/y_test.txt")
y_train <- read.table("/Users/kuanbutts/Documents/MIT/Summer2014/Coursera/Course 3/course3proj/ucidataset/train/y_train.txt")
com_y <- rbind(y_test, y_train)

# Join the x and y data together by binding columns
com_tot <- cbind(com_x, com_y)
names(com_tot)[563] <- "y_vals"

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

# First I need arrays telling me which columns have "mean" and "std" in them
meanCols <- grep("mean", colnames(com_tot))
stdCols <- grep("std", colnames(com_tot))

# Now I combine and sort of two arrays and create a new version of com_tot that is just those columns
desiredCols <- sort(c(grep("mean", colnames(com_tot)), grep("std", colnames(com_tot))))
desDF <- com_tot[desiredCols]

# Re-adding y-vals from before
desDF <- cbind(desDF, com_y)
names(desDF)[length(desDF)] <- "y_vals"

# Re-adding subject numbers
desDF <- cbind(com_x["subj_num"], desDF)
names(desDF)[1] <- "subj_num"

# 3. Uses descriptive activity names to name the activities in the data set.

# Not needed / already done because I named everything prior, and retained values throughout column removals

# 4. Appropriately labels the data set with descriptive variable names.

# I am assuming that this is the y-vals column I created and just associating the numbers with the activity_labels.txt names
actLabels <- read.table("/Users/kuanbutts/Documents/MIT/Summer2014/Coursera/Course 3/course3proj/ucidataset/activity_labels.txt")[,2]
desDF[length(desDF)+1] = NA
names(desDF)[length(desDF)] <- "act_type"

for (i in 1:length(desDF[,1])) {
        rowValY <- desDF[i,"y_vals"]
        desDF[i,"act_type"] <- actLabels[rowValY]
}

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Make sure both subject and activity are factors
desDF[,1] <- as.factor(desDF[,1])
desDF[,length(desDF)] <- as.factor(desDF[,length(desDF)])

# New DF of means
finDF <- aggregate(desDF, by=list(activity = desDF$act_type, subject=desDF$subj_num), mean)

# Get rid of y_vals column, we don't need it any more
finDF[length(finDF)-1] <- NULL

# Also get rid of subject and activity columns since their means don't make sense
finDF["act_type"] <- NULL
finDF["subj_num"] <- NULL

# Finally write to a .txt file
write.table(finDF, "tidy.txt", sep="\t")
