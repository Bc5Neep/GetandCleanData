# GetandCleanData
## Data Cleaning Project using UCI Human Activity Recognition Dataset

### Overview 
The following details transformation of open source raw data files from the Human Activity Recognition using Smartphones dataset in the UCI Machine Learning Repository from their initial raw component.txt files into a cohesive tidy data frame in RStudio stored in an R script called Run_analysis.R.

### Original Study
Android smartphone accelerometer and gyroscope capacities were evaluated using motion data collected from 30 human subjects. Triaxial linear acceleration and angular velocity signals across 6 movement classes (Walking, Waking Upstairs, Sitting, Standing, Laying) and 561 measurement features were evaluated.

### Objectives
Create tidy data set and store in script called run_analysis.R that accomplihes the following criteria:

1.	Merges the training and the test sets to create one data set.
2.	Extracts only the measurements on the mean and standard deviation for each measurement. 
3.	Uses descriptive activity names to name the activities in the data set
4.	Appropriately labels the data set with descriptive variable names. 
5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

### Data cleaning approach
Raw data of each parameter initially segregated into individual .txt files were imported into RStudio, assigned appropriate descriptive variables (3, 4) and underwent modular assembly into data objects reflecting training and test subject experimental groups, before being merged and ordered by subject and activity into a master data frame (1) containing all study information. 
Mean values of each iteration of each subject movement activity are obtained, resulting in a tidy collapsed 180 x 563 data frame. (5)
A second data frame with initial 561 features filtered by mean and standard deviation is constructed, resulting in a sleek 180 x 88 data frame. (2)

More detailed information in [*CodeBook.md*]

### Software
RStudio Version 
RStudio 2025.09.2+418 "Cucumberleaf Sunflower" Release (12f6d5e22720bd78dbd926bb344efe12d0dce83d, 2025-10-20) for windows
Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) RStudio/2025.09.2+418 Chrome/138.0.7204.251 Electron/37.6.1 Safari/537.36, Quarto 1.7.32 

### R packages used 
tidyr

dplyr

data.table

stringr

tibble

### Author
BC5Neep <https://github.com/Bc5Neep/GetandCleanData.git>