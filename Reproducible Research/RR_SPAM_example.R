## Exploratory data Analysis
## Statistical prediction/modeling
## Interpret results
## Challenge results
## Synthesize/write up results
## Create reproducible code

## SPAM Example

## Question to Answer - Can I automatically detect emails that are SPAM or not?
## Can I use quantitative charc on the emails to classify into SPAM or not?

library(kernlab)
# Data set is already clean
data(spam)
str(spam[,1:5])

# Spliting into train and test data sets - train and tets model

set.seed(3435)
trainIndicator = rbinom(4601, size = 1, prob = 0.5)  # coinflip to select half of the data set
table(trainIndicator)

trainSpam = spam[trainIndicator == 1, ]
testSpam = spam[trainIndicator == 0, ]

## Exploratory data analysis
# - summ data
# - checking missing data
# - exploratory plots
# - exploratory analysis

names(trainSpam)
head(trainSpam)

table(trainSpam$type)
# 1381 nonspam and 906 classified as spam
plot(log10(trainSpam$capitalAve + 1) ~ trainSpam$type) # capitalAve = averaga number of capital letters
# add 1 to not take log of zeros - spam emails have a much higher rate of capital letters

# Relationship between predictors
plot(log10(trainSpam[,1:4]+1))
# some are correlated and some no

# Cluster analysis
hCluster = hclust(dist(t(trainSpam[,1:57])))
plot(hCluster)
hClusterUpdated = hclust(dist(t(log10(trainSpam[,1:55]+1))))
plot(hClusterUpdated)

# cluster with capital average, you, your, will 

## Statistical modeling - logistic regression to see if we can predict wether an email is SPAM or not
# using a single variable

trainSpam$numType = as.numeric(trainSpam$type) - 1 
costFunction = function(x, y) sum(x != (y > 0.5))
cvError = rep(NA, 55)
library(boot)

for (i in 1:55){
        lmFormula = reformulate(names(trainSpam)[i], response = "numType")
        glmfit = glm(lmFormula, family = "binomial", data = trainSpam)
        cvError[i] = cv.glm(trainSpam, glmfit, costFunction, 2)$delta[2]
}
names(trainSpam)[which.min(cvError)]

# Predictor that has the minimum cvError is "CharDollar" = number of dollar signs in the email

# Using the best model from the group
predictionModel = glm(numType ~ charDollar, family = "binomial", data = trainSpam)

## Get the predictions on the test data
predictionTest = predict(predictionModel, testSpam)
predictedSpam = rep("nonspam", dim(testSpam)[1])

# Classify as "spam" for those with prob > 0.5
predictedSpam[predictionModel$fitted > 0.5 ] = "spam"


# Classification table

table(predictedSpam, testSpam$type)

## Error rate
(61+458)/(1346 + 61 + 458 + 449)
# About 22%

## Our Results
# - the fraction of characters that are dollar signs can be used to predict if an email is Spam
# - Anything with more than 6.6% dollar signs is classified as Spam
# - more dollar signs always means more Spam under our prediction
# - our test set error rate was 22.4 %

## Challenge results
# - Question, Data Source, Processing, Analysis, Conclusions
# - Challenge measures of uncertainty
# - why is it an appropriate model
# - think potential alternative analyses

## Synthesize/ write-up reuslts
# - Lead with the question
# - Summarize the analyses into the story
# - if it is needed for the story - INCLUDE
# - if it is needed to address a challenge - INCLUDE
# - order analyses according to the story
# - include "pretty" figures

# Can I use quantitative characterstics of the emails to classify them as SPAM/HAM?
# Collected data from UCI -> created training/test sets
# Explored relationships
# Choose logistic model on training set by cross validation
# Applied to the test, 78% test set accuracy
# Number of dollar signs seems reasonable, e.g. "Make money with $$$$$
# 78 % isn't that great
# I could use more variables
# Why logistic regression

## Create reproducible code
