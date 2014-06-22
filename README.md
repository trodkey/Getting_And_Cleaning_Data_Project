Getting_And_Cleaning_Data_Project
=================================

Course Project - run_analysis.R

This script processes the data acquired by Samsung smartphones attached to the waists of 30 subjects in a study conducted by Reyes-Ortiz et al. in the Human Activity Recognition lab at UCI and produces a tidy data set.  The output of this script is the mean of the measurements of each subject engaged in 6 activities (Walking, Walking Downstairs, Walking Upstairs, Sitting, Standing, and Laying) and the respective standard deviations.

Data collected in the study were from the accelerometers and gyroscopes embedded in the smartphones for the x, y, and z axes of movement for each subject.  Data on acceleration were measured at 50 Hz in xg and data on angular velocity were measured in radians/second.  Data were normalized and range from -1 to 1.  Data were divided into a training set (70% of total data) and a test set (30% of total data).

This script takes as input 6 files in the R working directory:
1) X_test
2) test_y
3) X_train
4) train_y
5) subject_test
6) subject_train

Where X_test and X_train contain the measured data in columns to be processed for the test and training sets, respectively.  Data not including the mean or standard deviation e excluded by subsetting.  y_test and y_train contain the numbers of activity description per row of X_test or X_train that correspond to the descriptions found in activity_labels.txt. Subject_test and subject_train contain the values of subject participant number that correspond to a particular row in X_test or X_train, respectively.

The script processes test_y and train_y data to correspond to the descriptive activity labels  in activity_labels.txt.  Next, the script concatenates the raw data in X_test and X_train into a single dataframe then replaces the resulting column numbers with names denoting the type of measurement (acceleration or angular velocity in x, y, or z for a particular type of movement) in features.txt.  Subsetting extracts the columns containing means or standard deviations (79 columns) from the larger data set (561 columns).

The extracted dataset is then sorted by subject number and activity and a nested loop used to compute the mean for each activity type for each subject number, and the resulting data stored in a new dataframe by subject, resulting a dataframe with 180 rows and 81 columns (79 data + 1 for subject number and 1 for activity description).

The final dataframe is written out to a .txt file with write.table and contains the descriptive column names found in features.txt.




