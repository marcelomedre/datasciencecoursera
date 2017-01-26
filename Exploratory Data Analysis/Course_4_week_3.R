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
