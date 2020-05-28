#' interpolate
#'
#' See https://www.r-bloggers.com/interpolation-and-smoothing-functions-in-base-r/ (de Vries 2015) for test code & initial programming
#' 

require(data.table)
library(ggplot2)

#' Everything here is for the original testing from de Vries (2015)
set.seed(1)
n <- 1e3
dat <- data.table(
  x = 1:n,
#  y = sin(seq(0,5*pi, length.out = n)) + rnorm(n=n, mean = 0, sd = 0.1)
#  y = exp(x) + rnorm(n=n, mean=0, sd = 0.1)
  y = exp(x)
)

approxData <- as.data.table(
  data.frame(
    with(dat,
       approx(x, y, xout = seq(1, n, by = 10), method = "linear")
    ),
    method = "approx()"
  )
)

splineData <- as.data.table(
  data.frame(
    with(dat, 
       spline(x, y, xout = seq(1, n, by = 10))
    ),
  method = "spline()"
  )
)

smoothData <- data.table(
  x = 1:n,
  y = as.vector(smooth(dat$y)),
  method = "smooth()"
)

loessData.1 <- data.table(
  x = 1:n,
  y = predict(loess(y~x, dat, span = 0.1)),
  method = "loess.1()"
)

loessData.5 <- data.table(
  x = 1:n,
  y = predict(loess(y~x, dat, span = 0.5)),
  method = "loess.5()"
)

smoothSplineData <- as.data.table(
  data.frame(
    predict(smooth.spline(dat$x,dat$y)),
    method = "Smooth Spline"
  )
)

ggplot(rbind(approxData, splineData, smoothData, loessData.1, loessData.5, smoothSplineData, fill = TRUE), aes(x, y)) + 
  geom_point(dat = dat, aes(x, y), alpha = 0.2, col = "red") +
  geom_line(col = "blue") +
  facet_wrap(~method) +
  ggtitle("Interpolation and smoothing functions in R") +
  theme_bw(16)






interpolate <- function(x,y,xout,method = smooth.splinei, span = 0.1){
# Returns a vector of interpolated values matching xout.
# First makes a fit, then interpolates everything in xout.
  
  fit <- switch(
    method,
      "smooth.spline" = {},
      "approx" = {},
      "loess" = {},
      "smooth" = {},
      "spline" = {},
  )
  
  
}