## Reading Data from MYSQL database
# most widely used open source database
# widely used in internet based app

# Data strucutured 
#       Databases / Tables Fields
# MYSQL wikipedia
library(RMySQL)
ucscDb <- dbConnect(MySQL(), user = "genome",
                    host = "genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(ucscDb, "Show databases;"); dbDisconnect(ucscDb)
result

hg19 <- dbConnect(MySQL(), user = "genome", db = "hg19",
                  host = "genome-mysql.cse.ucsc.edu")
allTables <- dbListTables(hg19)
length(allTables)
allTables[1:5]

dbListFields(hg19, "affyU133Plus2")
dbGetQuery(hg19, "select count(*) from affyU133Plus2") #query passed trhough the database counting the rows

#getting the Table out the data frame
affData <- dbReadTable(hg19, "affyU133Plus2")
head(affData)

#Select a specific subset
query <- dbSendQuery(hg19, "select * from affyU133Plus2 where mismatches between 1 and 3")
affMis <- fetch(query); quantile(affMis$misMatches)

affMisSmall <- fetch(query, n=10); dbClearResult(query);
dim(affMisSmall)

# Don't forget to close the connection
dbDisconnect(hg19)

## reading HDF5
# used for storage large data sets, hierachical data format
# groups cointaning zeros or more data sets/metadata
source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")
library (rhdf5)

# Reading data from Web
# Webscraping programatically getting data from the HTML code of websites

# getting data from Google Scholar
con = url("https://scholar.google.com.br/citations?user=GtCk-WsAAAAJ&hl=pt-BR")
htmlCode = readLines(con)
close(con)
htmlCode

# Parsing with XML
library(XML)
url <- "http://scholar.google.com.br/citations?user=GtCk-WsAAAAJ&hl=pt-BR"
html <- htmlTreeParse(url, useInternalNodes = TRUE)

xpathSApply(html, "//title", xmlValue)

xpathSApply(html, "//td[@id = 'col-Citado por']", xmlValue)

# GET from the httr package
library(httr); html2 = GET(url)
content2 = content(html2, as="text")
parsedHtml = htmlParse(content2, asText = TRUE)
xpathSApply(parsedHtml, "//title", xmlValue)

# Accessing websites with passwords

pg1 = GET ("http:/httpbin.org/basic-auth/user/passwd",
           authenticate("user", "passwd"))
pg1

names(pg1)

#Use Handles

google =  handle("http://google.com")
pg1 = GET(handle = google, path = "/")
pg2 = GET(handle = google, path = "search")

pg1
pg2


#READING FROM APIs - Application porgramming interfaces
myapp = oauth_app("twitter",
                  key="yourconsumerkeyhere", secret = "yourconsumersecret")
sig = sign_oauth1.0(myapp,
                    token = "yourtokenhere",
                    token_secret = "yourtokensecret")
homeTL = GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)

json1 = content(homeTL)
json2 = jsonlite::fromJSON((toJSON(json1)))
json2[1,1:4]

## Reading from other sources
#interacting with files
file()
url
gzfile
bzfile
?connections

REMEMBER TO CLOSE CONNECTIONS

foreign package loads data from minitab, S, SAS, SPSS, STATA

