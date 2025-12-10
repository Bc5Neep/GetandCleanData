# First load necessary packages
library(tidyr)
library(dplyr)
library(data.table)
library(stringr)
library(tibble)
# Then, load individual data files into R

# Train data
sub_train<- fread(file.choose("subject_train.txt"))

train_activity<- fread(file.choose("y_train.txt"))

train_raw_value<- fread(file.choose("X_train.txt"))

# Test data
sub_test<- fread(file.choose("subject_test.txt"))

test_activity <- fread(file.choose("y_test.txt"))

test_raw_value <- fread(file.choose("X_test.txt"))

# Features
feature_names <- fread(file.choose("features.txt"))

# Rename columns (Train)
names(sub_train)[1] <- "subject"
names(train_activity)[1] <- "activity"

# Rename columns (Test) 
names(sub_test)[1] <- "subject"
names(test_activity)[1] <- "activity"


# Transform numerical values from activity into actual activities
activity_labels <- c("1" = "Walking", "2" = "Walking_Upstairs", "3" = "Walking_Downstairs", "4" = "Sitting", "5" = "Standing", "6" = "Laying")

# Update activity columns
train_activity$activity <- activity_labels [as.character(train_activity$activity)]

test_activity$activity <- activity_labels [as.character(test_activity$activity)]

# Now values are actual activities, combine subject and activity into two column data frame for;
#Train data
train_df <- cbind(sub_train, train_activity)
#Test data
test_df <- cbind(sub_test, test_activity)
# Number columns of raw values 1:561 instead of V1:561 (optional)   
# Train
colnames(train_raw_value) <- as.character (1:561)
# Test
colnames(test_raw_value) <- as.character (1:561)

# Return to feature data frame. 
# Flip orientation (make columns rows and vice versa) using transpose function.

Features <- as.data.frame(t(feature_names))

# Remove numbered top row 
Feature_Names <- Features[-1,]

# Transfer column names from Feature_Names to train_raw_value
# Replace column names from train_raw_value with those from Feature_Names

colnames(train_raw_value) <-as.character(Feature_Names[1:ncol(train_raw_value)])

# Repeat with test_raw_value

colnames(test_raw_value) <- as.character(Feature_Names[1:ncol(test_raw_value)])

# Create master data frame of train and test features

Features_Master <- rbind(train_raw_value, test_raw_value)

# Create data frame filtered by mean and standard deviation features
Features_Mean_Std_Filtered <- Features_Master %>% 
  select(contains("mean"), contains("std"))


# Create master data frame of train and test subject and activity data
Subject_Activity_Master <- rbind(train_df, test_df)

# Merge to assemble complete HAR dataset data frame

Train_Test_Merge <-cbind(Subject_Activity_Master, Features_Master) 


# Order rows in merged data frame by subject number  
Train_Test_Ordered <- Train_Test_Merge[order(Train_Test_Merge[[1]],)]

TT_Mean_Std_Filtered <- cbind(Subject_Activity_Master,Features_Mean_Std_Filtered)

# Order rows in merged data frame by subject number

TTO_Mean_Std_Filtered <- TT_Mean_Std_Filtered[order(TT_Mean_Std_Filtered[[1]],)]

# Obtain mean values for each iterative feature measurement by subject and activity
# Avoid duplicate row errors by giving unique names 
names(Train_Test_Ordered) <-make.unique(names(Train_Test_Ordered))

# Master HAR data set means

HAR_Means_Master <- Train_Test_Ordered %>%
  group_by(subject, activity) %>%
  summarise(across(where(is.numeric), mean, na.rm = TRUE), .groups = "drop")

# Data set filtered by features containing mean and standard deviation measurements

HAR_Means_Filtered <- TTO_Mean_Std_Filtered %>%
  group_by(subject, activity) %>%
  summarise(across(where(is.numeric), mean, na.rm = TRUE), .groups = "drop")