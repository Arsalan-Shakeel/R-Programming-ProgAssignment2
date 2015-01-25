makeCacheMatrix <- function(x = matrix()) {
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#
# This function uses the "<<-" operator to assign 
# values to objects in an environment that is different
# from current environment. It returns a list of four
# different functions as defined below:
# (1) set: function stores the value of matrix 
#     supplied as an argument of makeCacheMatrix into
#     a different environmnet using <<- operator.
# (2) get: function returns matrix supplied as an 
#     argument of makeCacheMatrix from other envionment. 
#     If no argument was supplied, then it returns a 1x1 
#     matrix containing 'NA' value.
# (3) setsolve: function stores the value of matrix
#     supplied as its argument into a different 
#     environment using <<- operator.
# (4) getsolve: function returns the inverse of matrix
#     from other environment if available, otherwise 
#     returns NULL.
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#
  inverse <- NULL
  set <- function(y) {
    x <<- y
    inverse <<- NULL
  }
  get <- function() x
  setsolve <- function(solve) inverse <<- solve
  getsolve <- function() inverse
  list(set = set, get = get,
       setsolve = setsolve,
       getsolve = getsolve)
}


cacheSolve <- function(x, ...) {
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#
# This function is used along with makeCacheMatrix 
# function. It accepts makeCacheMatrix function as its
# argument and returns the inverse of matrix provided
# as an argument of makeCacheMatrix as show below:
#cacheSolve(makeCacheMatrix(matrix(c(4,2,7,6),
#                           nrow=2, ncol=2)))
#      [,1] [,2]
#  [1,]  0.6 -0.7
#  [2,] -0.2  0.4
# It first calls the getsolve function of makeCacheMatrix.
# If a NULL value is returned, then it means that value
# of inverse matrix is not stored in the object that is
# defined in other environment. This function then 
# retreives the matrix supplied in makeCacheMatrix call
# and assigns it to a local object 'data'. It then calls 
# solve function which returns the inverse of the matrix.
# The inverse matrix value is used as an argument in
# makeCacheMatrix$setsolve function which assigns it to
# an object in the other environment. Hence, when next
# time this function is called with same argument, it 
# returns the stored value of inverse from cache instead
# of re-calculting it.
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#
  m <- x$getsolve()
  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }
  data <- x$get()
  m <- solve(data, ...)
  x$setsolve(m)
  m
}


#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#
#USAGE DOCUMENTATION:
# These two functions are designed to be used together.
# The makeCacheMatrix function creates a "matrix" object
# and cashes its inverse. The cacheSolve function computes
# the inverse of matrix and stores it in an object defined
# in another environment in cache. When next time cacheSolve
# function is called with same input, it retreives the 
# inverse from cache.
#
# Following is output from R console showing execution of these: 
#> my_matrix <- matrix(c(1,2,1,2,5,0,3,3,8), nrow=3, ncol=3)
#> my_matrix
#      [,1] [,2] [,3]
# [1,]    1    2    3
# [2,]    2    5    3
# [3,]    1    0    8
#> my_mat_list <- makeCacheMatrix(my_matrix) 
#> my_mat_list$get()
#       [,1] [,2] [,3]
# [1,]    1    2    3
# [2,]    2    5    3
# [3,]    1    0    8
#> cacheSolve(my_mat_list)
#      [,1] [,2] [,3]
# [1,]  -40   16    9
# [2,]   13   -5   -3
# [3,]    5   -2   -1
#> cacheSolve(my_mat_list)
# getting cached data
#      [,1] [,2] [,3]
# [1,]  -40   16    9
# [2,]   13   -5   -3
# [3,]    5   -2   -1
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#