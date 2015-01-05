## cachematrix.R
## makeCacheMatrix(x)
##    Takes a square, invertible matrix as input
##    Constructs an object with 4 methods
##    set(x)         - changes the stored matrix to a new stored matrix
##    get()          - returns the stored matrix
##    setinverse(i)  - changes the stored inverse of the stored matrix
##    getinverse()   - returns the stored inverse of the stored matrix
##
## cacheSolve(x)
##    Takes a cacheMatrix as input
##    returns the inverse of the cacheMatrix
##    throws errors when the type of its argument does not have the same structure
##        as a cacheMatrix
##    throws errors when the stored matrix is not invertible for some reason
##
## written by Linda Kukolich, December 2014, for a homework assignment for
## R Programming, a Coursera Course taught by Roger Peng, Jeff Leek, and Brian Caffo 
## all of Johns Hopkins Bloomberg School of Public Health
## The code here is based on an example provided as part of the assigment

# Write a short comment describing this function
# Cache a matrix, to speed up lengthy calculations
# Usage:
# cx <- makeCacheMatrix(x)
# cx$set(newMatrix)
# storedMatrix <- cx$get()
# cx$setinverse(inverseOfx)
# storedInverse <- cx$getinverse()
#
# Related Functions:
# cacheSolve(cx)
#
# There is no particular protection keeping users from storing any old junk
# in either x or as x-inverse. Maybe we learn to write tighter classes that
# allow more paranoia in the future?
makeCacheMatrix <- function(x = matrix()) {
  ## variables internal to this object (environment)
  ## x - the stored matrix
  ## inverse - the stored inverse of the stored matrix
  inverse <- NULL
  ## Copy a new matrix into storage (the local environment), and clear the cached inverse, which is now invalid
  set <- function(y) {
    x <<- y
    inverse <<- NULL
  }
  ## return the stored matrix
  get <- function() x
  ## Copy the inverse, having calculated it somewhere
  setinverse <- function( i ) inverse <<- i
  ## return the stored inverse, possibly NULL
  getinverse <- function() inverse
  ## return the object we have constructed, actually a list of methods
  list(set = set, 
       get = get, 
       setinverse = setinverse, 
       getinverse = getinverse)
}

## Check if a cached matrix has a cached inverse
## if so, return that cached inverse
## if not, generate the inverse using solve(), cache it, and return it
#
# There is nothing here that checks the type of its argument, that had
# better be a cacheMatrix or this doesn't work well. There are errors that
# get thrown when the type is wrong, but they are not helpful ones...
cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  
  ## First check if the inverse has been cached
  inv <- x$getinverse()
  if (! is.null(inv)) {
    message("getting cached inverse")
    return(inv)
  }
  ## if we get here, the inverse must be calculated, stored, and returned
  data <- x$get()
  inv <- solve(data)
  x$setinverse(inv)
  inv
}
## Working notes
## The assignment, so far as I can tell
## (Before reading anything or watching the lectures, because I'm lazy...)
## cache a matrix, keeping track of
##   its dimensions
##   some sort of checksum so I can tell if its contents have changed
##   its inverse, if that has been calculated 
## invert a matrix using solve
##   check that is is square
##   unless the cached matrix is unchanged and someone has already done this
##   in that case, read the cached value
##   whine if it was unsolvable, though they promise it will be ok
##
## Having actually read the notes they gave us, I more or less copied
## their pattern.
## Differences from what I had imagined:
##   Instead of magically detecting that the data has changed, you can only change it
##   with the set function. The set function conveniently NULLs out the inverse, so we
##   automatically have to recalculate anytime we call set to change the data. Smooth.
##   
##   The other cool thing here is the use of <<- to do a copy, which may have been
##   covered in the Lexical scoping lecture, but I didn't make note of it.
##   It still feels like poor man's encapsulation rather than making modern classes.
##   Since this is clearly not a "modern" language, this is just how it is.

## Testing? 
## makeCacheMatrix with no argument
##   Gives me the description of all the parts
## makeCacheMatrix with an argument
##   No complaints
##   printing the result plain is just like makeCacheMatrix() with no args
##   str(cx) gives some other cool stuff that I don't understand yet
## x$getinverse with no stored inverse
##   NULL
## x$getinverse after a call to cacheSolve, to see it is the same and the message is right
##   The expected matrix
## x$set to clear the matrix
##    Changes matrix, clears inverse
## x$get to check it is the new one
##    Yep
## x$getinverse to see that we have to calculate the new inverse and it is right
##    
## x$getinverse again to see that the message is right
## Repeat the x$getinverse tests using cacheSolve
##
## cacheSolve with an empty matrix
##   Gives NA as the inverse
## cacheSolve with a un-invertable matrix
##    Throws an error, generated by solve, when it fails
## cacheSolve with a non-square matrix
##    Solve throws an error when it fails
##    Multiple times for multiple calls

## call cacheSolve with an atomic
## Error: $ operator is invalid for atomic vectors
## call cacheSolve with a list, but not a cacheMatrix
## Error attempt to apply non-function
## call cacheSolve with a list, with the same methods as cacheMatrix has, but different ones
## fx <- makeFakeCache(c(1,3,4))
## cacheSolve(fx)
## a (3 x 1) must be square
# so, it is "easy" to use the wrong types together. How do I do stronger typing?

makeFakeCache <- function(x = vector()) {
  inverse <- NULL
  set <- function(y) {
    x <<- 2*y
    inverse <<- NULL
  }
  ## return the stored matrix
  get <- function() 3*x
  setinverse <- function( i ) inverse <<- 2*i
  getinverse <- function() inverse
  ## return the object we have constructed, actually a list of methods
  list(set = set, 
       get = get, 
       setinverse = setinverse, 
       getinverse = getinverse)
}
