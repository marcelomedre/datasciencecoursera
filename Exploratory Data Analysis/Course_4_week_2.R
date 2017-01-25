# Course 4 week 2

library(ggplot2)

# ggplot2 - part 1
# Grammar of graphics
# qplot function - quick plot
# aesthetics ( size, shape, color)
# geoms (points, lines)

# Factor indicates subsets of the data

# mpg dataset
str(mpg)

qplot(displ, hwy, data = mpg)

qplot(displ, hwy, data = mpg, color = drv)

# Adding a geom
qplot(displ, hwy, data = mpg, geom = c("point", "smooth"))

#histogram
qplot(hwy, data = mpg, fill = drv)

# facets - like panels

qplot(displ, hwy, data = mpg, facets =.~drv)
qplot(hwy, data = mpg, facets =drv ~., bindwidth = 2)

library(nlme)
library(lattice)

xyplot(weight ~ Time | Diet, BodyWeight)

library(datasets)
data(airquality)
xyplot(Ozone ~ Wind | factor(Month), data = airquality)

qplot(Wind, Ozone, data = airquality, facets = . ~ factor(Month))
qplot(Wind, Ozone, data = airquality, geom = "smooth")

airquality = transform(airquality, Month = factor(Month))
qplot(Wind, Ozone, data = airquality, facets = . ~ Month)
qplot(Wind, Ozone, data = airquality)


library(ggplot2)
library(ggplot2movies)
g <- ggplot(movies, aes(votes, rating))
print(g)

qplot(votes, rating, data = movies)
qplot(votes, rating, data = movies, smooth = "loess")
qplot(votes, rating, data = movies, smooth = "loess")
qplot(votes, rating, data = movies) + geom_smooth()
qplot(votes, rating, data = movies) + stats_smooth("loess")

#ggplot2 Plotting System - Part 2

# geoms = objetcts
# facets = conditional plots multiple panels
# stats = statistic transformations
# scale = male, female example
# coord system
# plot are built up in layers
# - plot the data
# - overlay a summary
# - metadata and annotation

g <- ggplot(maacs, aes(logpm25, NocturnalSympt))
summary(g)

p <- g + geom_point() # Save and Print ggplot object

g + geom_point() # auto-print object without saving

# adding more layers  - Smooth geom_smooth()
# Facets - facet_grid(.~ factor) # plots = # levels on your factor
# Facets are useful for categorical variables
# Annotation xlab(), ylab() ggtitle()
# modifying aesthetics
#geom_point(aes(color = "steelblue" size = 4, alpha = 1/2(transparency)))
# labs() modify the labels
# theme_bw

# A note about Axis Limits
testdat <- data.frame(x = 1:100, y = rnorm(100))
testdat[50,2] <- 100
plot(testdat$x, testdat$y, type = 'l', ylim = c(-3,3))

library(ggplot2)
g <- ggplot(testdat, aes(x = x, y = y))
g + geom_line()

g + geom_line() + ylim(-3,3)

g + geom_line() + coord_cartesian(ylim = c(3,-3))

