#segunda parte - Write a function that reads a directory full of files and reports
#the number of completely observed cases in each data file
#output - id nobs

complete <- function(directory, id = 1:332){ #função inicial
        files <- list.files(directory, pattern = ".csv", full.names = TRUE)
        nobs <- numeric() # number of observations
        
        for(i in id){
                data <- read.csv(files[i]) #lê os arquivos
                nobs <- c(nobs, sum(complete.cases(data))) #conta os casos completos, poderia ter sido feito em uma única linha nobs <- c(nobs, sum(complete.cases(read.csv(files[i]))))
        
        }
        result <- data.frame(id, nobs)#cria uma data frame armazenando o id e o # de casos completos
        result #imprime o resultado
}