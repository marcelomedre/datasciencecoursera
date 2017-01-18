unzip("rprog_data_specdata.zip", exdir = "Q2_data")
list.files("specdata")
file1 <- read.csv("specdata/001.csv")
head(file1)

sulfate <- file1[,"sulfate"] #le a coluna com dados do sulfato
msulfate <- mean(sulfate, na.rm = TRUE)#faz a media

#ler dados de arquivos especificados
pollutantmean <- function(directory, pollutant, id = 1:332){
        files <- list.files(directory, pattern = ".csv", full.names=TRUE) #lê todos os arquivos no diretorio a ser especificado
        data_files <- data.frame() #data frame vazio para armazenar dados de todos os arquivos
        for (i in id){
                data_files <- rbind(data_files, read.csv(files[i]))
        }
        mean_data <- mean(data_files[,pollutant], na.rm = TRUE)
        round(mean_data, digits = 3)
}
