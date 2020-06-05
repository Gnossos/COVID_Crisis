# Scrape CDC Web page

# First follow the steps in this tutorial: https://www.analyticsvidhya.com/blog/2017/03/beginners-guide-on-web-scraping-in-r-using-rvest-with-hands-on-knowledge/

# See https://www.r-bloggers.com/using-rvest-to-scrape-an-html-table/

library("rvest")
library("janitor")

website <- read_html("https://www.cdc.gov/flu/about/burden/past-seasons.html")
web_table <- website %>% html_table(fill = TRUE)
web_table <- clean_names(web_table[[1]])

# The table has only 4 purely numeric columns, all for the estimates.
# Select them with:
estimates <- c(2,4,6,8)

# As downloaded, the first and ninth rows contain character data.
# The first row is the second row of table headings.
# The ninth row is the subheading separating preliminary estimates from the rest.
# Eliminate these rows to allow numeric conversion.
eliminate <- c(1,9)
web_table <- web_table[-eliminate,]

# Now convert to numeric
estimate_cols <- apply(apply(web_table[,estimates],2,gsub, patt=",",replace=""),2,as.numeric)
web_table[,estimates] <- estimate_cols

# Calculate the means
means <- apply(web_table[,estimates],2,mean)

# And display them
format(round(means,0), nsmall = 0, big.mark = ",")

# Case mortality rates (per 100,000)
cmr <- data.frame(web_table[,1],100000 * web_table[,8]/web_table[,2])
names(cmr) <- c("season", "cmr")