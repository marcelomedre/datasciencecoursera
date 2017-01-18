## dplyr package
#there is one obs per row
#every column = variable

# base select, filter, arrange, rename, mutate, summarise

# select = columns
# filter = rows
# mutate = add new variables
# summarise = gen statistics

# result = data frame

### Managing data frames

library(dplyr)
chicago <- readRDS("./data/chicago.rds")
dim(chicago)
str(chicago)

names(chicago)
head(select(chicago, city:dptp))

head(select(chicago, -(city:dptp)))

### FILTER

chic.f <- filter(chicago, pm25tmean2 > 30)
head(chic.f)

chic.f <- filter(chicago, pm25tmean2 > 30 & tmpd > 80)
head(chic.f)

### ARRANGE

chicago <- arrange(chicago, date)
head(chicago)

chicago <- arrange(chicago, desc(date))
head(chicago)


### RENAME
chicago <- rename(chicago, pm25 = pm25tmean2, dewpoint = dptp)
head(chicago)

### MUTATE
chicago <- mutate(chicago, pm25detrend = pm25-mean(pm25, na.rm = TRUE))
head(select(chicago, pm25, pm25detrend))

### GROUP
chicago <- mutate(chicago, tempcat = factor(1*(tmpd > 80), labels = c("cold", "hot")))
hotcold <- group_by(chicago, tempcat)
hotcold

summarise(hotcold, pm25 = mean(pm25, na.rm = TRUE), o3 = max(o3tmean2), no2 = median(no2tmean2))

chicago <- mutate(chicago, year = as.POSIXlt(date)$year + 1900)
years <- group_by(chicago, year)
summarise(years, pm25 = mean(pm25, na.rm = TRUE), o3 = max(o3tmean2), no2 = median(no2tmean2))


chicago %>% mutate(month = as.POSIXlt(date$mon+1)%>% group_by(month)%>%
                           summarise(pm25 = mean(pm25, na.rm = TRUE),
                                     o3 = max(o3tmean2), no2 = median(no2tmean2)))
