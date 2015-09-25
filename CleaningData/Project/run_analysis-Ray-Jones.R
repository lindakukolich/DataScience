## This script reads in the UCI HAR Dataset described in the Getting & Cleaning
## Data course project and outputs the required tidy data set comprising a 
## merged set containing average values for the desired mean and std variables
## per subject and activity with appropriate and descriptive labels.

## Step 0: Set everything up and read in required data etc.
## --------------------------------------------------------

## Load the needed libraries 
## install.packages("plyr")
library(plyr)
## install.packages("reshape2")
library(reshape2)

## Set the working directury (this may require modification depending on the 
## local directory structure used)
setwd(
  "~/Documents/Data Science Specialisation/3 - Getting & Cleaning Data/Project")

## Set the paths for the various raw data files etc. This assumes the UCI HAR 
## data set has been unzipped in the Project directury and not further modified.
## If it has then, these paths will need modification. This is not loading the 
## inertial data files since this info would be removed later.
testSubjectPath     <- "./UCI HAR Dataset/test/subject_test.txt"
testyPath           <- "./UCI HAR Dataset/test/y_test.txt"
testXPath           <- "./UCI HAR Dataset/test/X_test.txt"
trainSubjectPath    <- "./UCI HAR Dataset/train/subject_train.txt"
trainyPath          <- "./UCI HAR Dataset/train/y_train.txt"
trainXPath          <- "./UCI HAR Dataset/train/X_train.txt"
featuresPath        <- "./UCI HAR Dataset/features.txt"
activityPath        <- "./UCI HAR Dataset/activity_labels.txt"

## Step 1: Merge the training and the test sets to create one data set.
## --------------------------------------------------------------------

## Load the various raw data files and files containing labels (using read.table
## as read.csv gets confused)
testSubject         <- read.table(testSubjectPath)
testy               <- read.table(testyPath)
testX               <- read.table(testXPath)
trainSubject        <- read.table(trainSubjectPath)
trainy              <- read.table(trainyPath)
trainX              <- read.table(trainXPath)
features            <- read.table(featuresPath)
activitylabels      <- read.table(activityPath)

## Row bind the equivalent test & train data components into a single frame each
Subject             <- rbind(testSubject,trainSubject)
y                   <- rbind(testy, trainy)
X                   <- rbind(testX, trainX)

## Put the column names into the resulting merged data frames
names(Subject)      <- "subject"
names(y)            <- "activity"
names(X)            <- c(as.character(features[, 2]))

## Column bind the three resulting frames to give a single merged frame
data                <- cbind(Subject, y, X)

## Step 2: Extract only mean and standard deviation for each measurement 
## ---------------------------------------------------------------------

## Make a vector of columns to keep (1, 2, + col. names containing -mean() or 
## -std() ) and remove the others from the  data frame (this takes a narrow view 
## of what the assignment actually means to say here but this can be easily 
## modified by changing the grep search field in the next line)
Columns             <- grep("-mean\\(\\)|-std\\(\\)", names(data))
data                <- data[ ,c(1, 2, Columns)]

## Step 3: Use descriptive activity names for the activities in the data set
## -------------------------------------------------------------------------

## Modify the activity descriptors to lower case, replace underscores and then 
## replace the activity codes in the data frame with the modified descriptors by
## using the activity code as an index into the vector of labels
activitylabels[,2]  <- gsub("_",".",tolower(activitylabels[,2]))
data[,2]            <- activitylabels[data[,2], 2]

## Step 4: Appropriately label the data set with descriptive variable names 
## ------------------------------------------------------------------------

## Re-case, replace the hyphens, remove the brackets from variable names and 
## fix instances of "bodybody"
names(data)         <- gsub("-",".",tolower(names(data)))
names(data)         <- gsub("(","",names(data),fixed=TRUE)
names(data)         <- gsub(")","",names(data),fixed=TRUE)
names(data)         <- gsub("bodybody","body",names(data))

## Step 5: Create a tidy data set with mean(variable) by activity & subject
## ----------------------------------------------------------------------

## Calculate the new tidy data set with just the mean values of each variable
## averaged over each activity for each subject in both wide and long formats
meandatawide <- ddply(data, c("subject","activity"), numcolwise(mean))
meandatalong <- melt(meandatawide, id.vars=c("subject","activity"))
meandatalong <- meandatalong[order(meandatalong$subject,meandatalong$activity),]

## Write out the meandata file to the current working drectory (data format
## is currently wide, if long is needed then write the meandatalong version)
write.table(meandatawide, file="meandata.txt", row.names=FALSE)

## Clean up memory
rm(testSubject, testy, testX, trainSubject, trainy, trainX, features, 
   activitylabels, Subject, y, X, data)
rm(testSubjectPath, testyPath, testXPath, trainSubjectPath, trainyPath, 
   trainXPath, featuresPath, activityPath, Columns)

## The rest of this commented out code is to independently verify the results by 
## a completely different method of calculation (using nested for loops) - 
## essentially testing that the ddply() instruction above is actually doing what
## it is supposed to. If the tidy data sets produced by the two methods are 
## identical then the code below returns the value zero (which is does). 
## NB in order to get this to work you need to uncomment it and comment out the 
## two rm() instructions immediately above.
## 
## meandatawide2 <- meandatawide
## check <- meandatawide
## meandatawide2[,3:68] <- 0
## check[,3:68] <- 1
## labels <- c("laying","sitting","standing","walking",
##             "walking.downstairs","walking.upstairs")

## for (id in 1:30) {
##     for (act in 1:6) {
##         for (col in 3:68) {
##             meandatawide2[(6*(id-1))+act, col] <- mean(data[data$subject==id & data$activity==labels[act],col])
##             check[(6*(id-1))+act, col] <- meandatawide[(6*(id-1))+act, col] - meandatawide2[(6*(id-1))+act, col]
##         }
##     }    
## }

## Answer here should be zero if the results agree
## sum(check[,3:68])
