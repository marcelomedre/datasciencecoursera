setwd("C:/Users/Marcelo/Desktop/Coursera/Repo/datasciencecoursera/Getting and Cleaning Data")

#subsetting and sorting
set.seed(12345)
X <- data.frame("var1" = sample(1:5), "var2" = sample(6:10), "var3" = sample(11:15))
X <- X[sample(1:5),];X$var2[c(1,3)] = NA
X

#subsetting in specific column

X[,1]

X[,"var1"]

#subsetting by column and rows
X[1:2,"var2"]

#Subsetting using logical statments
X[(X$var1 <= 3 & X$var3 > 11),]
# using or
X[(X$var1 <= 3 | X$var3 > 15),]

# Dealing with NA values
X[which(X$var2>8),]

#sort
sort(X$var1)

sort(X$var2, na.last = TRUE)

#Ordering

X[order(X$var1,X$var3),]

#ordering with plyr
library(plyr)
arrange(X, var1)

#adding rows and columns
X$var4 <- rnorm(5)
X
###############################

#Summarizing Data
if(!file.exists("./data")){dir.create("./data")}
fileUrl <-"https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "./data/restaurants.csv", method = "auto")
restData <- read.csv("./data/restaurants.csv")

head(restData, n=3)
tail(restData, n=3)

summary(restData)

str(restData)

quantile(restData$councilDistrict, na.rm = TRUE)

table(restData$zipCode, useNA = "ifany")

#2D table
table(restData$councilDistrict,restData$zipCode)


# Checking for missing values
sum(is.na(restData$councilDistrict))

any(is.na(restData$councilDistrict))

all(restData$zipCode > 0)

#Row and colimn sums
colSums(is.na(restData))

all(colSums(is.na(restData))==0)

#Value with specific characteristics

table(restData$zipCode %in% c("21212"))

#subsetting using specific characteristics
restData[restData$zipCode %in% c("21212", "21213"),]

# Cross tabs
data("UCBAdmissions") #data set
DF = as.data.frame(UCBAdmissions)
summary(DF)

xt <- xtabs(Freq ~ Gender + Admit, data = DF)
xt

#Flat tables
warpbreaks$replicate <- rep(1:9, len = 54)
xt = xtabs(breaks ~., data = warpbreaks)
xt

ftable(xt)

#size of the data set

fakeData = rnorm(1e5)
object.size(fakeData)
print(object.size(fakeData), units = "Mb")

# Creating new variables
# some of the variables are not in the data set
# common variables created
# missingness indicators
# cutting up quantitative variables
# applying transformations

s1 <- seq(1,10, by = 2); s1

x <- c(1, 3, 8, 25, 100); seq(along=x)

#subsetting by proximity of the neighborhoods
restData$nearMe = restData$neighborhood %in% c("Roland Park", "Homeland")
table(restData$nearMe)

#creating binary variables

restData$zipWrong = ifelse(restData$zipCode < 0, TRUE, FALSE)
table(restData$zipWrong, restData$zipCode < 0)

#categorical variables
restData$zipGroups = cut(restData$zipCode, breaks = quantile(restData$zipCode))
table(restData$zipGroups)

library(Hmisc)
restData$zipGroups = cut2(restData$zipCode, g=4)
table(restData$zipGroups)

#Creating factor variables
restData$zcf <- factor(restData$zipCode)
restData$zcf[1:10]
class(restData$zcf)

# Cutting produces factor variables

#Using mutate functios
library(plyr)
restData2 = mutate(restData, zipGroups=cut2(zipCode, g= 4))
table(restData2$zipGroups)

###############################

# RESHAPING DATA

# the gola is tidy DATA

library(reshape2)
head(mtcars)

#melting data frames
mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars, id = c("carname", "gear", "cyl"), measure.vars = c("mpg", "hp"))
head(carMelt, n = 3)

cylData <- dcast(carMelt, cyl ~ variable)
cylData

cylData <- dcast(carMelt, cyl ~ variable, mean)
cylData

head(InsectSprays)

tapply(InsectSprays$count, InsectSprays$spray, sum)

spIns = split(InsectSprays$count, InsectSprays$spray)
spIns

sprCount = lapply(spIns, sum)
sprCount

unlist(sprCount)
sapply(spIns,sum)
library(plyr)
ddply(InsectSprays,.(spray), summarise, sum=sum(count))

spraySums <- ddply(InsectSprays,.(spray), summarise, sum=ave(count, FUN=sum))
dim(spraySums)      
head(spraySums)
