# Scrape CDC Web page

# First follow the steps in this tutorial: https://www.analyticsvidhya.com/blog/2017/03/beginners-guide-on-web-scraping-in-r-using-rvest-with-hands-on-knowledge/

# See https://www.r-bloggers.com/using-rvest-to-scrape-an-html-table/

library(rvest)
library(janitor)
library(tidyr)

# Download and extract the table from the web page
flu_url <- "https://www.cdc.gov/flu/about/burden/past-seasons.html"
flu_table <-
  read_html(flu_url) %>%
  html_node("table") %>%
  html_table((fill = TRUE))
  
# Remake the table's names from its split (2-line) headers
names(flu_table) <-
  paste(names(flu_table), as.character(flu_table[1,])) %>% 
  make_clean_names(case = "mixed")

flu_table <- flu_table[-1,] %>%                               # Get rid of the table's pesky first row
  apply(2, gsub, patt = ",|\\(|\\)|\\*", replace = "") %>%    # Eliminate these characters: ",", "(",  ")", "*", and " "
  apply(2, gsub, patt = "\\d\\s\\d", replace = "-") %>%       # Insert a "-" between numbers in range fields currently separated by a single " "
  apply(2, gsub, patt = "\\s", replace = "") %>%              # Get rid of all remaining spaces
  as.data.frame() %>%                                         # Make it a dataframe
  .[grepl("\\d",.$Season),] %>%                               # Select only lines with digits in the Season column (eliminates the row separating the Preliminary estimates)
  # Split columns containing ranges
  separate(Season, c("Season_Start", "Season_End")) %>%             
  separate(Symptomatic_Illnesses_95_percent_U_I, c("Symptomatic_Illness_95_Pct_UI_Lo", "Symptomatic_Illness_95_Pct_UI_Hi")) %>% 
  separate(Medical_Visits_95_percent_U_I, c("Medical_Visits_95_Pct_UI_Lo", "Medical_Visits_95_Pct_UI_Hi")) %>% 
  separate(Hospitalizations_95_percent_U_I, c("Hospitalizations_95_Pct_UI_Lo", "Hospitalizations_95_Pct_UI_Hi")) %>% 
  separate(Deaths_95_percent_U_I, c("Deaths_95_Pct_UI_Lo", "Deaths_95_Pct_UI_Hi")) %>% 
  apply(2,as.numeric) %>%                                    # Make everything numeric
  as.data.frame()                                            # Convert it back to a data frame

# Calculate the means
means <- apply(flu_table[,c(3, 6, 9, 12)],2,mean)
# And display them
format(round(means,0), nsmall = 0, big.mark = ",")

# Case mortality rates (per 100,000)
cmr <- data.frame(paste0(flu_table[,1], "-", flu_table[,2]),100000 * flu_table[,12]/flu_table[,3])
names(cmr) <- c("season", "cmr")