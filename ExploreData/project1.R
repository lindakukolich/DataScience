# Support routines for Project 1 for Exploratory Data Analysis, a Coursera course
# taught by by Roger D. Peng, PhD, Jeff Leek, PhD, Brian Caffo, PhD, all of Johns Hopkins
# Bloomberg School of Public Health
# 
# Written by Linda Kukolich, January 2015
# 
# The assignment is to read two days worth of a data file containing records of
# electrical use and produce a series of plots from that data.d
# The source file is https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# Which I downloaded and decompressed
#
# Usage:
# source("project1.R")
# source("plot1.R")
# source("plot2.R")
# source("plot3.R")
# source("plot4.R")
# DF <- prepare.to.plot()
# plot.all(DF)

# Find the first line of the given file that contains the given pattern
# This takes a long time, but avoids hard coding a value for the number of lines
# to skip in the file before getting to the data we want to plot
find.first.line <- function(file, pattern) {
  first.line <- grep(pattern, readLines(file))[1]
  first.line
}

# Read a data file and turn the text Date and Time fields into a
# POSIX time, and return the data as a data.frame
# It is assumed that we are reading "household_power_consumption.txt"
read.data <- function(file, skip, nrows) {
  # read one line, to pull the header info
  DF <- read.table(file, na.strings="?", sep=";", header=TRUE, nrows=1)
  # read the actual data, two days worth
  DF <- read.table(file, na.strings="?", sep=";", col.names=names(DF),
                    skip=skip, nrows=nrows, header=FALSE)
  # copy the Date and Time fields together and turn them into POSIX times
  datetime <- strptime(paste(DF$Date, DF$Time), format="%d/%m/%Y %H:%M:%S")
  DF <- cbind(DF, datetime)
  DF
}

# Read "household_power_consumption.txt" and return just those records that are
# from February 1 and 2, 2007. There is one record per minute.
prepare.to.plot <- function() {
  file <- "household_power_consumption.txt"
  first.line <- find.first.line(file, "1/2/2007")
  # To download and decompress:
  # temp <- tempfile()
  # download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
  # downloadDate <- date()
  # unz(temp, file)
  # unlink(temp)
  read.data(file, first.line - 1, 48*60)
}

# Show and save all 4 plots
# It is assumed you have loaded all the plot source files and
# that you have called prepare.to.plot to load the data
plot.all <- function(DF) {
  plot1(DF)
  plot1(DF, TRUE)
  plot2(DF)
  plot2(DF, TRUE)
  plot3(DF)
  plot3(DF, TRUE)
  plot4(DF)
  plot4(DF, TRUE)
}
