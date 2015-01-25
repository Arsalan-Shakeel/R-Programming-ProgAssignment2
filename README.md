#  R-Programming-ProgAssignment2
Repository for Programming Assignment 2

USAGE DOCUMENTATION:
  These two functions are designed to be used together.
  The makeCacheMatrix function creates a "matrix" object
  and cashes its inverse. The cacheSolve function computes
  the inverse of matrix and stores it in an object defined
  in another environment in cache. When next time cacheSolve
  function is called with same input, it retreives the 
  inverse from cache.

Following is output from R console showing execution of these: 
> my_matrix <- matrix(c(1,2,1,2,5,0,3,3,8), nrow=3, ncol=3)
> my_matrix
       [,1] [,2] [,3]
  [1,]    1    2    3
  [2,]    2    5    3
  [3,]    1    0    8
 > my_mat_list <- makeCacheMatrix(my_matrix) 
 > my_mat_list$get()
        [,1] [,2] [,3]
  [1,]    1    2    3
  [2,]    2    5    3
  [3,]    1    0    8
 > cacheSolve(my_mat_list)
       [,1] [,2] [,3]
  [1,]  -40   16    9
  [2,]   13   -5   -3
  [3,]    5   -2   -1
 > cacheSolve(my_mat_list)
  getting cached data
       [,1] [,2] [,3]
  [1,]  -40   16    9
  [2,]   13   -5   -3
  [3,]    5   -2   -1
