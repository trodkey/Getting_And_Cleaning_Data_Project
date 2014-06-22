Getting_And_Cleaning_Data_Project
=================================

Course Project - run_analysis.R

This script processes the data acquired by Samsung smartphones attached to the waists of 30 subjects in a study conducted by Reyes-Ortiz et al. in the Human Activity Recognition lab at UCI and produces a tidy data set.  The output of this script is the mean of the measurements of each subject engaged in 6 activities (Walking, Walking Downstairs, Walking Upstairs, Sitting, Standing, and Laying) and the respective standard deviations.

Data collected in the study were from the accelerometers and gyroscopes embedded in the smartphones for the x, y, and z axes of movement for each subject.  Data on acceleration were measured at 50 Hz in xg and data on angular velocity were measured in radians/second.  Data were normalized and range from -1 to 1.  Data were divided into a training set (70% of total data) and a test set (30% of total data).

This script takes as input 6 files in the R working directory:
1) test_x
2) test_y
3) train_x
4) train_y
5) subject_x
6) subject_y



