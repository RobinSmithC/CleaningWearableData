A description of variables, data and transformations used in run_analysis

widths:
variable. Used as parameter when reading files X_train.txt and x_test.txt. Widths specifies the column witdth of the values being read.

train_subject:
variable. The contents of subject_train.txt is read into this variable. Contains numbers representing subjects or persons who wore the smart phone and data was gathered from.

train_x:
variable. The measures collected from subjects. The contents of X_train.txt is read into this variable.

train_y.
Variable. The contents of y_train.txt. This file contains the activity as a number the subject performed. E.g. walking.

test_subject:
Variable. The second data set is test. This value is the same as train_subject but for the test data set.

test_x, test_y:
Variables. See train_x and train_y above. These are similar but apply to test data set.

activity_labels:
variable. Has a mappring with the activity (e.g. walking) and the activity id (e.g. 1). The activity id is used in other data files.

features_z:
Variable. This variable holds values from file, features.txt. The features are the measurements from the sensors on the phone captures. For example, the acceloration of the person carrying the phone. The features are summarised.

merged_test_x_train_x:
Variable. The test_x and train_x variables are combined into one and stored into merged_test_x_train_x.txt. The same applied to test_y and test_x but this is saved to merged_test_y_train_y. The same also applies to test_subject and train_subject. 

the data at this point is combined from two data sets into one data set. There remains three vairables whicholds the dataset.

The variables which are no longer needed are removed. merged_test_x_train_x, merged_test_y_train_y, merged_test_subject_train_subject remain. 

merged_test_x_train_x_tblf:
Variable. merged_test_x_train_x is converted into a data frame table. merged_test_x_train_x is removed after conversion.

merged_test_y_train_t_activity_tbldf:
Variable: Activity labels is now joined into the merged train and test data. This is a combination of merged_test_y_train_t_tbldf and activity variables. The variables are subsequenty removed.

merged_test_x_train_x_tbldf:
Variable. Contains the merged training and test data with the activity id and activity name.

merged_test_x_train_x_tbldf:
Variable. Now contains the subject.

At this point the data which was in three variables is now in 1 variable.

mean_std:
Variable. The columns with the average and standard deviation is extracted from the dataset. The variable is a table data frame.

subject_average_activity:
Variable. Extracts the subject, activity and all average values from merged_test_x_train_x_tbldf variable. This is the start to tidy the data. The subject_average_activity variable has many columns.

tidy_subject_average_activity:
Variable. the data in subject_average_activity is made tidy. That is each row is a single observation. The table now has 4 columns.
