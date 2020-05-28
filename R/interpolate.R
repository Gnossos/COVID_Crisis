#' interpolate
#'
#' See https://www.r-bloggers.com/interpolation-and-smoothing-functions-in-base-r/ (de Vries 2015) for test code & initial programming
#' 

require(data.table)
#' Everything here is for the original testing from de Vries (2015)
set.seed(1)
n <- 1e3
dat <- data.table(
  x = 1:n,
  y = sin(seq(0,5*pi, length.out = n)) + rnorm(n=n, mean = 0, sd = 0.1)
)

approxData <- data.table(
  with(dat,
       approx(x, y, xout = seq(1, n, by = 10), method = "linear")
       ),
  method = "approx()"
)

interpolate <- function(x,y,at,method = smooth.spline){
  
  
}