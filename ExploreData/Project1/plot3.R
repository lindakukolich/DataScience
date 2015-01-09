## Given a data.frame, containing data read from "household_power_consumption.txt",
## create 3 lines plots of Energy submetering vs time
plot3 <- function(DT, save=FALSE) {
  plot.name = "plot3.png"
  if (save) {
    png(plot.name, width = 480, height = 480)
  }
  old_bg = par("bg")
  par(bg="transparent")
  plot(c(DT$Sub_metering_1, DT$Sub_metering_2, DT$Sub_metering_3) ~ rep(DT$datetime, 3),
       type="n", xlab = "", ylab = "Energy sub metering")
  with(DT, lines(Sub_metering_1 ~ datetime, col = "black"))
  with(DT, lines(Sub_metering_2 ~ datetime, col = "red"))
  with(DT, lines(Sub_metering_3 ~ datetime, col = "blue"))
  legend("topright", col = c("black", "red", "blue"),
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         lty=1)
  if (save) {
    invisible(dev.off())
  }
  par(bg=old_bg)
}
