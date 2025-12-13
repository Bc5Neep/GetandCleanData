# CodeBook 

## Experimental summary overview

* The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
* Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist.

* Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity captured  at a constant rate of 50Hz. 

* 70% of the volunteers  selected for generating the training data and 30% the test data. (Resulting in 21 training subjects and 9 test subjects)

* The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window)

* The sensor acceleration signal separated using a Butterworth low-pass filter into body acceleration and gravity

* The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used.

* From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

Source Reference: Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws





## Base Human Activity Recognition Dataset (HAR) 

### Initial raw files and corresponding R  object transformations

#### Obtain [HAR Datatset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

#### Fread() package is used to import raw .txt files
Subject_train.txt—numerical identifier of each individual subject participant in training data set. 

Store this in the data object  ![sub_train](https://github.com/Bc5Neep/GetandCleanData/blob/Cleaning-HAR-Data/CodeBook%20IMGs/sub_train.png), resulting in a 7352 x 1 data frame

```sub_train<- fread(file.choose("subject_train.txt"))```

Subject_test.txt— numerical identifier of each individual subject participant in training data set. 

Store in data object ![sub_test](https://github.com/Bc5Neep/GetandCleanData/blob/Cleaning-HAR-Data/CodeBook%20IMGs/sub_test.png), resulting in a 2947 x 1 data frame.

```sub_test<- fread(file.choose("subject_test.txt"))```


Y_train.txt – single column list of activities in accordance with activity label key in training data set.

 Store in the object ![train_activity](https://github.com/Bc5Neep/GetandCleanData/blob/Cleaning-HAR-Data/CodeBook%20IMGs/train_activity.png), resulting in a 7352 x 1 data frame.

```train_activity<- fread(file.choose("y_train.txt"))```

Y_test.txt – column list of activities in accordance with activity label key in training data set.

Store in the object ![test_activity](https://github.com/Bc5Neep/GetandCleanData/blob/Cleaning-HAR-Data/CodeBook%20IMGs/test_activity.png), resulting in a 2947 x 1 data frame.

```test_activity <- fread(file.choose("y_test.txt"))```

X_train.txt – raw vector values of acceleration and rotational velocity measurements of the  training group.

Store as object ![train_raw_value](https://github.com/Bc5Neep/GetandCleanData/blob/Cleaning-HAR-Data/CodeBook%20IMGs/train_raw_value.png), resulting in a 7352 x 561 data frame

```train_raw_value<- fread(file.choose("X_train.txt"))```

X_test.txt – raw vector values of accelration and rotational velocity measurements of the  test group.

Store as object ![test_raw_value](https://github.com/Bc5Neep/GetandCleanData/blob/Cleaning-HAR-Data/CodeBook%20IMGs/test_raw_value.png) resulting in a 2947 x 561 data frame

```test_raw_value <- fread(file.choose("X_test.txt"))```

features.txt – list of 561 measurement parameter names. Note : these are column names that accompany numerical value measurements of X/Y_train/test/raw_value objects.

Store in an object called ![feature_names](https://github.com/Bc5Neep/GetandCleanData/blob/Cleaning-HAR-Data/CodeBook%20IMGs/feature%20names.png), resulting in a 561 x 2 data frame.

```feature_names <- fread(file.choose("features.txt"))```

activity labels.txt – key of numerical values from 1-6 assigned to each corresponding activity. 
Not directly used as a data frame assembly component. 
Use this key to corroborate and assign activity names to numerical values (see "Key Transformations" section)

## Key transformations

### Renaming Subject and Activity columns

### ![Train](https://github.com/Bc5Neep/GetandCleanData/blob/Cleaning-HAR-Data/CodeBook%20IMGs/train_sub_activity%20transform%201.png)
```names(sub_train)[1] <- "subject"```
```names(train_activity)[1] <- "activity"```

### ![Test](https://github.com/Bc5Neep/GetandCleanData/blob/Cleaning-HAR-Data/CodeBook%20IMGs/test_df%20transform_1.png) 
```names(sub_test)[1] <- "subject"```
```names(test_activity)[1] <- "activity"```

### Transform numerical values from activity column into actual activities and update activity columns with activity names


```activity_labels <- c("1" = "Walking", "2" = "Walking_Upstairs", "3" = "Walking_Downstairs", "4" = "Sitting", "5" = "Standing", "6" = "Laying")```

### ![Train](https://github.com/Bc5Neep/GetandCleanData/blob/Cleaning-HAR-Data/CodeBook%20IMGs/train_activity_3.png)
```train_activity$activity <- activity_labels [as.character(train_activity$activity)]```

### ![Test](https://github.com/Bc5Neep/GetandCleanData/blob/Cleaning-HAR-Data/CodeBook%20IMGs/test%20activity_3.png)
```test_activity$activity <- activity_labels [as.character(test_activity$activity)]```


### Now values are actual activities, combine subject and activity into two column data frame for;
### ![Train data]()
train_df <- cbind(sub_train, train_activity)
### ![Test data]()
test_df <- cbind(sub_test, test_activity)

## Features
* The feature names and feature values are stored in separate data frames. 
* The feature_names data frame must first be reoriented from 561 x 2 to 2 x 561 to accommodate merging. 

### Number columns of raw values 1:561 instead of V1:561 (optional)   
### ![Train](https://github.com/Bc5Neep/GetandCleanData/blob/Cleaning-HAR-Data/CodeBook%20IMGs/train_df%20transformation_2.png)
colnames(train_raw_value) <- as.character (1:561)
### ![Test](https://github.com/Bc5Neep/GetandCleanData/blob/Cleaning-HAR-Data/CodeBook%20IMGs/test_df%20transform_1.png)
colnames(test_raw_value) <- as.character (1:561)


### Flip orientation of feature_names data frame (make columns rows and vice versa)

![Feature data frame sequence](https://github.com/Bc5Neep/GetandCleanData/blob/Cleaning-HAR-Data/CodeBook%20IMGs/features%20%20complete%20transformationtrain.png)

### Transpose (2)

```Features <- as.data.frame(t(feature_names))```

![Features](https://github.com/Bc5Neep/GetandCleanData/blob/Cleaning-HAR-Data/CodeBook%20IMGs/features.png)

### Remove numbered top row (3)
```Feature_Names <- Features[-1,]```

![Feature_Names](https://github.com/Bc5Neep/GetandCleanData/blob/Cleaning-HAR-Data/CodeBook%20IMGs/Feature_Names.png)


### Transfer column names from Feature_Names to train_raw_value (4)




### Replace column names from train_raw_value with those from Feature_Names (5)

```colnames(train_raw_value) <-as.character(Feature_Names[1:ncol(train_raw_value)])```


### Repeat with test_raw_value

```colnames(test_raw_value) <- as.character(Feature_Names[1:ncol(test_raw_value)])```


### Create master data frame of train and test features

```Features_Master <- rbind(train_raw_value, test_raw_value)```

![Features_Master](https://github.com/Bc5Neep/GetandCleanData/blob/Cleaning-HAR-Data/CodeBook%20IMGs/Features%20Master%20transform.png)

### Create data frame filtered by mean and standard deviation features

```Features_Mean_Std_Filtered <- Features_Master %>% ```
  ```select(contains("mean"), contains("std"))```

![Features_Mean_Std_Filtered](https://github.com/Bc5Neep/GetandCleanData/blob/Cleaning-HAR-Data/CodeBook%20IMGs/Features%20Mean%20Std%20Filtered%20Transform.png)

### Create master data frame of train and test subject and activity data

```Subject_Activity_Master <- rbind(train_df, test_df)```

![Subject_Activity_Master](https://github.com/Bc5Neep/GetandCleanData/blob/Cleaning-HAR-Data/CodeBook%20IMGs/Subject_Activity_Master.png)

### Merge to assemble complete HAR dataset data frame

```Train_Test_Merge <-cbind(Subject_Activity_Master, Features_Master)``` 

Result is 10299 x 563 data frame consisting of all study data  ![Train_Test_Merge](https://github.com/Bc5Neep/GetandCleanData/blob/Cleaning-HAR-Data/CodeBook%20IMGs/Train_Test_Merge.png)

### Create Merged data frame filtered by mean and standard deviation features 
```TT_Mean_Std_Filtered <- cbind(Subject_Activity_Master,Features_Mean_Std_Filtered)```

![TT_Mean_Std_Filtered](https://github.com/Bc5Neep/GetandCleanData/blob/Cleaning-HAR-Data/CodeBook%20IMGs/TT_Mean_Std_Filtered.png)

### Order rows in merged data frame by subject number 

```Train_Test_Ordered <- Train_Test_Merge[order(Train_Test_Merge[[1]],)]```

![Train_Test_Ordered](https://github.com/Bc5Neep/GetandCleanData/blob/Cleaning-HAR-Data/CodeBook%20IMGs/Train_Test_Ordered.png)

```TTO_Mean_Std_Filtered <- TT_Mean_Std_Filtered[order(TT_Mean_Std_Filtered[[1]],)]```

![TTO_Mean_Std_Ordered](https://github.com/Bc5Neep/GetandCleanData/blob/Cleaning-HAR-Data/CodeBook%20IMGs/TTO_Mean_Std_Filtered.png)


### Eliminate potential for duplicate row errors by giving unique names 

```names(Train_Test_Ordered) <-make.unique(names(Train_Test_Ordered))```

### Obtain mean values for each iterative feature measurement by subject and activity



### Master Human Activity Recognition (HAR) data set means


* Broadly satisfies objectives #1, #3, #4, and #5 "...average of each variable for each activity and each subject" omitting objective #2 ... extracting only mean and standard deviation of each measurement."

```HAR_Means_Master <- Train_Test_Ordered``` %>%
```group_by(subject, activity)``` %>%
  ```summarise(across(where(is.numeric), mean, na.rm = TRUE), .groups = "drop")```

  ![HAR_Means_Master](https://github.com/Bc5Neep/GetandCleanData/blob/Cleaning-HAR-Data/CodeBook%20IMGs/HAR_Means_Master.png)


### Next, obtain data set filtered by features containing mean and standard deviation measurements

* Data frame results from satisfying objectives #1 through #5 

```HAR_Means_Filtered <- TTO_Mean_Std_Filtered```%>%
  ```group_by(subject, activity)``` %>%
  ```summarise(across(where(is.numeric), mean, na.rm = TRUE), .groups = "drop")```

  ![HAR_Means_Filtered](https://github.com/Bc5Neep/GetandCleanData/blob/Cleaning-HAR-Data/CodeBook%20IMGs/HAR_Means_Filtered.png)