# Routines created for the programming Project required by
# Getting and Cleaning Data (due Jan 25, 2012)
# a Coursera Course taught by
# by Jeff Leek, PhD, Roger D. Peng, PhD, Brian Caffo, PhD, all of Johns Hopkins
# Bloomberg School of Public Health.
#
# There is a description of the assignment found in the original README.md

# Download and unpack the data, a zip file with multiple directories
downloadData <- function() {
  if (!file.exists("./data")) {
    dir.create("./data")
  }
  dataDir <- "./data/UCI HAR Dataset"
  if (!file.exists(dataDir)) {
    zipFile <- "./data/getdata-projectfiles-UCI HAR Dataset.zip"
    if (!file.exists(zipFile)) {
        print("downloading data")
      fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
      download.file(fileUrl, destfile = zipFile, method="curl")
      dateDownloaded <- date()
      print(paste("Data downloaded:", dateDownloaded))
    }
    print("unpacking data")
    unzip(zipFile)
  }
}

# Read the data downloaded in downloadData()
# Build a data frame holding the mean and std values
buildHarData <- function() {
  #                   Read Subjects who provided each record
  # train/subject.txt: 7352 records, 1 field per record: subject, factor with 21 levels
  # test/subject.txt: 2947 records, 1 field per record: subject, factor with 9 levels
  trainSubjects <- read.table("./data/UCI HAR Dataset/train/subject_train.txt",
                              header=FALSE, col.names="subject")
  testSubjects <- read.table("./data/UCI HAR Dataset/test/subject_test.txt",
                             header=FALSE, col.names="subject")
  allSubjects <- rbind(trainSubjects, testSubjects)

  #                 Read Actvity engaged in in each record
  # activity_labels.txt: 6 activity factor names
  # read the names of the 6 activities the subjects engaged in
  activityNames <- read.table("./data/UCI HAR Dataset/activity_labels.txt",
                              header=FALSE, sep=" ",
                              col.names=c("factorNumber", "factorName"))
  # train/y_train.txt: 7352 records, 1 field per record: activity, factor with 6 levels
  # test/y_test.txt: 2947 records, 1 field per record: activity, factor with 6 levels
  trainActivity <- read.table("./data/UCI HAR Dataset/train/y_train.txt",
                              header=FALSE, col.names="activity", colClasses="factor")
  levels(trainActivity$activity) <- levels(activityNames$factorName)
  testActivity <- read.table("./data/UCI HAR Dataset/test/y_test.txt",
                             header=FALSE, col.names="activity", colClasses="factor")
  levels(testActivity$activity) <- levels(activityNames$factorName)
  allActivities <- rbind(trainActivity, testActivity)
  # train/X_train.txt: 7352 records, 561 fields per record
  # test/X_test.txt: 2947 records, 561 fields per record

  #           Read raw data and select columns we will work with
  # features.txt: 561 column names
  allColumnNames <- read.table("./data/UCI HAR Dataset/features.txt",
                               header=FALSE, sep = " ",
                               col.names=c("factorNumber", "factorName"))
  # There are repeated columnNames. Working with sort and uniq, I found that
  # several of the fBodyAcc-bandsEnergy(), fbodyAccJerk-bandsEnergy(), and
  # fbodyGyro-bandsEnergy() column names are repeated.
  # However, we only want the means and standard deviations, so which columns are
  # they?
  wantedColumns <- grep ('mean\\(\\)|std\\(\\)', allColumnNames[,2])
  # train/X_train.txt: 7352 records, 561 fields per record
  # test/X_test.txt: 2947 records, 561 fields per record
  xData <- read.table("./data/UCI HAR Dataset/train/X_train.txt", header=FALSE)
  yData <- read.table("./data/UCI HAR Dataset/test/X_test.txt", header=FALSE)
  allData <- rbind(xData, yData)
  # extract just the wanted columns
  wantedData <- allData[, wantedColumns]
  # make sure we name the columns
  colnames(wantedData) <- allColumnNames[wantedColumns, 2]
  # build a data frame with everything
  finalData <- cbind(subject=allSubjects, activity=allActivities, wantedData)
  finalData
}

