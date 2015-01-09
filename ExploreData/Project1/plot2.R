## Given a data.frame, containing data read from "household_power_consumption.txt",
## create a line of "Global_active_power" and save it to plot2.png
## See project1.R for usage information
plot2 <- function(DT, save=FALSE) {
  plot.name = "plot2.png"
  if (save) {
    png(plot.name, width = 480, height = 480)
  }
  with(DT, plot(Global_active_power ~ datetime, 
                xlab = "", type="l", ylab="Global Active Power (kilowatts)"))
  if (save) {
    invisible(dev.off())
  }
}
