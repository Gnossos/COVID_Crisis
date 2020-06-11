# Scraping HTML Tables (BLS)
# Based on http://bradleyboehmke.github.io/2015/12/scraping-html-tables.html

# Uses BLS Current Employment Statistics - CES (National): https://www.bls.gov/web/empsit/cesbmart.htm


# PART I: Using rvest package
library(rvest)
library(XML)

webpage <- read_html("https://www.bls.gov/web/empsit/cesbmart.htm")

tbls <- html_nodes(webpage, "table")
head(tbls)

# Select two tables
tbl_ls <- webpage %>%
  html_nodes("table") %>%
  .[3:4] %>%
  html_table(fill=TRUE)

str(tbl_ls)

# Do the same with the CDC data.
cdc_webpage <- read_html("https://www.cdc.gov/flu/about/burden/past-seasons.html")
cdc_tbls <- html_nodes(cdc_webpage, "table")
head(cdc_tbls)

cdc_tbl_ls <- cdc_webpage %>%
  html_nodes("table") %>%
  .[1] %>%
  html_table(fill = TRUE)

str(cdc_tbl_ls)

# Now try using the element selector process.
tbls2_ls <- list()

# scrape Table 2. Nonfarm employment...
tbls2_ls$Table2 <- webpage %>%
  html_nodes("#Table2") %>%
  html_table(fill = TRUE) %>%
  .[[1]]

# Table 3. Net birth/deaths...
tbls2_ls$Table3 <- webpage %>%
  html_nodes("#Table3") %>%
  html_table(fill = TRUE) %>% 
  .[[1]]

str(tbls2_ls)

# remove row 1 that includes part of the headings
tbls2_ls[[1]] <- tbls2_ls[[1]][-1,]

# rename table headings
colnames(tbls2_ls[[1]]) <- c("CES_Industry_Code", "Ind_Title", "Revised", "Previous", "Differences", "Pct_Differences")


## Now try the same with CDC data
cdc_tbl2_ls <- list()

# Scrape Table 1
cdc_tbl2_ls$Table1 <- cdc_webpage %>% 
  html_nodes("table") %>% 
  html_table(fill = TRUE) %>% 
  .[[1]]

# Save the first row (and headings) for later use. Then delete it.
cdc_row1 <- cdc_tbl2_ls$Table1[1,]
cdc_tbl2_ls$Table1 <- cdc_tbl2_ls[[1]][-1,]


cdc_table <- readHTMLTable("https://www.cdc.gov/flu/about/burden/past-seasons.html") 
                           
                           
                           header = TRUE,
                           colClasses = c("date",
                           "FormattedInteger",
                           "FormattedInteger",
                           "FormattedInteger",
                           "FormattedInteger",
                           "FormattedInteger",
                           "FormattedInteger",
                           "FormattedInteger",
                           "FormattedInteger",
                           "FormattedInteger",
                           skip.rows = c(1,9),
                           trim = TRUE)
                           
                           )