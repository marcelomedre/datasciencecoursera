## Course 3 week 3 quiz

setwd("C:/Users/Marcelo/Desktop/Coursera/Repo/datasciencecoursera/Getting and Cleaning Data")
library(dplyr)
library(httr)
library(data.table)

##### 1
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "./data/acs_2.csv", method = "auto")
list.files("./data")
#Loading the data
data <- data.table(read.csv("./data/acs_2.csv"))
str(data)

head(data)
#subsetting into logical
agricultoreLogical <- (data$ACR == 3 & data$AGS == 6)

head(agricultoreLogical, n = 3)
which(agricultoreLogical)[1:3]

####### 2

library(jpeg)
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(fileurl, destfile = "./data/jeff.jpeg", mode = "wb")
#Loading the data
img <- readJPEG("./data/jeff.jpeg", native = TRUE)

str(img)
quantile(img, probs = c(0.30, 0.80))

###### 3
# Gross Domestic Product data for the 190 ranked countries in this data set
fileUrl1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl1, destfile = "./data/GDP.csv", method = "auto")
# Educational data from this data set:
fileUrl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl2, destfile = "./data/Educ.csv", method = "auto")
list.files("./data")

# Loading files

dataGDP <- data.table(read.csv("./data/GDP.csv", skip = 4, nrows = 215))
dataGDP <- select(dataGDP, c(X,X.1,X.3, X.4))
colnames(dataGDP, do.NULL = FALSE)
colnames(dataGDP) <- c("CountryCode", "rankGDP", "Country Name", "GDP")
str(dataGDP)

dataEduc <- read.csv("./data/Educ.csv")

