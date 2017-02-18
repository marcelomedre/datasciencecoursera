rm(list = ls())
# Hierarchical Clustering

# visualizing high dimensional datasets
# Organizes things that are close into groups

# Common approach - bottom-up approach
# agglomerative approach
# - Find closest two things
# - put them together
# - require a defined distance
# - a merging approach
# - prod a tree showing how close things are

# What do we mean by CLOSE???
# - euclidian distance - metric - straight line between 2 things
# - binary/ manhattan distance - follow a certain path
# - you have to travel along the city blocks, not a straigh line

# Hierarchical Clustering - EXAMPLE

set.seed(1234)
par(mar = c(0,0,0,0))
x <- rnorm(12, mean = rep(1:3, each = 4), sd = 0.2)
y <- rnorm(12, mean = rep(c(1,2,1), each = 4), sd = 0.2)
plot(x,y, col = "blue", pch = 19, cex = 2)
text(x + 0.05, y + 0.05, labels = as.character(1:12))

# begins with data frame calucltaing the distances between all the points
dataFrame <- data.frame( x = x, y = y)
dist(dataFrame) # distance matrix - default = euclidian distance

distxy <- dist(dataFrame)
hClustering <- hclust(distxy)
plot(hClustering)

# Dendrogram plots the points that are close together
# Cut the tree to determine how many clusters there are
# if I cut ate the level 2.0 I would have 2 branches(Clusters)

# the Rule to cut?

## PRETTIER DENDROGRAMS

mplClust <- function(hclust, lab = hclust$labels, lab.col=rep(1, length(hclust$labels)),
                     hang = 0.1, ...) {
  y <- rep(hclust$height, 2)
  x <- as.numeric(hclust$merge)
  y <- y[which(x < 0)]
  x <- x[which(x < 0)]
  x <- abs(x)
  y <- y[order(x)]
  x <- x[order(x)]
  plot(hclust, labels = FALSE, hang = hang, ...)
  text(x=x, y = y[hclust$order] - (max(hclust$height)*hang), labels=lab[hclust$order],
       col = lab.col[hclust$order], srt=90, adj = c(1,0.5), xpd=NA, ...)
}
# must specify how many clusters n = 3
mplClust(hClustering, lab = rep(1:3, each = 4), lab.col = rep(1:3, each = 4))


# Merging points - how do you merge points and what does the new locations represents?
# center of gravity o that group of points

# 2 approaches - complete and average

# heatmap() function
# hierarchiacl cluster analysis among the rowns and columsn of the table

dataFrame <- data.frame(x = x, y = y)
set.seed(143)
dataMatrix <- as.matrix(dataFrame)[sample(1:12),]
heatmap(dataMatrix)


## K-Means clustering

# summarizing big data
# - define close things, how group things
# definition of distances
# - continuos distances - euclidean
# - continuos - correlation dst
# - binary - manhattan

# K-Means - fix nmber of clusters, get centroids of each cluster
# - assing things to the closest centroid and recalculate centroids

# Requires
# - defined distance metric, number of cluster and initial guess about centroid

# Produces:
# final estimate about centroids and assing each point to clusters

plot(x,y, col = "blue", pch = 19, cex = 2)
text(x + 0.05, y + 0.05, labels = as.character(1:12))

# kmeans () important paramx, centers, iter.max, nstart
kmeansObj <- kmeans(dataFrame, centers = 3)
names(kmeansObj)

par(mar = rep(0.2, 4))
plot(x, y, col = kmeansObj$cluster, pch = 19, cex = 2 )
points(kmeansObj$centers, col = 1:3, pch = 3, cex = 3, lwd = 3)

#heatmaps using kmeans

kmeansObjs2 <- kmeans(dataMatrix, centers = 3)
par(mfrow = c(1,2), mar = c(2,4,0.1,0.1))
image(t(dataMatrix)[,nrow(dataMatrix):1],yaxt = "n")
image(t(dataMatrix)[,order(kmeansObjs2$cluster)],yaxt = "n")

# PCA and singular value decomposition

set.seed(12345)
par(mar = rep (0.2, 4))
dataMatrix <- matrix(rnorm(400), nrow = 40)
image(1:10, 1:40, t(dataMatrix)[,nrow(dataMatrix):1])

#cluster analysis
par(mar = rep(0.2, 4))
heatmap(dataMatrix)

# What if we add a pattern??

set.seed(678910)
for (i in 1:40){
        #flip a coin
        coinFlip <- rbinom(1, size = 1, prob = 0.5)
        # if a coin is heads add a common pattern to the row
        if (coinFlip){
                dataMatrix[i,] <- dataMatrix[i,] + rep(c(0, 3), each = 5)
        }
}

par(mar = rep(0.2, 4))
image(1:10, 1:40, t(dataMatrix)[,nrow(dataMatrix):1])
heatmap(dataMatrix)

# 2 clusters in the columns by the analysis of the heat map

hh <- hclust(dist(dataMatrix))
dataMatrixOrdered <- dataMatrix[hh$order,]
par(mfrow = c(1,3))
image(t(dataMatrixOrdered)[, nrow(dataMatrixOrdered):1])
plot(rowMeans(dataMatrixOrdered), 40:1, xlab = "Row Mean", ylab = "Row", pch = 19)
plot(colMeans(dataMatrixOrdered), xlab = "Column", ylab = "Column Mean", pch = 19)

# if you put all the variables together in one matrix, find the best matrix created
# by fewer variables that explains the original data

# Principal component analysis
# singular valued compositions
# SVD decomposes the original data matrix into 3 matrices

# PCA uses SVD take the column mean and divide by std of the variables

