################################################################################
  
validity.estimator <- function(object) {
  # Check if h is numeric and all values are greater than zero
  if (!is.numeric(object@h) || length(object@h) == 0 || any(object@h <= 0)) {
    return("h must be numeric and greater than zero") 
  }
  
  # Check if x and y have the same length
  if (length(object@x) != length(object@y)) {
    return("x and y must have the same length")
  }
  
  # Check if x and y have length greater than 1
  if (length(object@x) <= 1 || length(object@y) <= 1) {
    return("x and y must each have a length greater than 1")
  }
  return(TRUE) 
}

setClass("estimator", representation( h = "numeric", x = "numeric", y = "numeric", MPC = "numeric",
                                      input_argument = "numeric"), validity = validity.estimator)

################################################################################

setGeneric("PC.smoother", function(object) {standardGeneric("PC.smoother")})

setMethod("PC.smoother", signature= "estimator", function(object){
  
  matrix_data <- cbind(object@x, object@y)
  
  sorted_matrix <- matrix_data[order(matrix_data[,1]),]
  
  j <- length(object@input_argument)
  
  n <- length(object@x)
  
  H <- object@h
  
  sigma <- numeric(length(object@x))
  
  object@MPC <- numeric(j)
  
  for (k in 1:j) {
    
      for (i in 2:n) { 
        
        change_in_x <- sorted_matrix[i, 1] - sorted_matrix[i - 1, 1]
        
        pdf_squared <- (dnorm((object@input_argument[k] - sorted_matrix[i, 1]) / H,0,1))^2
        
        sigma[i] <- (change_in_x*pdf_squared*sorted_matrix[i,2])/H
        }
    
    object@MPC[k] <- sum(sigma)
    }
  
  return(object)
})

################################################################################

setGeneric("show", function(object) { standardGeneric("show")})
setMethod("show", signature = "estimator", function(object) {
  cat("input argument (first 5):", head(object@input_argument, 5),"\n")
  cat("MPC values (first 5):", head(object@MPC, 5), "\n")
  
  plot(x=object@input_argument, y=object@MPC)
  return(object)
})

################################################################################
#' input your arguments as such:
#' Priestley_Chao(user_data_x,user_data_y,user_input_h,user_input_arg)
#' @export
Priestley_Chao <- function(user_data_x,user_data_y,user_input_h,user_input_arg) {
  base_object <- new("estimator", h = user_input_h, x = user_data_x, y = user_data_y, 
                     MPC=numeric(), input_argument = user_input_arg)
  
  object <- PC.smoother(base_object)
  
  show(object)
}

################################################################################
