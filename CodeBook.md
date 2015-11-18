## Codebook for the "Getting and Cleaning Data" Course Project  
by dnvm2015 (November, 2015) 

***



### Raw data:
The raw data for the project is a data set which is part of the Human Activity Recognition database. The link to download this data set is

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The data set contains the following files ('train' in the names below refers to the training
group; there are analogous files, marked with 'test', for the test group): 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The total acceleration signal from the smartphone accelerometer for the X axis in standard gravity units 'g'. Every row is a 128 element vector. There are analogous files 'total_acc_y_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. There are analogous files 'body_acc_y_train.txt' and 'body_acc_z_train.txt' files for the Y and Z axis.

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. There are analogous files 'body_gyro_y_train.txt' and 'body_gyro_z_train.txt' files for the Y and Z axis.

- 'train/y_train.txt': Each row identifies the activity performed for each window sample. Its range is from 1 to 6.

- 'train/X_train.txt': Each row is a 561-feature vector with time and frequency domain variables calculated for each window sample.

In addition the following files are provided:

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the identifiers of the activities with their full names.

***
### Cleaning the data:
The R-script 'run_analysis.R' provided in the repo does the following:

- Merges the training and the test sets to create one data set.

- Extracts from the feature vectors the features describing the mean and standard deviation values for each measurement. 

- Creates a new data set with the average of each mean and standard deviation variable for each activity and each subject.

- Labels the data set with descriptive activity and variable names.

- Saves the resulting data set to a file.

***

###Tidy data: 
The tidy data is a single data frame with 180 rows and 68 columns written to the file `AVERAGED_MEAN_AND_STD_VALUES.txt'. The structure of the data frame is as follows:

  (1) The first column lists the identifiers of the subjects from both the training and the test group who performed each experiment.

  (2) The second column lists the (full names of the) activities performed by the subjects. 

  (3) The columns 3 through 35 contain the averaged values of all the *mean* variables from the feature vector where the averaging is over the fixed-width sliding windows obtained for the same experiment. The mean variables are those variables from 'features.txt' whose names contain "-mean()-", namely

```{r}
 "tBodyAcc-mean()-X"           "tBodyAcc-mean()-Y"           "tBodyAcc-mean()-Z"          
 "tGravityAcc-mean()-X"        "tGravityAcc-mean()-Y"        "tGravityAcc-mean()-Z"       
 "tBodyAccJerk-mean()-X"       "tBodyAccJerk-mean()-Y"       "tBodyAccJerk-mean()-Z"      
 "tBodyGyro-mean()-X"          "tBodyGyro-mean()-Y"          "tBodyGyro-mean()-Z"         
 "tBodyGyroJerk-mean()-X"      "tBodyGyroJerk-mean()-Y"      "tBodyGyroJerk-mean()-Z"     
 "tBodyAccMag-mean()"          "tGravityAccMag-mean()"       "tBodyAccJerkMag-mean()"     
 "tBodyGyroMag-mean()"         "tBodyGyroJerkMag-mean()"     "fBodyAcc-mean()-X"          
 "fBodyAcc-mean()-Y"           "fBodyAcc-mean()-Z"           "fBodyAccJerk-mean()-X"      
 "fBodyAccJerk-mean()-Y"       "fBodyAccJerk-mean()-Z"       "fBodyGyro-mean()-X"         
 "fBodyGyro-mean()-Y"          "fBodyGyro-mean()-Z"          "fBodyAccMag-mean()"         
 "fBodyBodyAccJerkMag-mean()"  "fBodyBodyGyroMag-mean()"     "fBodyBodyGyroJerkMag-mean()"
``` 
   *The same names are used for the averaged values in the tidy dataset. The units of the averaged values are the same as those of the original variables.* 
   

  (4) The columns 36 through 68 contain the averaged values of all the *standard deviation* variables from the feature vector where the averaging is over the fixed-width sliding windows obtained for the same experiment. The standard deviation variables are those variables from 'features.txt' whose names contain "-std()-", namely 

```{r}
 "tBodyAcc-std()-X"           "tBodyAcc-std()-Y"           "tBodyAcc-std()-Z"          
 "tGravityAcc-std()-X"        "tGravityAcc-std()-Y"        "tGravityAcc-std()-Z"       
 "tBodyAccJerk-std()-X"       "tBodyAccJerk-std()-Y"       "tBodyAccJerk-std()-Z"      
 "tBodyGyro-std()-X"          "tBodyGyro-std()-Y"          "tBodyGyro-std()-Z"         
 "tBodyGyroJerk-std()-X"      "tBodyGyroJerk-std()-Y"      "tBodyGyroJerk-std()-Z"     
 "tBodyAccMag-std()"          "tGravityAccMag-std()"       "tBodyAccJerkMag-std()"     
 "tBodyGyroMag-std()"         "tBodyGyroJerkMag-std()"     "fBodyAcc-std()-X"          
 "fBodyAcc-std()-Y"           "fBodyAcc-std()-Z"           "fBodyAccJerk-std()-X"      
 "fBodyAccJerk-std()-Y"       "fBodyAccJerk-std()-Z"       "fBodyGyro-std()-X"         
 "fBodyGyro-std()-Y"          "fBodyGyro-std()-Z"          "fBodyAccMag-std()"         
 "fBodyBodyAccJerkMag-std()"  "fBodyBodyGyroMag-std()"     "fBodyBodyGyroJerkMag-std()"
```
   *The same names are used for the averaged values in the tidy dataset. The units of the averaged values are the same as those of the original variables.*  

  (5) The rows of the data frame are in 1-to-1 correspondence with the experiments: each row contains the data identifier of one subject, the name of one activity, and the corresponding 66-dimensional feature vector of the averaged values of the above-listed variables. (The number of rows in the data frame is 180 = 30 (the number of subjects) * 6 (the number of activities.))




