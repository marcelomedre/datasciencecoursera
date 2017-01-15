getwd()
if(!file.exists("data")){
        dir.create("data")
}

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl,destfile = "./data/week1quiz.csv", method = "auto")
houseData <- read.csv("./data/week1quiz.csv")
head(houseData)

length(houseData$VAL[!is.na(houseData$VAL) & houseData$VAL == 24])

fileUrl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl2, destfile = "./data/NatGasAquiProg.xlsx", mode = "wb", method = "auto")
list.files("./data")
library(xlsx)
NGAData <- read.xlsx("./data/NatGasAquiProg.xlsx", sheetIndex= 1,header=TRUE)
dateDownloaded <- date()
dateDownloaded

colIndex <- 7:15
rowIndex <- 18:23

dat <- read.xlsx("./data/NatGasAquiProg.xlsx", sheetIndex= 1,
                 colIndex = colIndex,
                 rowIndex = rowIndex,
                 header=TRUE)
sum(dat$Zip*dat$Ext, na.rm = TRUE)

## 4. 
library(XML)
library(RCurl)
fileUrl3 <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
BaltimoreRestaurants <- xmlTreeParse(fileUrl3, useInternal = TRUE)
rootNode <- xmlRoot(BaltimoreRestaurants)
xmlName(rootNode)
zipcode <- xpathSApply(rootNode, "//zipcode", xmlValue)
length(zipcode[zipcode == 21231])

## 5.
library(data.table)
fileUrl4 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl4, destfile="./data/Housing_Idaho.csv", method="auto")
DT <- fread(input = "./data/Housing_Idaho.csv", sep = ",")

system.time(DT[,mean(pwgtp15), by = SEX])
system.time(mean(DT[DT$SEX==1,]$pwgtp15))
system.time(mean(DT$pwgtp15,by=DT$SEX))
system.time(rowMeans(DT)[DT$SEX==1])
system.time(DT[,mean(pwgtp15),by=SEX])
system.time(tapply(DT$pwgtp15,DT$SEX,mean))

system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
