setwd("C:/Users/Marcelo/Desktop/Coursera")

# Asking a question

# EDA - Air Pollution in the US
# fine particles in the air
# Q1. Are air pollution levels lower than before the laws?

#Reading data for 1999

pm0 <- read.table("data/RD_501_88101_1999-0.txt", comment.char = "#",
                  header = FALSE, sep = "|", na.strings = "")

dim(pm0)

head(pm0)

# getting column names from the fisrt line of the file
cnames <- readLines("data/RD_501_88101_1999-0.txt", 1)

# splitting the names
cnames <- strsplit(cnames, "|", fixed = TRUE) # strsplit returns a list
cnames

names(pm0) <- make.names(cnames[[1]]) # replace the values for a valid name colum names for data frame
head(pm0)

# removing PM2.5 (Sample Value ug/m3)
x0 <- pm0$Sample.Value
class(x0)
str(x0)
summary(x0) # ~ 13217 missing values

# % of missing values
mean(is.na(x0)) # ~ 11.2%

#  Having 11% of your values missing going to make a big difference in your analysis?

# Reading the 2012 dataset
pm1 <- read.table("data/RD_501_88101_2012-0.txt", comment.char = "#",
               header = FALSE, sep = "|", na.strings = "")

dim(pm1)

#Estimating how much memory the data frame requires
# 8 bytes x row

memory = (nrow(pm1)*ncol(pm1)*8)/2^20
memory

# the column names are the same - assing cnames
names(pm1) <- make.names((cnames[[1]]))

head(pm1)

# removing pm2.5 values for 2012
x1 <- pm1$Sample.Value
str(x1)
summary(x1)
summary(x0)

# Median 2012 = 7.6 and 1999 = 11.5 

mean(is.na(x1)) # around 5%  - probably not a big deal

# On first glance, it appears that, The the, the five 
# levels have gone down over the years. And so, that's
# good, that's good news for public health.

# Graphical representations
boxplot(x0,x1)

boxplot(log10(x0), log10(x1))

# Mean during 2012 is a little bit lower, however the spread is higher

# Negative values in 2012 data, it is unusual to have negative values

sumamry(x1)

negative <- x1 < 0 # logical vector
sum(negative, na.rm = TRUE)
# about 26400 negative values
mean(negative, na.rm = TRUE) # around 2 %

dates <- pm1$Date
str(dates) # integer vector

# convert to date variable

dates <- as.Date(as.character(dates), "%Y%m%d")
str(dates)

hist(dates, "month")

# Negative values
hist(dates[negative], "month")

# Exploring change at one monitor

site0 <- unique(subset(pm0, State.Code == 36, c(County.Code, Site.ID)))
site1 <- unique(subset(pm1, State.Code == 36, c(County.Code, Site.ID)))

head(site0)

site0 <- paste(site0[,1], site0[,2], sep = ".")
site1 <- paste(site1[,1], site1[,2], sep = ".")

str(site0)
str(site1)

# intersaction between monitors of 1999 and 2012

both <- intersect(site0, site1)

both

# how many observations are available in each monitor

pm0$county.site <- with(pm0, paste(County.Code, Site.ID, sep = "."))
pm1$county.site <- with(pm1, paste(County.Code, Site.ID, sep = "."))

# subset to NY

cnt0 <- subset(pm0, State.Code == 36 & county.site %in% both)
cnt1 <- subset(pm1, State.Code == 36 & county.site %in% both)

head(cnt0)

# Split df into separated df for each monitor

sapply(split(cnt0, cnt0$county.site), nrow)
# number of observations for each monitor in both df in the city of NY

sapply(split(cnt1, cnt1$county.site), nrow)

pm1sub <- subset(pm1, State.Code == 36 & County.Code == 63 & Site.ID == 2008)
pm0sub <- subset(pm0, State.Code == 36 & County.Code == 63 & Site.ID == 2008)

dim(pm1sub)
dim(pm0sub)

# temporal series 

dates1 <- pm1sub$Date
dates1 <- as.Date(as.character(dates1), "%Y%m%d")
x1sub <- pm1sub$Sample.Value

# 2012 data
plot(dates1, x1sub)

dates0 <- pm0sub$Date
dates0 <- as.Date(as.character(dates0), "%Y%m%d")
x0sub <- pm0sub$Sample.Value

# 1999 data
plot(dates0, x0sub)

par(mfrow = c(1, 2), mar = c(4, 4, 2, 1))
plot(dates0, x0sub, pch = 20)
abline(h = median(x0sub, na.rm = TRUE))
plot(dates1, x1sub, pch = 19)
abline(h = median(x1sub, na.rm = TRUE))

# put the two plot on the same range
range(x0sub, x1sub, na.rm = TRUE)
rng <- range(x0sub, x1sub, na.rm = TRUE)

par(mfrow = c(1, 2), mar = c(4, 4, 2, 1))
plot(dates0, x0sub, pch = 20, ylim = rng)
abline(h = median(x0sub, na.rm = TRUE))
plot(dates1, x1sub, pch = 20, ylim = rng)
abline(h = median(x0sub, na.rm = TRUE))

# exploring changes at a State level

head(pm0)
# extract the average Sample.value by State

mn0 <- with(pm0, tapply(Sample.Value, State.Code, mean, na.rm = TRUE))
str(mn0)
summary(mn0)                        

mn1 <- with(pm1, tapply(Sample.Value, State.Code, mean, na.rm = TRUE))
str(mn1)
summary(mn1)                        

# df containing the ID of the state and average Sample.Value
d0 <- data.frame(state = names(mn0), mean = mn0)
d1 <- data.frame(state = names(mn1), mean = mn1)

head(d0)
head(d1)

mrg <- merge(d0, d1, by = "state")

str(mrg)
head(mrg)

par(mfrow = c(1, 1))
with(mrg, plot(rep(1999, 52), mrg[,2], xlim = c(1998, 2013)))
with(mrg, points(rep(2012, 52), mrg[,3]))
segments(rep(1999, 52), mrg[,2], rep(2012, 52), mrg[,3]) 


