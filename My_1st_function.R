#my first function
add2 <- function(x,y){
  x + y
}

#above 10
above10 <- function(x){
  use <- x > 10 #logical vector
  x[use] #subsectis the x vector, holding the values > 10
}

#allowing the user to specify the #
above <- function(x,n =10){ #pode especificar n default se user nao especificar a funcao usa 10 como default
  use <- x > n
  x[use]
}

#calcular a media dos valores de cada coluna de uma matrix
columnmean <- function(y, removeNA = TRUE){ #y = dataframe ou matriz
  nc <- ncol(y)#conta n de colunas
  nc
  means <- numeric(nc)#vetor que armazenara as medias (começa com zeros)
  for(i in 1:nc){
    means[i] < mean(y[,i], na.rm = removeNA)
  }
  means #return the means vector
}
columnmean <- function(y, removeNA = TRUE){
  nc <- ncol(y)
  means <- numeric(nc)
  for (i in 1:nc){
    means[i] <- mean(y[,i], na.rm = removeNA)
  }
  means
}

#optimization example  - Write a constructor function
make.NegLogLik <- function(data, fixed = c(FALSE, FALSE)){#primeiro FALSE = mu, segundo sigma
  params <- fixed
  function (p){
    params[!fixed] <-p
    mu <- params[1]
    sigma <- params[2]
    a <- -0.5*length(data)*log(2*pi*sigma^2)
    b <- -0.5*sum((data-mu)^2)/(sigma^2)
    -(a+b)
  }
}

cube <- function (x,n){
        x^3
}

x <- 1:10
if(x > 5) {
        x <- 0
}

h <- function(x, y = NULL, d = 3L) {
        z <- cbind(x, d)
        if(!is.null(y))
                z <- z + y
        else
                z <- z + f
        g <- x + y / z
        if(d == 3L)
                return(g)
        g <- g + 10
        g
}