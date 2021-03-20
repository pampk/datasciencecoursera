library(dplyr)
library(ggplot2)
library(caret)
library(Amelia)
library(tidyr)
library(rpart.plot)
library(rpart)
library(randomForest)

## READ IN THE DATA SETS
training_initial <- read.csv("pml-training.csv", na.strings=c("NA", "#DIV/0!", ""))
testing_final <- read.csv("pml-testing.csv", na.strings=c("NA", "#DIV/0!", ""))

head(training)
dim(training)
summary(training)
str(training)

## SPLIT TRAINING INTO TRAIN AND TEST
set.seed(420)
inTrain <- createDataPartition(y=training_initial$classe, p=0.7, list=FALSE)
training <- training_initial[inTrain,]
validation <- training_initial[-inTrain,]

##CLEANING DATA
#REMOVE USENAME COLUMN
training <- training %>% 
  select(-user_name)

## MISSING VALUES
missmap(training)
colMeans(is.na(training))
#remove all columns with missing values greater than 50%
training <- training[,which(colMeans(!is.na(training))>0.5)]
dim(training)
#check column types
sapply(training, class)

#have a lil look at the character columns 
char_cols <- training[,sapply(training,class)=='character']
names(char_cols)

count(training, cvtd_timestamp, sort=TRUE) #remove timestamp?
count(training, new_window, sort=TRUE) #heavily on the noo wil probably get removed in next step

#remove all timestamp columns and ID column
training <- training[,-c(1:6)]
dim(training)

## LOOK AT DISTRIBUTION OF CLASSE COLUMN
training %>% 
  ggplot(aes(x=classe,fill=classe)) +
  geom_bar() +
  theme_bw() +
  ggtitle("Bar chart to show the number of each type of class")

## REMOVE THE SAME COLUMNS FROM VALIDATION
validation2 <- validation[,names(training)]

## MODEL BUILDING
# CV parameter
trControl <- trainControl(method="cv", number = 5)

# DECISION TREE
# MODEL TRAIN
dtree_model <- train(classe ~., data=training, method="rpart",
                     trControl = trControl)

# make plot
fancyRpartPlot(dtree_model$finalModel)

# PREDICT WITH VALIDATION DATA
predictions <- predict(dtree_model, validation2)

# CONFUSION MATRIX
dtree_cm <- confusionMatrix(predictions, as.factor(validation2$classe))
dtree_cm

# RANDOM FOREST
rf_model <- train(classe ~.-classe, data=training, method="rf",
                     trControl = trControl)


# PREDICT WITH VALIDATION DATA
predictions <- predict(rf_model, validation)

# CONFUSION MATRIX
rf_cm <- confusionMatrix(predictions, as.factor(validation$classe))
rf_cm

# GBM
gbm_model <- train(classe ~.-classe, data=training, method="gbm",
                  trControl = trControl)


# PREDICT WITH VALIDATION DATA
predictions <- predict(gbm_model, validation)

# CONFUSION MATRIX
gbm_cm <- confusionMatrix(predictions, as.factor(validation2$classe))
gbm_cm
