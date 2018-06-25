## The following functions are used to create a matrix object 
## and calculate its inverse. The inverse of the matrix is cached so 
## that it may be retrieved if the matrix is unchanged 
## and a subsequent call is made to calculate its inverse.


## The function to create and store a matrix object and its inverse. 
makeCacheMatrix <- function(x = matrix()) {
    i <- NULL
    set <- function(y){
        x <<- y
        i <<- NULL
    }
    get <- function()x
    setinverse <- function(inverse)i <<- inverse
    getinverse <- function()i
    list(set = set, get = get, 
         setinverse = setinverse,
         getinverse = getinverse)
}


## The function to calculate the inverse of a matrix object. The
## function checks whether the inverse has already been calculated,
## and returns the cached result if previously calculated. 
cacheSolve <- function(x, ...) {
    i <- x$getinverse()
    if(!is.null(i)) {
        message("getting cached data")
        return(i)
    }
    data <- x$get()
    i <- solve(data, ...)
    x$setinverse(i)
    i
}
