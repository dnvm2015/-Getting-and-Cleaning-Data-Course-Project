# "Getting and Cleaning Data" Course Project 
by dnvm2015 (November, 2015) 

***

## Project Description
### Preliminaries
In the framework of a project "Human Activity Recognition Using Smartphones" 
(whose detailed description is available at 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) 
a database has been built containing recordings of 30 volunteers performing 6 types of activities (laying, sitting, standing, walking, walking downstairs, walking upstairs) while carrying a waist-mounted smartphone with embedded inertial sensors.
Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity were captured. The sensor signals were pre-processed with noise filters and then sampled in fixed-width sliding windows (128 readings/window). The acceleration signal was separated into body acceleration and gravity. Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals, the magnitude (in the Euclidean norm) of these three-dimensional signals was calculated, and a Fast Fourier Transform was applied to some of these signals. Finally, from each window, a vector of features was obtained by calculating variables from the time and frequency domain, e.g.
the mean value, the Standard deviation, the median absolute deviation, the largest and the smallest value in array, etc. These variables are collected into 561 dimensional "feature vectors". The entire data set has been randomly partitioned into two sets, with 70% of the volunteers selected for the "training group" and 30% for the "test group".


### The goal 
*The goal of the present project is to create a data set summarizing a subset of the feature
variables from the above database.* 

More precisely, an R-script 'run_analysis.R' should be written that does the following:

- Merges the training and the test sets to create one data set.

- Extracts only the measurements on the mean and standard deviation for each measurement. 

- Creates a new dataset with the average of each variable for each activity and each subject.

- Labels the dataset with descriptive activity and variable names.

***

## Solution

### To create the tidy data file

1. Download the zipped file with the data for the project using the link

    https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

2. Place the zipped file in your working directory and **unzip** it. The result is 
a folder titled 'UCI HAR Dataset' containing files and subfolders.

3. Download the R-script 'run_analysis.R' provided in this repo (click on its name and then right click on the "Raw" button) and save it to your working directory. 

4. Run the R-script 'run_analysis.R' by typing 
```{r}
source('run_analysis.R')
```
in the RStudio Console. This will create a file with the name 'AVERAGED_MEAN_AND_STD_VALUES.txt' in your working directory containing the tidy data set.

5. To analyze the resulting data set, load it into your R session by typing e.g.
```{r}
ave_val<-read.table("./AVERAGED_MEAN_AND_STD_VALUES.txt")
```


### Comments on the input data for the R-script
*(A more detailed description of the raw data for the project can be found in* **CodeBook.md** *)*

The folder 'UCI HAR Dataset', that one downloads using the above link, contains several files. The R-script 'run_analysis.R' uses the following files only:

* The files
```{r}
     './UCI HAR Dataset/test/subject_test.txt' './UCI HAR Dataset/train/subject_train.txt'
```   
contain one-column tables whose rows correspond to all the fixed-width sliding windows extracted from all the experiments that were run in the test and the training groups, respectively. The entries are the identifiers of the subjects from the test resp. training group. 

* The files 
```{r} 
    './UCI HAR Dataset/test/y_test.txt' './UCI HAR Dataset/train/y_train.txt'
``` 
contain one-column tables whose rows correspond to all the fixed-width sliding windows extracted from all the experiments that were run in the test and the training groups, respectively. The entries are integers from 1 to 6 
indicating the type of activity.

* The files
```{r} 
    './UCI HAR Dataset/test/X_test.txt' './UCI HAR Dataset/train/X_train.txt'
```
contain tables whose rows correspond to all the fixed-width sliding windows extracted from all the experiments that were run in the test and the training groups, respectively. The 561 columns in both tables contain the corresponding feature vectors.

* The file
```{r}
    './UCI HAR Dataset/features.txt'
```
contains a two-column table with the indices and the full names of all the variables used in the feature vectors.


* The file
```{r}
    './UCI HAR Dataset/activity_labels.txt'
```
contains a two-column table with the indices and the full names of all the 6 activities.

***

### Script Walkthrough

The R-script 'run_analysis.R'

1. loads the "plyr" and "dplyr" libraries;

2. reads the files 'subject_test.txt' and 'subject_train.txt' and combines 
them into a single one-column data frame 'subjects'; the name of the variable in the frame is 'Subjects'; 

3. reads the files 'y_test.txt' and 'y_train.txt' and combines 
them into a single one-column data frame 'activities'; the name of the variable in the frame is 'Activities';

4. reads the files 'X_test.txt' and 'X_train.txt' and combines 
them into a single data frame 'all_measurements';

5. reads the file 'features.txt'; 

6. selects the indices and the full names of those variables in 'features' that have  "-mean()-" as part of their names;

7. selects the corresponding columns of 'all_measurements' and inserts full names of the variables into the resulting data frame; the name of this data frame is 'mean_measurements';

8. repeats steps 6 and 7 for "-std()-" in place of "-mean()"; the resulting data frame is 
'std_measurements';

9. combines the frames 'subjects' (step 2), 'activities' (step 3), 'mean_measurements' (step 7), and 'std_measurements' (step 8) into a single data frame 'mean_and_std_measurements'; 

10. splits the data frame 'mean_and_std_measurements' into a list 'tempor' of data frames, each describing the measurements for one subject and one activity;

11. averages the columns of each data frame from the list;

12. combines the new data frames into a single one 'averaged_mean_and_std_measurements';

13. replaces the indices of activities in 'averaged_mean_and_std_measurements' with their full names;

14. reorders the rows of 'averaged_mean_and_std_measurements' to make the subjects and activities appear in the ascending order;

15. saves the final version of 'averaged_mean_and_std_measurements' into the working directory as 'AVERAGED_MEAN_AND_STD_VALUES.txt'.

