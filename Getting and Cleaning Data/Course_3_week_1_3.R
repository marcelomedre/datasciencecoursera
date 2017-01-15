if(!file.exists("data")){
  dir.create("data")
}

## Getting data from internet

download.file()

## important url, destfile and method

## useful to tab-delimited, csv and other files.

## EXAMPLE - Baltimore camera data

if(!file.exists("data")){
  dir.create("data")
}

fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "./data/cameras.csv", method = "auto")
list.files("./data")

dateDownloaded <- date()
dateDownloaded

## Reading local flat files

# read.table() - most flexible function using R can be slow
# important parameters, file, headerrrrr, sep, row.names, nrows
# Related read files function read.csv

cameraData <- read.table("./data/cameras.csv", sep = ",", header = TRUE)
head(cameraData)

cameraData <- read.csv("./data/cameras.csv")
head(cameraData)

#quote values = tell R any quoted values quote="" means no quotes
#na.strings - set the character that represents a missing value
#nrows - how many rows to read
#skip - number of lines to skip before starting

## Excel files downloading excel file
if(!file.exists("data")){dir.create("data")}

fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.tsv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "./data/cameras.xlsx", method = "libcurl")
list.files("./data")

library(xlsx)
cameraData <- read.xlsx("./data/cameras.xlsx", sheetIndex= 1,header=TRUE)
dateDownloaded <- date()
dateDownloaded
head(cameraData)

# Reading especific row and columns
colIndex <- 2:3
rowIndex <- 1:4
cameraDataSubset <- read.xlsx("./data/cameras.xlsx", sheetIndex = 1, 
                              colIndex = colIndex, rowIndex = rowIndex)
cameraDataSubset

## Reading XML - extensible markup language
# store strucutred data, used in internet app
# basis  for most web scraping
# Contents - Markups and Content
# tags - start tag, end tag <section> </section>
# empty - tags <line-break / >
# attributes are components of the labels
# <img src .... > / < step number = "3"> Connect A to B </step>

install.packages("XML")
library(XML)
fileUrl <- "http://www.w3schools.com/xml/simple.xml"
# useInternal fucntion get all the tag inside the documents
doc <- xmlTreeParse(fileUrl, useInternal = TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
names(rootNode)
rootNode[[1]]

#Programatically extract parts of the file
xmlSApply(rootNode, xmlValue)

#rootNode = entire document
xpathSApply(rootNode, "//name", xmlValue)
xpathSApply(rootNode, "//price", xmlValue)

#Reading JSON
# structured file such as xml
# lightweight data storage
# syntax diferent from xml
library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)

#Data.table package all func that work in data frame should work in data table
library(data.table)
DF <- data.frame(x=rnorm(9), y=rep(c("a", "b", "C"), each = 3), z=rnorm(9))
head(DF, 3)

DT <- data.table(x=rnorm(9), y=rep(c("a", "b", "C"), each = 3), z=rnorm(9))
head(DT, 3)
tables() # see all the tables in memory
DT[2,] #subsetting rows
DT[c(2,3)]
# Subesetting columns are different
# command := add new column
# especial function .N an integer, length 1 containing number r
# keys - setkey(DF,x)