## Matrix inversion is usually a costly computation and there may be some 
## benefit to caching the inverse of a matrix rather than compute it repeatedly
## The pair of functions below are used to create a special object that stores
## a matrix and its inverse in the cache

## This object stores the matrix x and is able to cache its inverse

makeCacheMatrix <- function(x = matrix()) {
        inv <- NULL
        set <- function(y){
                x <<- y
                inv <<- NULL
        }
        get <- function() x
        setmatrix <- function(inverse) inv  <<- inverse
        getmatrix <- function() inv
        list(set = set,
             get = get,
             setmatrix = setmatrix,
             getmatrix = getmatrix)

}

## This second function calculates the inverse of the matrix created by using the 
## makeCacheMatrix function. If the inverse has been already calculate and no alterations were made
## in the matrix it get the inverse from the cache, otherwise it calculates it and assigns to 
## the variable inv

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
        inv <- x$getmatrix()
        if (!is.null(inv)){
                message ("Getting cached matrix!")
                return(inv)
        }
        mat <- x$get()
        inv <- solve(mat, ...)
        x$setmatrix(inv)
        inv
}

## Below I have tested the functions above

set.seed(200)
r=rnorm(4)
mat <- matrix(r, nrow=2, ncol=2)
my_matrix <- makeCacheMatrix(mat)
my_matrix$get()
my_matrix$getmatrix()
cacheSolve(my_matrix)
cacheSolve(my_matrix)
my_matrix$getmatrix()

