## Given a data.frame, containing data read from "household_power_consumption.txt",
## create 4 plots, 2 by 2
## upper left:
##   Plot 2
## upper right:
##   datetime vs Voltage
## X: DoW, Thu, Fri, Sat + datetime as a label below the axis
## Y: ticks 234:246
## black lines
## lower left:
##   Plot 3
## lower right:
##   datetime vs Global_reactive_power
## X: DoW, Thu, Fri, Sat + datetime as a label below the axis
## Y: ticks 0.0:0.5 by .1s + Global_reactive_power
## black lines

plot4 <- function(DT, save=FALSE) {
  plot.name = "plot4.png"
  if (save) {
    png(plot.name, width = 480, height = 480)
  }
  old_mfrow = par("mfrow")
  old_bg = par("bg")
  par(mfrow = c(2, 2), bg="transparent")
  with(DT, plot(Global_active_power ~ datetime, 
                xlab = "", type="l", ylab="Global Active Power"))
  with(DT, plot(Voltage ~ datetime, type="l"))
  plot(c(DT$Sub_metering_1, DT$Sub_metering_2, DT$Sub_metering_3) ~ rep(DT$datetime, 3),
       type="n", xlab = "", ylab = "Energy sub metering")
  with(DT, lines(Sub_metering_1 ~ datetime, col = "black"))
  with(DT, lines(Sub_metering_2 ~ datetime, col = "red"))
  with(DT, lines(Sub_metering_3 ~ datetime, col = "blue"))
  legend("topright", col = c("black", "red", "blue"),
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         lty=1, box.lty=0)
  with(DT, plot(Global_reactive_power ~ datetime, type="l"))
  if (save) {
    invisible(dev.off())
  }
  par(mfrow=old_mfrow, bg=old_bg)
}
