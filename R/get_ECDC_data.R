# Download European Centre for Disease Prevention and Control COVID-19 data
#     See https://www.ecdc.europa.eu/en/publications-data/download-todays-data-geographic-distribution-covid-19-cases-worldwide

library(utils)
data <- read.csv("https://opendata.ecdc.europa.eu/covid19/casedistribution/csv", na.strings="", fileEncoding = "UTF-8-BOM")