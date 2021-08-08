---
title: "Getting and Cleaning Data Final Project - Peer Graded Assignment"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## Data Extraction

The data initially came from the UCL machine learning repository. It was already split into test and train data and the data was split into three parts; variables, labels and activity names. 

To clean the data the following steps were taken:
1. All data sets were merged/unioned to create a master data set
2. The proper column names were assigned to the dataset
3. The columns containing the IDs, mean and std were extracted
4. Merging the data with the descriptive activity labels
5. Making the variable names more readable
6. Creating a final summarised data set

## The R Script

To see the code that runs the above steps open the analysis.R file

## Variables used

Initial data load:
- x_train, y_train, subject_train <- training data; x_train contains features, y_train contains corresponding labels and subject_train contains subject data
- x_test, y_test, subject_test <- testing data; x_test contains features, y_test contains corresponding labels and subject_test contains subject data
- features <- names for the vaiables of x_train/x_test
- alabels <- activity descriptions and corresponding IDs

Merged/Unioned datasets:
- x_train, y_train, subject_train all merged together to create new variable **train** using cbind
- x_test, y_test, subject_test all merged together to create new variable **test** using cbind
- train and test unioned to create new variable **all** using rbind
- column names assigned using features

Subset data to get all columns containing ID, mean and std
- **col_names** variable created using names() on all
- new variable **idmeanstd** created by using names() on select statement that selects all columns containig ID, mean and std
- subset all with idmeanstd varible

Add in descriptive activity labels
- merge alabels with all to create new variable **act_names**

Clean variable names using grepl

Create independent tidy data set with the average os each variable
- new variable **final_data** created by summarising act_names by activityID and ubjectID and taking the mean of all other variables in dataset
- final_data outputed as txt file




