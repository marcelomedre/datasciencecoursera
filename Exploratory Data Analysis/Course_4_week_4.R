# EDA Case Study - Understanding Human Activity with Smart Phones
# What are you looking for
# what might be the key priorities and how approach it
# rough ideia about the information in your dataset
# what questions you would be able to answer

# Dataset Samsung Galaxy S3 - prediction people movements
# based on aceletometer and gyroscope

# https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
getwd()
setwd("C:/Users/Marcelo/Desktop/Coursera")
load("./data/samsungData.rda")
#training dataset

names(samsungData)[1:12]
# for each row what the person was doing
table(samsungData$activity)

# Separate the activities based on the data from acc and gyroscope
# quick thing if take a look at the average acceleration for first subject
par(mfrow = c(1,2), mar = c(5, 4, 1, 1))
samsungData <- transform(samsungData, activity = factor(activity))
sub1 <- subset(samsungData, subject == 1)
plot(sub1[,1], col = sub1$activity, ylab = names(sub1)[1]) # mean body acc in the X direction
plot(sub1[,2], col = sub1$activity, ylab = names(sub1)[2]) # mean body acc in the Y direction
legend("bottomright", legend = unique(sub1$activity), col = unique(sub1$activity),
       pch = 1)

source("myplclust.R")
distanceMatrix <- dist(sub1[,1:3])
hcclustering <- hclust(distanceMatrix) #euclidean distances
par(mfrow = c(1,1), mar = c(5, 4, 1, 1))
myplclust(hcclustering, lab.col = unclass(sub1$activity))

# maximum acceleration
par(mfrow = c(1,2))
#maximum body Acc in the x direction
plot(sub1[,10], pch = 9, col = sub1$activity, ylab = names(sub1)[10])
#maximum body Acc in the Y direction
plot(sub1[,11], pch = 9, col = sub1$activity, ylab = names(sub1)[11])

# Clustering based on maximum acceleration
source("myplclust.R")
distanceMatrix <- dist(sub1[,10:12])
hclustering <- hclust(distanceMatrix)
par(mfrow = c(1,1), mar = c(5, 4, 1, 1))
myplclust(hclustering, lab.col = unclass(sub1$activity))
# 2 clear clusters on the left hand side - walking activities and right hand side non-moving activities
# beyond this within those clusters it is hard to separate based just on maximum acceleration

# Singular Value Decomposition 

svd1 = svd(scale(sub1[,-c(562,563)])) #removing activity and identifier
par(mfrow = c(1, 2))
plot(svd1$u[,1], col = sub1$activity, pch = 19)
plot(svd1$u[,2], col = sub1$activity, pch = 19)

# first singular vector seems to separate the moving from
# the non-moving.
# second singular vector seems to separate the magenta color from other clusters

plot(svd1$v[,2], pch = 19)

# analysing the maximum contributer
maxContrib <- which.max(svd1$v[,2])
distanceMatrix <- dist(sub1[,c(10:12, maxContrib)])
hclustering <- hclust(distanceMatrix)
par(mfrow = c(1, 1))
myplclust(hclustering, lab.col = unclass(sub1$activity))

names(samsungData)[maxContrib]

# K-means clustering
kClust <- kmeans(sub1[,-c(562,563)], centers = 6)
table(kClust$cluster, sub1$activity)

kClust <- kmeans(sub1[,-c(562,563)], centers = 6, nstart = 1)
table(kClust$cluster, sub1$activity)

kClust <- kmeans(sub1[,-c(562,563)], centers = 6, nstart = 100)
table(kClust$cluster, sub1$activity)

# each of the clusters has a mean value
# Cluster 1 - laying
plot(kClust$center[1,1:10], pch = 19, ylab = "Cluster Center", xlab = "")
# Cluster 2 - walking
plot(kClust$center[4,1:10], pch = 19, ylab = "Cluster Center", xlab = "")
