library(dplyr)

#### 1

## LOAD IN DATA
if(!file.exists("./data")){dir.create("./data")}
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile = "./data/Dataset.zip")

## UNZIP
unzip(zipfile="./data/Dataset.zip",exdir = "./data")

## READ IN TRAINING DATA
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

##READ IN TESTING DATA
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

## READ IN FEATURES
features <- read.table("./data/UCI HAR Dataset/features.txt")

## READ IN ACTIVITY LABELS
alabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")

features[,2]

## MERGE ALL DATA TOGETHER
train <- cbind(y_train,subject_train,x_train)
test <- cbind(y_test,subject_test,x_test)
all <- rbind(train, test)

## ASSIGN COLUMN NAMES
names(all)[1:2] <- c("activityID", "subjectID") 
names(all)[3:ncol(all)] <- features[,2]

names(alabels) <- c("activityID","activityType")

dim(all)

#### 2

## MAKE COLUMN NAMES VARIABLE
col_names <- names(all)

## MAKE VARIABLE OF SUBSET
idmeanstd <- all %>% 
  select(activityID, subjectID,contains("mean"),contains("std"))

## SUBSET DATA
all <- all[,names(idmeanstd)]

head(all)

#### 3

## MERGE ACTIVITY LABELS
act_names <- merge(idmeanstd, alabels, by= "activityID", all.x=TRUE)
head(act_names)

#### 4

## CLEAN UP VARIABLE NAMES
names(act_names)<-gsub("-mean()", "Mean", names(act_names), ignore.case = TRUE)
names(act_names)<-gsub("-std()", "STD", names(act_names), ignore.case = TRUE)
names(act_names)<-gsub("-freq()", "Frequency", names(act_names), ignore.case = TRUE)
names(act_names)<-gsub("BodyBody", "Body", names(act_names))
names(act_names)<-gsub("^t", "Time", names(act_names))
names(act_names)<-gsub("^f", "Frequency", names(act_names))
names(act_names)<-gsub("tBody", "TimeBody", names(act_names))


#### 5
final_data <- act_names %>% 
  group_by(activityID, subjectID) %>% 
  summarise_all(funs(mean))
write.table(final_data, "final_data.txt", row.name=FALSE)
