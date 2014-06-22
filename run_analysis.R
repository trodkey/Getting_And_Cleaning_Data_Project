# Create an empty data frame to store the tidy data output
act_df <- data.frame()

## Pull in test data files
test_y <- read.table("./Desktop/Coursera/UCI HAR Dataset/test/y_test.txt") # 2947 rows
subject_test <- read.table("./Desktop/Coursera/UCI HAR Dataset/test/subject_test.txt") #2947 rows

## Replace numbers in test_y with Descriptive Activity Labels
activity_vec <- c("WALKING", "WALKING UPSTAIRS", "WALKING DOWNSTAIRS", "SITTING", "STANDING", "LAYING")

for(i in 1:length(test_y[,1])) {
  
  if (test_y[i,1] == 1) {
    test_y[i,1] <- activity_vec[1]
  } 
  if (test_y[i,1] == 2) {
    test_y[i,1] <- activity_vec[2]
  } 
  if (test_y[i,1] == 3) {
    test_y[i,1] <- activity_vec[3]
  } 
  if (test_y[i,1] == 4) {
    test_y[i,1] <- activity_vec[4]
  } 
  if (test_y[i,1] == 5) {
    test_y[i,1] <- activity_vec[5]
  } 
  if (test_y[i,1] == 6) {
    test_y[i,1] <- activity_vec[6]
  } 
}

## Pull in train_y data 
train_y <- read.table("./Desktop/Coursera/UCI HAR Dataset/train/y_train.txt") #7352 rows
subject_train <- read.table("./Desktop/Coursera/UCI HAR Dataset/train/subject_train.txt") #7352 rows

## Replace numbers in train_y with Descriptive Activity Labels
for(i in 1:length(train_y[,1])) {
  
  if (train_y[i,1] == 1) {
    train_y[i,1] <- activity_vec[1]
  } 
  if (train_y[i,1] == 2) {
    train_y[i,1] <- activity_vec[2]
  } 
  if (train_y[i,1] == 3) {
    train_y[i,1] <- activity_vec[3]
  } 
  if (train_y[i,1] == 4) {
    train_y[i,1] <- activity_vec[4]
  } 
  if (train_y[i,1] == 5) {
    train_y[i,1] <- activity_vec[5]
  } 
  if (train_y[i,1] == 6) {
    train_y[i,1] <- activity_vec[6]
  } 
}

## Append test_y to test_x to label the rows
activity_df <- rbind(test_y, train_y)

subject_num_df <- rbind(subject_test, subject_train) #10299 rows

# Concatenate complete unlabeled unextracted data, 10299 rows
test_x <- read.table("./Desktop/Coursera/UCI HAR Dataset/test/X_test.txt")
train_x <- read.table("./Desktop/Coursera/UCI HAR Dataset/train/X_train.txt")
x_complete_data <- rbind(test_x, train_x)  

## Replace the column numbers with Descriptive Feature Names from features.txt
featuresframe <- read.table("./Desktop/Coursera/UCI HAR Dataset/features.txt")
col_names_vector <-  as.vector(featuresframe[,2])  # put descriptive names into a vector
colnames(x_complete_data) <- col_names_vector  #replace column numbers with descriptive names in the vector
cols_to_keep <- grep("mean|std", col_names_vector)  # fish out the columns with mean and SD data
mean_sd_frame <- x_complete_data[, cols_to_keep] # subset the columns with mean and SD data
temp_df <- cbind(activity_df[1], mean_sd_frame) # Add the Descriptive Activity Labels
final_frame <- cbind(subject_num_df[1], temp_df) # Add the Subject Numbers

# Create empty data frame to fill with column means later
MT_df <- as.data.frame(matrix(nrow = 1, ncol = 81))
colnames(MT_df) <- colnames(final_frame)
MT_df <- MT_df[-1, , drop=FALSE]

## Put the Column Names on the first two columns
colnames(final_frame)[1] <- "Subject_Number"
colnames(final_frame)[2] <- "Activity"

## Sort the dataframe by Subject Number and Activity
sorteddf<-final_frame[order(final_frame[,1],final_frame[,2]) , ]

## Loop through the dataframe by Subject Number then Activity, compute column mean, and add to a new dataframe
row_num <- 3:81  # 81 columns, minus 2 for Subject Number and Activity
temp_frame <- data.frame() 

subject_list <- 1:30  # 30 subject numbers forms outside loop

for (j in subject_list) {
  
  subject_block_df <-sorteddf[(which(sorteddf[,1]==j)),] ## Extract all rows for a subject number
  
  for (k in activity_vec) {
  
    activity_block_df <- subject_block_df[(which(subject_block_df[,2]==k)),] ## Extract all rows within the subject number for a given activity
    
    for (o in row_num) {  ## Cycle through the 79 columns
      tempvar <- mean(activity_block_df[,o]) # get the mean of each column
      MT_df[1,o] <- tempvar  ## fill the column position in a single row DF with the column mean
      MT_df[,2] <- k    ## Add the Activity Description to the row
      MT_df[,1] <- j    ## Add the Subject Number to the row
    }
  
    act_df <- rbind(act_df, MT_df)  ## Concatenate the new data into a single new dataframe
  
  }
    
}
## Add column labels to columns 1 and 2 of the new dataframe to output, Subject Number and Activtty
colnames(act_df)[1] <- "Subject_Number"
colnames(act_df)[2] <- "Activity"

## Write the output to a .txt file tab delimited
write.table(act_df, "./tidy_data.txt", sep="\t")
