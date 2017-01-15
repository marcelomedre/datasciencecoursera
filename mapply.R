noise <- function(n,mean, sd){
        rnorm(n, mean, sd)
}

#instant vectorization
#mapply fun   #n   mean sd
mapply(noise, 1:5, 1:5, 2)

#split
x<-c(rnorm(10), runif(10), rnorm(10,1))
f<-gl(3,10)#split x vector in 3 parts with 10 obj
split(x,f)#split returns a list

lapply(split(x,f), mean)#used in conjunction with lapply

#example
library(datasets)
head(airquality)
#calculate the mean of ozone within each month
#split the data frame into monthly pieces
s<-split(airquality, airquality$Month)
lapply(s, function(x) colMeans(x[,c("Ozone", "Solar.R", "Wind")]))
#lapply returns a list of length 3, in which each element is the mean of OZONE, SOLAR and Wind

#NA missing values influences the mean
#instead of using lapply, I can use sapply to simplify the results
sapply(s, function(x) colMeans(x[,c("Ozone", "Solar.R", "Wind")]))
#put all the numbers into a matrix
#removing NA values
sapply(s, function(x) colMeans(x[,c("Ozone", "Solar.R", "Wind")], na.rm = TRUE))


#Splitting on More than one level
x <- rnorm(10)
f1 <- gl(2, 5)
f2 <- gl(5,2)
interaction(f1,f2)

str(split(x, list(f1,f2)))#instead of using interaction function

str(split(x, list(f1,f2), drop = TRUE))#drop the empty levels
    