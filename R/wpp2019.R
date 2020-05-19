#' get_wpp2019 -- get UN World Population Projections - 2019 data

get_wpp2019 <- function(LocID = NULL, Location = NULL, Time = NULL, File_Number = 1, Variant = "Medium" ){
  #' United Nations Department of Economic and Social Affairs,
  #'         Population Dynamics, World Population Prospects 2019.
  #'         https://population.un.org/wpp/Download/Standard/CSV/  
  
  require(data.table)
  require(ISOcodes)
  
  #' There are at least ten variations of CSV files from the 2019 UN WPP, and many, many more .XLS files.
  csv_files <- c(
    "WPP2019_TotalPopulationBySex.csv",
    "WPP2019_PopulationByAgeSex_Medium.csv",
    "WPP2019_PopulationByAgeSex_OtherVariants.csv",
    "WPP2019_PopulationBySingleAgeSex_1950-2019.csv",
    "WPP2019_PopulationBySingleAgeSex_2020-2100.csv",
    "WPP2019_Fertility_by_Age.csv",
    "WPP2019_Period_Indicators_Medium.csv",
    "WPP2019_Period_Indicators_OtherVariants.csv",
    "WPP2019_Life_Table_Medium.csv",
    "WPP2019_Life_Table_OtherVariants.csv"
  )
  
  #' Construct the database name
  UN_file_name <- paste0("data/",csv_files[File_Number])
  
  #' This comes from the data.table vignette (https://cran.r-project.org/web/packages/data.table/vignettes/datatable-intro.html)
  input <- if (file.exists(UN_file_name)) {
    UN_file_name
  } else {
    paste0("https://population.un.org/wpp/Download/Files/1_Indicators%20(Standard)/CSV_FILES/",csv_files[File_Number])
    
  }
  
  
  
  
  
  
  
  wpp2019 <- fread(input)  
  
  if(is.null(LocID)){
    if (is.null(Location))
      # Get the whole data set
    else
      # Get the data set for Location only
  }
  else
    # Get the data set for LocID only
    
}
