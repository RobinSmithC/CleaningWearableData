library('dplyr')
library('tidyr')

# Parameter value for read.fwf function. The data is provided in a fixed width file consisting of 561 entries per line.
# widths holds a vector with 561 values of 16. Each value in the X_train.txt and X_test.txt files is 16 characters long.
widths <- rep(c(16) 561)

# Reads the data. In this case the subject who is a person represented by a number 1:30
train_subject <- read.csv('UCI HAR Dataset/train/subject_train.txt', sep = " ", header = FALSE, numerals = "no.loss")
# Read the associated training data
train_x <- read.fwf('UCI HAR Dataset/train/X_train.txt', widths, header = FALSE)
# Read the associated activity the subject was performing
train_y <- read.csv('UCI HAR Dataset/train/y_train.txt', sep = " ", header = FALSE, numerals = "no.loss")
# Name the activity column for the associated activity
names(train_y) <- c('ActivityId')

# The data was split in two sets. This portion is the test portion and is manupulation is the same as train data above.
test_subject <- read.csv('UCI HAR Dataset/test/subject_test.txt', sep = " ", header = FALSE, numerals = "no.loss")
test_x <- read.fwf('UCI HAR Dataset/test/X_test.txt', widths, header = FALSE)
test_y <- read.csv('UCI HAR Dataset/test/y_test.txt', sep = " ", header = FALSE, numerals = "no.loss")
names(test_y) <- c('ActivityId')

# For the activity data, set friendly labels
activity_labels <- read.csv ('UCI HAR Dataset/activity_labels.txt', sep = " ", header = FALSE)
c("ActivityId","ActivityName") -> names(activity_labels)

# The features label the test and train data collected
features_z <- read.csv('UCI HAR Dataset/features.txt', sep = "\n", header = FALSE, numerals = "no.loss")
# Change the features 
features_z <- as.vector(features_z[,1])

# Label the test and train data columns with the features. Some features are:
# 1 tBodyAcc-mean()-X
# 2 tBodyAcc-mean()-Y
# 3 tBodyAcc-mean()-Z
# 4 tBodyAcc-std()-X
# 5 tBodyAcc-std()-Y
# There are 561 of these.
colnames(train_x) <- features_z
colnames(test_x) <- features_z

# The data is across three files and read into 3 variables. The test and training data is combined into one.
# The data will exist in 3 variables but the data is now combined.
merged_test_x_train_x <- rbind(test_x, train_x)
merged_test_y_train_y <- rbind(test_y , train_y)
merged_test_subject_train_subject <- rbind (test_subject, train_subject)

# There is a lot of data so removing variables is a good idea to keep memory consumption at a minumum.
# The train and test data read, also remove the associated activities and subjects (persons).
rm(train_x, test_x)
rm(train_y, test_y)
rm(test_subject)
rm(train_subject)

# convert the merged data set into a table data frame used by dplyr package.
merged_test_x_train_x_tbldf <- tbl_df(merged_test_x_train_x)
# remove the old variable.
rm(merged_test_x_train_x)

# convert the data frame into a table data frame
merged_test_y_train_t_tbldf <- tbl_df( merged_test_y_train_y )
# remove the old data frame -- keeping memory tidy
rm ( merged_test_y_train_y )

# Add the activity labels (e.g. walking, running) to the test and train data. This is done by using activityid column.
merged_test_y_train_y_activity_tbldf <- join ( merged_test_y_train_t_tbldf , activity_labels , ActivityId )

# convert the resulting data frame into a table data frame.
merged_test_y_train_y_activity_tbldf <- tbl_df ( merged_test_y_train_y_activity_tbldf )
# The activity labels is no longer required and well as the old table which does not have the activity labels.
rm(merged_test_y_train_t_tbldf, activity_labels)

# add the activity id and the activity name to the test and train data.
merged_test_x_train_x_tbldf <- cbind ( merged_test_x_train_x_tbldf , merged_test_y_train_y_activity_tbldf[,1] , merged_test_y_train_y_activity_tbldf[,2] )
# remove the activity data since it was added to the training data.
rm(merged_test_y_train_y_activity_tbldf)
# convert to a table data frame.
merged_test_x_train_x_tbldf <- tbl_df ( merged_test_x_train_x_tbldf )

# Add the subject (person) to the data. The data now include the subject, activity, and the measures for each activity
merged_test_x_train_x_tbldf <- cbind ( subjects = merged_test_subject_train_subject[,1] ,  merged_test_x_train_x_tbldf )
# Convert to a table data frame. This will process data faster and make manuiplation available usign the dplyr library.
merged_test_x_train_x_tbldf <- tbl_df ( merged_test_x_train_x_tbldf )

# Extract standard deviation and mean measurements.
mean_std <- select ( merged_test_x_train_x_tbldf , contains("mean") , contains("std") )

# obtain the subjects, activity name and metrics
subject_average_activity <- select ( merged_test_x_train_x_tbldf , subjects, ActivityName , contains("mean") )
# The data is not tidy, observations are variables. This statement creates a row for each observation instead of having them in columns.
tidy_subject_average_activity <- gather ( subject_average_activity , metric , metricValue, -(1:2) )
# clean up the old variable no longer needed.
rm(subject_average_activity)