# For each subject and activity, find the average of the means and standard
# deviations of each measurement
averageData <- function(harMeansStds) {
    library(plyr)
    # foreach subject, foreach activity, foreach data field, find the mean of that
    # subset of the data
    # build a table out of the subject, activity, and all the means
    # This would be hard with lapply and tapply. It is actually pretty easy with plyr
    nCols <- dim(harMeansStds)[2]
    avg.frame <- ddply(.data=harMeansStds, .variables = c("subject", "activity"),
                       .fun=function(x)sapply(x[3:nCols], mean))
    # update column names, removing the () which doesn't play nice with
    # write.table, and adding avg_ to indicate the change that has been made
    # from the original data
    ourColNames <- sub("\\(\\)", "", colnames(avg.frame[,3:nCols]))
    ourColNames <- sub("^", "avg_", ourColNames)
    colnames(avg.frame) <- c("subject", "activity", ourColNames)
    # Return the completed data.frame
    avg.frame
}

# Perform all steps required for this Project:
# Download data
# read in training and testing data and make a single data.frame containing
# the data columns that are means and standard deviations
# generate a tidy data set with the average of each variable for each activity
# and each subject
# save the tidy data set
# Separately, write a CodeBook.md file with code book for the tidy data set
run_analysis <- function() {
    downloadData()
    harData <- buildHarData()
    subjectData <- averageData(harData)
    write.table(subjectData, "./data/subjectAve.txt", sep = ",")
}
###### Tests #######

# Build a data frame with the two columns being "subject" and "activity", and
# with a bunch of data columns distinguishable by their means
# Use this data frame to test averageData
test_averageData <- function() {

  # XXX set the seed so this is repeatable

  subjectNames <- c("a", "b", "c", "d")
  activityNames <- c("sleep", "walk")
  sensors <- c("s1", "s2", "s3", "s4", "s5", "s6")

  activityRepeat = 50
  nSensors = length(sensors)
  nsubjects = length(subjectNames)
  nactivities = length(activityNames)

  subjects <- unlist(lapply(subjectNames, rep, nactivities * activityRepeat))
  activity <- rep(unlist(lapply(activityNames, rep, activityRepeat)), nsubjects)
  nrecords <- nactivities * nsubjects * activityRepeat

  # mean = subject + activity + sensor
  dataBySensor <- lapply(c(1:nSensors),
                         function(x)
                         lapply(c(1:nsubjects),
                                function(y)
                                lapply(c(1:nactivities),
                                       function(z)
                                       rnorm(activityRepeat, mean=x+y+z, sd=.25))))
  raw <- matrix(unlist(dataBySensor),
                nrow = nrecords, byrow=FALSE)
  colnames(raw) <- sensors
  df <- data.frame(subject=subjects, activity=activity, raw)
  dfA <- averageData(df)
  print(dfA)
  # xxx check that the answer is as expected
  #    subject activity       s1       s2       s3       s4        s5        s6
  #  1       a    sleep 2.988289 4.023125 5.034396 6.029740  7.046661  8.023714
  #  2       a     walk 3.993190 5.023049 6.068882 7.026432  8.033371  8.981478
  #  3       b    sleep 4.052397 4.997642 5.940757 6.983019  8.016046  8.982050
  #  4       b     walk 5.007618 5.962692 6.969772 8.009737  9.031264  9.972462
  #  5       c    sleep 5.017367 6.016338 6.972535 8.066120  9.009434 10.039441
  #  6       c     walk 5.948575 7.069653 8.011619 9.061028  9.981131 10.995332
  #  7       d    sleep 6.035564 6.993645 8.052071 8.982864 10.052732 10.972022
  #  8       d     walk 6.938645 8.017384 8.943985 9.965863 11.007095 11.908760

  testBySensor <- lapply(c(1:nSensors),
                         function(x)
                         lapply(c(1:nsubjects),
                                function(y)
                                lapply(c(1:nactivities),
                                       function(z)
                                       mean(dataBySensor[[x]][[y]][[z]]))))
  testData <- matrix(unlist(testBySensor), nrow = nsubjects*nactivities, byrow=FALSE)
  colnames(testData) <- sensors
  testA <- data.frame(subject = unlist(lapply(subjectNames, rep, nactivities)),
                      activity = rep(activityNames, nsubjects),
                      testData)

  if (! isTRUE(all.equal(dfA, testA))) {
    message("averageData means do not match")
  } else {
    message("averageData passes")
  }
}
