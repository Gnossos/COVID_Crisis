#' Example
library(data.table)
library(ggplot2)

test <- function(date = NULL){
  DT <- as.data.table(economics)
  if (!is.null(date)){
    date <- as.Date(date)
# See https://stackoverflow.com/questions/21658893/subsetting-data-table-using-variables-with-same-name-as-column
    DT <- DT[eval(DT[,date %in% ..date])] # Pick one date
  }
  DT
}
