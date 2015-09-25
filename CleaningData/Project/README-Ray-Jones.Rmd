---
title: "Merge UCI HAR data sets, tidy and summarize"
author: "Ray Jones"
date: "January 14, 2015"
output: html_document
---

### Description

Run_analysis.R is a script produced to satisfy the Project assignment of the Getting & Cleaning Data course from the Data Science Specialization. It takes various inputs from the UCI HAR data set and merges them to produce a wide format tidy set of the means of various measurements selected from the inputs. It then outputs these mean values with appropriate and descriptive variable names to a file called meandata.txt  
 
### Arguments

None.  

### Details

Step 1 creates the merged data set:  

```
Subject             <- rbind(testSubject,trainSubject)
y                   <- rbind(testy, trainy)
X                   <- rbind(testX, trainX)
names(Subject)      <- "subject"
names(y)            <- "activity"
names(X)            <- c(as.character(features[, 2]))
data                <- cbind(Subject, y, X)
```

Step 2 removes all the non-relevant variables:

```
Columns             <- grep("-mean\\(\\)|-std\\(\\)", names(data))
data                <- data[ ,c(1, 2, Columns)]
```
The definition of variables to keep implemented here is those containing either "-mean()" or "-std()" in the variable name. This is compliant with the spec. in the assignment but can be easily modified by changing the grep() instruction given in the line above. The first two columns explicitly included in the second line of code are the subject and activity.

Step 3 sets meaningful activity labels:

```
activitylabels[,2]  <- gsub("_",".",tolower(activitylabels[,2]))
data[,2]            <- activitylabels[data[,2], 2]
```
The gsub() command replaces underscores by periods and sets all characters to lower case.

Step 4 sets descriptive and appropriate variable labels:

```
names(data)         <- gsub("-",".",tolower(names(data)))
names(data)         <- gsub("(","",names(data),fixed=TRUE)
names(data)         <- gsub(")","",names(data),fixed=TRUE)
names(data)         <- gsub("bodybody","body",names(data))
```
The 1st gsub() command replaces hyphens by periods and sets all characters to lower case. The next two gsub() commands remove the opening and closing brackets which are illegal in R variable names. The final gsub() command
fixes instances where some columns labels include "bodybody" instead of "body".

Step 5 creates the tidy summary data set:

```
meandatawide <- ddply(data, c("subject","activity"), numcolwise(mean))
```
Use of ddply() here makes the code very compact - some additional commented out code is provided in the script
which calculates the same answer using nested for loops - this was used to verify that the ddply() technique
is producing a correct answer.

### Usage

1. Create the working directory
2. Download the UCI HAR data set from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
3. Unzip the date set and place the "UCI HAR Dataset" folder in the working directory
4. Check the working directory path is correct in the run_analysis.R script and, if necessary, modify
5. Check that the R packages plyr & reshape2 are installed, if not then uncomment the relevant lines in the script
6. Run the run_analysis.R script  

### Input

1. subject_test.txt
2. y_test.txt
3. X_test.txt
4. subject_train.txt
5. y_train.txt
6. X_train.txt
7. features.txt
8. activity_labels.txt  

For detailed descriptions of these files and their contents see [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) and references therein.  
 
### Output

1. meandata.txt  

The output file is placed in the working directory. It is a wide format tidy data set containing the mean values of the selected variables from the input data averaged by subject ID and activity. A detailed description of the ouput variables is given in the Codebook located in the run_analysis.R repo.  

### References

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012. 
