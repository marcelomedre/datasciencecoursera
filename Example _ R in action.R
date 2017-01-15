## EXAMPLE

options (digits = 2) #limits the number of digits printed after the decimal place
## building a table

Student <- c("John Davis", "Angela Williams", "Bullwinkle Moose",
               "David Jones", "Janice Markhammer", "Cheryl Cushing",
               "Reuven Ytzrhak", "Greg Knox", "Joel England",
               "Mary Rayburn")
Math <- c(502, 600, 412, 358, 495, 512, 410, 625, 573, 522)
Science <- c(95, 99, 80, 82, 75, 85, 80, 95, 89, 86)
English <- c(25, 22, 18, 15, 20, 28, 15, 30, 27, 18)
roster <- data.frame(Student, Math, Science, English,
                       stringsAsFactors=FALSE)
roster

## math Science and english were graded on different scales, it is nice to standardize the variables
z <- scale(roster[,2:4]) #scale is generic function whose default method centers and/or scales the columns of a numeric matrix
z # scaled in respect to center

#getting the performance for each student by calculatind the row means and adding into the roaster

score <- apply(z, 1, mean)
roster <- cbind(roster, score)
roster

#Calculating the percentile quantili rank of each student's performance score
y <- quantile (roster$score, c(.8, .6, .4, .2))
y

## Assign the grade based on the percentile ranks into a categorical grade variable

roster$grade[score >= y[1]] <- "A"
roster$grade[score < y[1] & score >= y[2]] <- "B"
roster$grade[score < y[2] & score >= y[3]] <- "C"
roster$grade[score < y[3] & score >= y[4]] <- "D"
roster$grade[score < y[4]] <- "F"
roster

## breaking students name into first and last using strsplit()
name <- strsplit((roster$Student), " ")
name

#use sapply to put each element into a vector

Firstname <- sapply(name, "[", 1)
Lastname <- sapply(name, "[", 2)
roster <- cbind(Firstname, Lastname, roster[,-1])
roster

## Sort the data set by first and last names using order()

roster[order(Lastname, Firstname),]
