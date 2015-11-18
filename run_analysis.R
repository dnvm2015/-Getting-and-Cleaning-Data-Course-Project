## loading dependencies
library(plyr)
library(dplyr)

## reading the files 'subject_test.txt' and 'subject_train.txt' and combining 
## them into a single data frame
subjects<-rbind(read.table("./UCI HAR Dataset/test/subject_test.txt", col.names=
                                   "Subjects"), 
                read.table("./UCI HAR Dataset/train/subject_train.txt", col.names
                                                           ="Subjects"))

## reading the files 'y_test.txt' and 'y_train.txt' and combining 
## them into a single data frame
activities<-rbind(read.table("./UCI HAR Dataset/test/y_test.txt", col.names="Activities"), 
                  read.table("./UCI HAR Dataset/train/y_train.txt", col.names="Activities"))

## reading the files 'X_test.txt' and 'X_train.txt' and combining 
## them into a single data frame
all_measurements<-rbind(read.table("./UCI HAR Dataset/test/X_test.txt"),
                        read.table("./UCI HAR Dataset/train/X_train.txt"))

## loading the file 'features.txt'
features<-read.table("./UCI HAR Dataset/features.txt")

## selecting the names containing "mean()"
feat.mean.indices<-grep("mean()", features$V2, ignore.case = FALSE, perl = FALSE, value = FALSE,
              fixed = TRUE, useBytes = FALSE, invert = FALSE)
feat.mean.names<-features[feat.mean.indices,]

## selecting the corresponding columns of 'all_measurements'
mean_measurements<-select(all_measurements,feat.mean.indices)

## renaming the columns in 'mean_measurements' with full names
colnames(mean_measurements)<-features$V2[feat.mean.indices]

## Same steps for "-std()-"
feat.std.indices<-grep("std()", features$V2, ignore.case = FALSE, perl = FALSE, value = FALSE,
                       fixed = TRUE, useBytes = FALSE, invert = FALSE)
feat.std.names<-features[feat.std.indices,]
std_measurements<-select(all_measurements,feat.std.indices)
colnames(std_measurements)<-features$V2[feat.std.indices]

## combining 'subjects', 'activities', 'mean_measurements' and 'std_measurements' 
## into a single data frame
mean_and_std_measurements<-cbind(subjects,activities,mean_measurements,std_measurements)

## splitting 'mean_and_std_measurements' into a list of data frames, each 
## describing the measurements for one subject and one activity
tempor<-split(mean_and_std_measurements,list(mean_and_std_measurements$Subjects,
                                             mean_and_std_measurements$Activities), drop=T)

## averaging the columns of each data frames from the list
tempor<-lapply(tempor,function(x)sapply(x, function(y) mean(y)) )

## combining the new data frames into a single one
tempor<-do.call(rbind, tempor)
averaged_mean_and_std_measurements<-as.data.frame(tempor)

## renaming the activities with full names
activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt")
averaged_mean_and_std_measurements$Activities=
        activity_labels[match(averaged_mean_and_std_measurements$Activities, 
                              activity_labels$V1), 2]

## reordering the rows of 'averaged_mean_and_std_measurements' to make the 
## subjects and activities appear in the ascending order
averaged_mean_and_std_measurements<-arrange(averaged_mean_and_std_measurements, 
                                            Subjects, Activities)

## saving the resulting tidy data set
write.table(averaged_mean_and_std_measurements,"./AVERAGED_MEAN_AND_STD_VALUES.txt")
