getwd()
setwd("C:/Users/Marcelo/Desktop/Coursera/datasciencecoursera/Exploratory Data Analysis")

library(lattice)
#lattice Functions

xyplot # scatterplots
bwplot # box plot

histogram
stripplot # boxplot with points
dotplot # 
splom # scatterplot matrix
levelplot, contourplot # plotting image data

xyplot(y ~ x | f * g, data ) # f and g conditioning variables

library(datasets)

xyplot(Ozone ~ Wind, data = airquality)

airquality <- transform(airquality, Month = factor(Month))
xyplot(Ozone ~ Wind | Month, data = airquality, layout = c(5,1))

p <- xyplot(Ozone ~ Wind, data = airquality)
print(p)

# Panel Functions 
# each panel representes a subset of the data

set.seed(12)
x <- rnorm(100)
f <- rep(0:1, each = 50)
y <- x + f*x + rnorm(100, sd = 0.5)
f <- factor(f, labels = c( "Group 1", "Group 2"))
xyplot(y ~ x | f, layout = c(2,1)) # plot with 2 panels


xyplot(y ~ x | f, panel = function(x,y, ...){
        panel.xyplot(x, y, ...) # First call the default panel function for 'xyplot'
        panel.abline(h = median(y), lty = 2) # add horizontal line at the mediam
})


# Regression line
xyplot(y ~ x | f, panel = function(x,y, ...){
        panel.xyplot(x, y, ...) # First call the default panel function for 'xyplot'
        panel.lmline(x, y, col = 2) # add horizontal line at the mediam
})

# can't mix functions of diff plotting systems

# margins, spacing are automatically handled