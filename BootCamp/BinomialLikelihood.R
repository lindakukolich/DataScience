myChiSqPlot <- function(x = 13, n=20) {
  p <- x/n
  s2 <- p*(1-p)/n
  alpha <- 0.05
  qtiles <- qchisq(c(alpha/2, 1-alpha/2), n-1)
  # good range
  ival <- sqrt(rev((n-1)*s2/qtiles))
  sigmaVals <- seq(from=ival[1], to=ival[2], length=1000)
  likeVals <- dgamma((n-1)*s2, shape = (n-1)/2, scale = 2*sigmaVals^2)
  likeVals <- likeVals/max(likeVals)
  plot(sigmaVals, likeVals, type = "l")
  lines(range(sigmaVals[likeVals >= 1/8]), c(1/8, 1/8))
  range(sigmaVals[likeVals >= 1/8])
}
myTPlot <- function(x = 13, n = 20) {
  p <- x/n
  s2 <- p*(1-p)/n
  tStat <- sqrt(n)*p / sqrt(s2)
  esVals <- seq(2, 10, length=1000)
  likeVals <- dt(tStat, n-1, ncp=sqrt(n)*esVals)
  likeVals <- likeVals / max(likeVals)
  plot(esVals, likeVals, type="l")
  lines(range(esVals[likeVals >= 1/8]), c(1/8, 1/8))
  range(esVals[likeVals >= 1/8])
}
myNormPlot <- function(x = 13, n = 20) {
  p <- x/n
  s2 <- p*(1-p)/n
  qvals <- seq(0, 1, length=1000)
  likeVals <- dnorm(qvals, mean=p, sd=sqrt(s2))
  plot(qvals, likeVals, type="l")
  lines(range(qvals[likeVals >= 1/8]), c(1/8, 1/8))
  range(qvals[likeVals >= 1/8])
}