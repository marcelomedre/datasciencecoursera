# Getting and Cleaning Data week 4 quiz
# Marcelo M Nobrega

# 1
# The American Community Survey distributes downloadable data about United States 
# communities. Download the 2006 microdata survey about housing for the state of 
# Idaho using download.file() from here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
# and load the data into R. The code book, describing the variable names is here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
# Apply strsplit() to split all the names of the data frame on the characters "wgtp".
# What is the value of the 123 element of the resulting list?

library(dplyr)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
if(file.exists("./data")){dir.create("./data")}
download.file(fileUrl, destfile = "idaho_survey.csv", method = "auto")

# Loading file
library(data.table)
dataIdaho <- data.table(read.csv("idaho_survey.csv", stringsAsFactors = FALSE))
names <- names(dataIdaho)

splittedData <- strsplit(names, "wgtp")
splittedData[123]


##### 2

# Load the Gross Domestic Product data for the 190 ranked countries in this data set:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
# Remove the commas from the GDP numbers in millions of dollars and 
# average them. What is the average?
# Original data sources:
# http://data.worldbank.org/data-catalog/GDP-ranking-table 

#downloading file
fileUrl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl2, destfile = "GDP.csv", method = "auto")

# Loading file
dataGDP <- data.table(read.csv("GDP.csv", skip = 4, nrows = 190, stringsAsFactors = FALSE))
dataGDP <- select(dataGDP, c(1, 2, 4, 5))

colnames(dataGDP) <- c("CountryCode", "RankGDP", "Country", "GDP")
names(dataGDP)

dataGDP$numGDP <- as.numeric(gsub(",","",dataGDP$GDP))

average <- mean(dataGDP$numGDP)
average

##### 3
# In the data set from Question 2 what is a regular expression that would 
# allow you to count the number of countries whose name begins with "United"? 
# Assume that the variable with the country names in it is named countryNames.
# How many countries begin with United? 

length(grep("United$", dataGDP$Country))
length(grep("*United$", dataGDP$Country))
length(grep("^United",dataGDP$Country))
length(grep("^United",dataGDP$Country))

##### 4
# Load the Gross Domestic Product data for the 190 ranked countries in this data set:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
# Load the educational data from this data set:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
# Match the data based on the country shortcode. Of the countries for which the 
# end of the fiscal year is available, how many end in June?
# Original data sources:
# http://data.worldbank.org/data-catalog/GDP-ranking-table
# http://data.worldbank.org/data-catalog/ed-stats

#downloading files
fileUrl3 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl3, destfile = "GDP_2.csv", method = "auto")
fileUrl4 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl4, destfile = "Educ.csv", method = "auto")

# Loading files
dataGDP2 <- data.table(read.csv("GDP.csv", skip = 4, nrows = 190, stringsAsFactors = FALSE))
dataGDP2 <- select(dataGDP2, c(1, 2, 4, 5))

colnames(dataGDP2) <- c("CountryCode", "RankGDP", "Country", "GDP")
names(dataGDP2)

dataEduc <- data.table(read.csv("Educ.csv", stringsAsFactors = FALSE))
dataEduc <- dataEduc[,c("CountryCode", "Special.Notes")]

mergedData <- merge(dataGDP2,dataEduc, by.x = "CountryCode", by.y = "CountryCode")

mergedData$Special.Notes[grepl("^Fiscal year end: June 30", mergedData$Special.Notes)]
length(grep("^Fiscal year end: June 30", mergedData$Special.Notes))

##### 5
# You can use the quantmod (http://www.quantmod.com/) package to get historical stock 
# prices for publicly traded companies on the NASDAQ and NYSE. Use the following code
# to download data on Amazon's stock price and get the times the data was sampled.
# How many values were collected in 2012? How many values were collected on Mondays in 2012?

library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

sampleTimes <- data.table(sampleTimes)
sampleTimes12 <- sampleTimes[grep("^2012", sampleTimes)]
#Looking for Mondays
Mondays <- length(which(sampleTimes12Mon$sampleTimes == "segunda-feira"))
Mondays

