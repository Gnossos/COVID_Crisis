#' interpolate
#'
#' See https://www.r-bloggers.com/interpolation-and-smoothing-functions-in-base-r/ (de Vries 2015) for test code & initial programming
#' 

require(data.table)
require(lubridate)
library(ggplot2)

estimate <- function(x,y,xout,method = "approx", span = 0.1){
# Returns a vector of interpolated values matching xout.
# First makes a fit, then interpolates everything in xout.
  
  xx <- x
  yy <- y
  
  # Convert Date variables to decimal dates.
  if (!is.null(xout) && is.Date(xout)) {
    xx <- decimal_date(xout)
  } else if (is.Date(x)) {
    xx <- decimal_date(x)
  } else if (is.Date(y)) {
    
  } 
  
  
  fit <- switch(
    method,
      "approx" = {
               value <- approx(x, y, xout = xout, method = "linear")
      },
      "loess" = {},
      "smooth" = {},
      "smooth.spline" = {},
      "spline" = {}
  )
  
  value <- data.frame(
    approx(xx,yy,xout = xout, method = "linear"),
    method
  )
  value
}