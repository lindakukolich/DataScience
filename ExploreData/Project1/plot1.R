## Given a data.frame, containing data read from "household_power_consumption.txt",
## create a histogram of "Global_active_power" and save it to plot1.png
## See project1.R for usage information
plot1 <- function(DF, save = FALSE) {
  plot.name <- "plot1.png"
  if (save) {
    png(plot.name, width = 480, height = 480)
  }
  old_mar = par("mar")
  par(mar = c(5, 4, 2, 2) + 0.1)
  with(DF, hist(Global_active_power, main="Global Active Power", 
                xlab = "Global Active Power (kilowatts)", col="red"))
  if (save) {
    invisible(dev.off())
  }
  par(mar = old_mar)
}
