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
survey <- read.csv("acs.csv", header = TRUE)
head(survey)
sqldf("Select pwgtp1 from acs where AGEP < 50")
