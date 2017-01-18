## 3
library(data.table)
library(dplyr)
if(!file.exists("data")){
  dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl, destfile = "./data/GDP.csv", method = "auto")
list.files("./data")

GDPData <- data.table(read.csv("./data/GDP.csv", skip = 5, nrow = 191, header = FALSE))
names(GDPData)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl, destfile = "./data/Educ.csv", method = "auto")
list.files("./data")

EducData <- data.table(read.csv("./data/Educ.csv", header = TRUE))
names(EducData)

GDPData <- select(GDPData, c(1,2, 4, 5))
colnames(GDPData) <- c("CountryCode", "RankGDP", "Country Name", "GDP")

mergedData <- merge(GDPData, EducData, by.x = "CountryCode", by.y = "CountryCode", all = FALSE)
nrow(mergedData)
mergedData2 <- arrange(mergedData, desc(RankGDP))
mergedData2$`Country Name`[13]

### 4

tapply(mergedData$RankGDP, mergedData$Income.Group, mean)

### 5

library(Hmisc)
mergedData$RankGroups <- cut2(mergedData$RankGDP, g = 5)
table(mergedData$RankGroups, mergedData$Income.Group)