svd1 <- svd(scale(dataMatrixOrdered))
par(mfrow = c(1,3))
image(t(dataMatrixOrdered)[,nrow(dataMatrixOrdered):1])
# mean of the data setm are positive for half of the data and negative
plot(svd1$u[,1], 40:1, xlab = "Row", ylab = "left singular vector", pch = 19)
# means are higher for first 5 columns and lower for last 5
plot(svd1$v[,1], xlab = "Column", ylab = "First right singular vector", pch = 19)


# Variance explained - d matrix
par(mfrow = c(1,2))
plot(svd1$d, xlab = "Column", ylab = "Singular Values", pch = 19)
plot(svd1$d^2/sum(svd1$d^2), xlab = "Column", ylab = "Prop. of Variance explained", pch = 19)

# Relationship to Principal components

svd1 <- svd(scale(dataMatrixOrdered))
pcal <- prcomp(dataMatrixOrdered, scale = TRUE)
plot(pcal$rotation[,1], svd1$v[,1], pch = 19, xlab = "Principal component 1",
     ylab = "Right Singular Vector 1")
abline(c(0,1))

# second pattern
set.seed(678910)
for(i in 1:40){
        #flip a coin
        coinFlip1 <- rbinom(1, size = 1, prob = 0.5)
        coinFlip2 <- rbinom(1, size = 1, prob = 0.5)
        # if coin is heads add a common pattern to that row
        if (coinFlip1){
                dataMatrix[i,] <- dataMatrix[i,] + rep(c(0,5), each = 5)
        }
        if (coinFlip2){
                dataMatrix[i,] <- dataMatrix[i,] + rep(c(0,5), each = 5)
        }
}

hh <- hclust(dist(dataMatrix))
dataMatrixOrdered <- dataMatrix[hh$order,]

svd2 <- svd(scale(dataMatrixOrdered))
par(mfrow = c(1,3))
image(t(dataMatrixOrdered)[,nrow(dataMatrixOrdered):1])
plot(rep(c(0,1), each = 5), pch = 19, xlab = "Column", ylab = "Pattern 1")
plot(rep(c(0,1), 5), pch = 19, xlab = "Column", ylab = "Pattern 2")

svd2 <- svd(scale(dataMatrixOrdered))
par(mfrow = c(1,3))
image(t(dataMatrixOrdered)[,nrow(dataMatrixOrdered):1])
plot(svd2$v[,1], pch = 19, xlab = "Column", ylab = "First right singular vector")
plot(svd2$v[,2], pch = 19, xlab = "Column", ylab = "Second right singular vector")


# Missing values

dataMatrix2 <- dataMatrixOrdered
#randomly insert some missing data
dataMatrix2[sample(1:100, size = 40, replace = FALSE)] <- NA
svd1 <- svd(scale(dataMatrix2))

# Cleaning missing values before running svd 
# impute package
library(impute)
dataMatrix2 <- impute.knn(dataMatrix2)$data
svd1 <- svd(scale(dataMatrixOrdered)); svd2 <- svd(scale(dataMatrix2))
par(mfrow = c(1,2)); plot(svd1$v[,1], pch = 19); plot(svd2$v[,1], pch=19)


# FACE EXAMPLE
setwd("C:/Users/Marcelo/Desktop/Coursera/datasciencecoursera/Exploratory Data Analysis")
load("./data/face.rda")
image(t(faceData)[,nrow(faceData):1])

# Variance explained
svd1 <- svd(scale(faceData))
plot(svd1$d^2 / sum(svd1$d^2), pch = 19, 
     xlab = "Singular vector", ylab = "Variance explained")

# Create approximatation
vd1 <- svd(scale(faceData))
## Note that %*% is matrix multiplication

# Here svd1$d[1] is a constant
approx1 <- svd1$u[, 1] %*% t(svd1$v[, 1]) * svd1$d[1]

# In these examples we need to make the diagonal matrix out of d
approx5 <- svd1$u[, 1:5] %*% diag(svd1$d[1:5]) %*% t(svd1$v[, 1:5])
approx10 <- svd1$u[, 1:10] %*% diag(svd1$d[1:10]) %*% t(svd1$v[, 1:10])

# Plot approximations

par(mfrow = c(1, 4))
image(t(approx1)[, nrow(approx1):1], main = "(a)")
image(t(approx5)[, nrow(approx5):1], main = "(b)")
image(t(approx10)[, nrow(approx10):1], main = "(c)")
image(t(faceData)[, nrow(faceData):1], main = "(d)")  ## Original data

# Scale matters, PC's/SV/s may mix real patterns


## Working with colors

# colorRamp() colorRampPalette

pal <- colorRamp(c("red", "blue"))
pal(0) # = red
# 1 = red, 2 = blue, 3 = green
pal(1) # = blue
pal(0.5)

pal(seq(0,1, len = 10))

par(mfrow = c(1, 1))
plot((pal(seq(0,1, len = 10)))[,1], (pal(seq(0,1, len = 10)))[,3])

pal <- colorRampPalette(c("red", "yellow"))
# character vector that represents the colors
pal(2) # 2 colors 
pal(10)

#RcolorBrewer package
library(RColorBrewer)
# 3 types of palettes
# sequential
# diverging 
# qualitative
# Palette info can be used in conjunction with colorRamp() and colorRampPalette()

cols <- brewer.pal(3, "BuGn")
cols

pal <- colorRampPalette(cols)
image(volcano, col = pal(20))

# the smoothScatter function

x <- rnorm(10000)
y <- rnorm(10000)
smoothScatter(x,y)

# rgb function red, green and blue proportions
# rgb can be used to transparency via alpha parameter
# colorspace package
set.seed(1224)
x <- rnorm(1000)
y <- rnorm(1000)
plot(x, y, pch = 19)
plot(x, y, col = rgb(0,0,0,0.2), pch = 19)

