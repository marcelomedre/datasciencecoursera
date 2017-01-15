## Course 3 week 2 quiz

library(httr)
require(httpuv)
library(jsonlite)

oauth_endpoints("github")

myapp <- oauth_app("quiz2",
                   key = "7bb89f22156737b7958a",
                   secret = "2f8db11bd573309cac5c0435c75d0a80a6c0ccd8")

#get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# Using API

req <- GET("https://api.github.com/users/jtleek/repos", config(token = github_token))
stop_for_status(req)
#Savind the list of repositories 
repo_list <- content(req)
repo_list

repo <- c()
for (i in 1:length(repo_list)){
        repo <- repo_list[[i]]
        if (repo$name == "datasharing"){
                our_repo = repo
                break
        }
}

if(length(our_repo) == 0){
        message("No such repository found :'datasharing'")
}else {
        message("The repository 'datasharing' was created at ", our_repo$created_at)
}
########################################################################################
# Question 2

library(sqldf)
library(RMySQL)

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(url, destfile = "acs.csv", method = "auto")

acs <- read.csv("acs.csv", sep =  ",", header = TRUE)

query1 <- sqldf("Select pwgtp1 from acs where AGEP < 50", drv = "SQLite")
query2 <- sqldf("select pwgtp1 from acs", drv = "SQLite")
query3 <- sqldf("select * from acs where AGEP < 50", drv = "SQLite")
query4 <- sqldf("select * from acs", drv = "SQLite")


########################################################################################
# Question 3

answer <- unique(acs$AGEP)

query1 <- sqldf("select unique AGEP from acs", drv = "SQLite")
query2 <- sqldf("select distinct AGEP from acs", drv = "SQLite")
query3 <- sqldf("select AGEP where unique from acs", drv = "SQLite")
query4 <- sqldf("select distinct pwgtp1 from acs", drv = "SQLite")

identical(answer, query1)
identical(answer, query2)
identical(answer, query3)
identical(answer, query4)

########################################################################################
# Question 4

library(XML)
library(httr)

con <- url("http://biostat.jhsph.edu/~jleek/contact.html")
html <- readLines(con)
close(con) 

#?nchar()
answer <- c(nchar(html[10]), nchar(html[20]), nchar(html[30]), nchar(html[100]))
answer

########################################################################################
# Question 5

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
download.file(url, destfile = "data.for", method = "auto")
lines <- readLines(url, n=10)
# defining the widths of the fixed fields
widths <- c(1, 9, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3)

colNames <- c("filler", "week", "filler", "sstNino12", "filler", 
              "sstaNino12", "filler", "sstNino3", "filler", "sstaNino3",
              "filler", "sstNino34", "filler", "sstaNino34", "filler",
              "sstNino4", "filler", "sstaNino4")

#Read Fixed Width Format Files skiping the 4th column

data <- read.fwf("data.for", widths = widths, header = FALSE, skip = 4, col.names = colNames)

data <- data[, grep("^[^filler]", names(data))]
answer <- sum(data[,4])
answer
