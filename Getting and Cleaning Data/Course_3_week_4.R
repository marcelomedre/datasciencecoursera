## gettingt and Cleaning Data week 4
# Editing Text Variables

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "./data/cameras.csv", method = "auto")
cameraData <- read.csv("./data/cameras.csv")
names(cameraData)
tolower(names(cameraData)) # remove capital letter
# toupper to put in upper case

#split names
splitNames = strsplit(names(cameraData), "\\.") #split .
splitNames[[6]]


myList <-list(letters = c("A", "b", "c"), numbers = 1:3, matrix(1:25, ncol = 5))
head(myList)              

myList[1]

#Removing all the periods
splitNames[[6]][1]

firstElement <- function(x){x[1]}
sapply(splitNames, firstElement)

### Peer review data
fileUrl1 <- "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 <- "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(fileUrl1, destfile = "./data/reviews.csv", method = "auto")
download.file(fileUrl2, destfile = "./data/solutions.csv", method = "auto")
reviews <- read.csv("./data/reviews.csv"); solutions <- read.csv("./data/solutions.csv")

head(reviews,2)

head(solutions,2)

names(reviews)
#removing the underscores

sub("_", "", names(reviews)) # sub replace only 1 underscore

testName <- "this_is_a_test"
sub("_", "", testName)

gsub("_","",testName) #gsub replaces all _

#grep() and grepl() searching for specific values

grep("Alameda", cameraData$intersection)

table(grepl("Alemeda", cameraData$intersection))

# subsetting with grepl
cameraData2 <- cameraData[!grepl("Alameda", cameraData$intersection),]

#value = TRUE returrn values with Alameda
grep("Alameda", cameraData$intersection, value = TRUE)

library(stringr)
nchar("Marcelo Medre") # #characters

substr("Marcelo Medre", 1, 7)

paste("Marcelo", "Medre")

paste0("Marcelo", "Medre") #paste with no spaces

str_trim("marcelo      ")

#################################################################

#Regular Expressions

# Literals = words that match exactly
# match occures if the sequence of literals occurs anywhere in the text being tested

# We need a way to express whitespace
# match at the start of a line
^i think

# $ represents the end of a line
$morning

# Considering a list 
[Bb][Uu][Ss][Uu]

^[Ii] am # match I am and i am at the begginig of a line

^[0-9][a-zA-Z] # match everything that starts with a number followed by a letter

#beggining of character class NOT in the indicated class
[^?.]$
  
#More Metacharacters

  dot # all characters = .
9.11

#or |
flood|fire|hurricane

^[Gg]ood|[Bb]ad #looking for Ggood at the begginig of the line or Bad anywhere in the line
^([Gg]ood|[Bb]ad) # both at the begginig o the line

[Gg]eorge( [Ww]\.)? [Bb]ush #? optional \ consider the dot a literal dot

(.*) #somtehing between parathesis repeatead any number of times

# + at least one of the item
[0-9]+ (.*)[0-9]+

## Working with dates

d1 = date()
d1

class(d1)

d2 = Sys.Date()
class(d2)

# formatting dates
# %d = day as number
# %a = abbreviated weeday
# %A = unabbreviated weeday
# %m =  month number
# %b = abbr month
# %B = unabbr month
# %y = 2 year digit
# %Y = 4 year digit

format(d2, "%a "%b %y")

x=c("1jan1960", "2jan1960", "31mar1960", "30jul1960")
z= as.Date(x, "%d%b%Y")
z
z[1]-z[2]

as.numeric(z[1]-z[4])

# Converting to Julian
weekdays(d2)
months(d2)
julian(d2)

library(lubridate) #convert number to a date

ymd("20140108")
mdy("08/08/2015")
dmy("14/08/1988")

ymd_hms("2014-08-19 10:15:33")

ymd_hms("2014-08-19 10:15:33", tz = "Pacific/Auckland")

x=dmy(c("1jan1960", "2jan1960", "31mar1960", "30jul1960"))
wday(x[1])

wday(x[1], label = TRUE)

POSIXct
POSIClt


