# get_UN_pop -- get UN population

require(data.table)
require(ISOcodes)

# United Nations Department of Economic and Social Affairs,
#         Population Dynamics, World Population Prospects 2019.
#         https://population.un.org/wpp/Download/Standard/CSV/

# There are at least ten variations of CSV files from the 2019 UN WPP, and many, many more .XLS files.
#   For now, this one is hard-wired. To make it easier to modify, it's moved outside the input initialization.
un_url <-
  "https://population.un.org/wpp/Download/Files/1_Indicators%20(Standard)/CSV_FILES/WPP2019_TotalPopulationBySex.csv"

# Establish defaults.
usa <- "United States of America"
world <- "World"
DEFAULT_VARIANT <- "Medium"

# This comes from the data.table vignette (https://cran.r-project.org/web/packages/data.table/vignettes/datatable-intro.html)
input <- if (file.exists("data/WPP2019_TotalPopulationBySex.csv")) {
  "data/WPP2019_TotalPopulationBySex.csv"
} else {
  un_url
}
wpp2019 <- fread(input)
get_wpp2019 <- function(LocID = NULL, Location = NULL, Time = NULL, File_Number = 1 ){
  csv_files <- c(
    "WPP2019_TotalPopulationBySex",
    "WPP2019_PopulationByAgeSex_Medium",
    "WPP2019_PopulationByAgeSex_OtherVariants",
    "WPP2019_PopulationBySingleAgeSex_1950-2019",
    "WPP2019_PopulationBySingleAgeSex_2020-2100",
    "WPP2019_Fertility_by_Age",
    "WPP2019_Period_Indicators_Medium",
    "WPP2019_Period_Indicators_OtherVariants",
    "WPP2019_Life_Table_Medium",
    "WPP2019_Life_Table_OtherVariants"
  )
  file_name <- paste0("https://population.un.org/wpp/Download/Files/1_Indicators%20(Standard)/CSV_FILES/",csv_files[File_Number],".csv")
  
  if(is.null(LocID)){
    if (is.null(Location))
      # Get the whole data set
    else
      # Get the data set for Location only
  }
  else
    # Get the data set for LocID only
    
}
