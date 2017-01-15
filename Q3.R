library(datasets)
data("iris")
mean(iris[iris$Species == "virginica",]$Sepal.Length)

apply(iris[,1:4],2,mean)


library(datasets)
data("mtcars")
?mtcars
sapply(split(mtcars$mpg, mtcars$cyl), mean)
#How can one calculate the average miles per gallon (mpg) by number of cylinders in the car (cyl)? 
tapply(mtcars)

cyl8 <-mean(mtcars[mtcars$cyl== "8",]$hp)
cyl4 <-mean(mtcars[mtcars$cyl== "4",]$hp)
diffhp <- cyl8 - cyl4
diffhp


