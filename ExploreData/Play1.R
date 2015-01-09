multiplot1 <- function() {
  library(datasets)
  data(airquality)
  par(mfrow = c(1, 3), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
  owModel <- lm(Ozone ~ Wind, airquality)
  osModel <- lm(Ozone ~ Solar.R, airquality)
  otModel <- lm(Ozone ~ Temp, airquality)
  with(airquality, {
    plot(Wind, Ozone, main = "Ozone and Wind")
    abline(owModel, lwd=2)
    plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
    abline(osModel, lwd=2)
    plot(Temp, Ozone, main = "Ozone and Temperature")
    abline(otModel, lwd=2)
    mtext("Ozone and Weather in New York City", outer = TRUE)
  })
}

multiplot2 <- function() {
  library(datasets)
  data(airquality)
#  par(mfrow = c(1, 3), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
  layout(matrix(c(1, 1, 1, 2, 3, 4), ncol = 3, byrow=TRUE), heights = c(.05, .95))
  
  par(mar = c(0, 0, 0, 0))
  plot(1, 1, type = "n", frame.plot = FALSE, axes = FALSE)
  u <- par("usr")
  text(1, u[4], labels = "Ozone and Weather in New York City", pos = 1)

  par(mar=c(2, 4, 4, 2))
  plot(airquality$Wind, airquality$Ozone, main = "Ozone and Wind")
  model <- lm(Ozone ~ Wind, airquality)
  abline(model, lwd = 2)
  with(airquality, plot(Solar.R, Ozone, main = "Ozone and Solar Radiation"))
  model <- lm(Ozone ~ Solar.R, airquality)
  abline(model, lwd = 2)
  with(airquality, plot(Temp, Ozone, main = "Ozone and Temperature"))
  model <- lm(Ozone ~ Temp, airquality)
  abline(model, lwd = 2)
  
}
