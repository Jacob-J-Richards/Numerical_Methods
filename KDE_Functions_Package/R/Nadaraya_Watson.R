
################################################################################

setClass("Estimator3", representation( MPC = "numeric",
                                      H = "numeric", 
                                      x_vector = "numeric",
                                      y_vector = "numeric",
                                      input_argument = "numeric",
                                      data = "matrix"))

################################################################################

setMethod("initialize", "Estimator3", function(.Object, MPC, H, x_vector, y_vector, input_argument, data) {
  
  raw_data <- cbind(x_vector,y_vector)
  
  clean_data <- na.omit(raw_data)
  
  data <- matrix(data = NA, nrow=nrow(clean_data),ncol=ncol(clean_data))

  data <- clean_data
  
  MPC <- numeric(length(input_argument))
  
  .Object <- callNextMethod(.Object, MPC=MPC, H=H, x_vector=x_vector, y_vector=y_vector, input_argument=input_argument, data=data)
  
  validObject(.Object)
  
  return(.Object)
  
})

################################################################################

setGeneric("kernel.smoother", function(object) {standardGeneric("kernel.smoother")})
setMethod("kernel.smoother", signature = "Estimator3", function (object) {
  
  j <- length(object@input_argument)
  n <- nrow(object@data)
  
  Input <- object@input_argument
  Data <- matrix(data = NA, nrow=nrow(object@data),ncol=ncol(object@data))
  Data <- object@data
  h <- object@H
  
  for (k in 1:j) {
    
    Upper_Kappa = numeric()
    
    Lower_Kappa = numeric()
    
    for (i in 1:n) {
      
      Upper_Kappa[i]<- Data[i,2]*(dnorm((Input[k]-Data[i,1])/h,0,1)^2)
      
      Lower_Kappa[i]<- (dnorm((Input[k]-Data[i,1])/h,0,1))^2
      }
    
    object@MPC[k] <- sum(Upper_Kappa)/sum(Lower_Kappa)
    }
  
  return(object)
})

################################################################################

setGeneric("show3", function(object) {standardGeneric("show3")})
setMethod("show3", signature = "Estimator3", function (object){
  cat("output of Estimator", object@MPC, "\n")
  plot(x=object@input_argument,y=object@MPC)
})

################################################################################


#' input your arguments as such:
#' Nadaraya_Watson(user_data_x,user_data_y,user_input_h,user_input_arg)
#' @export
Nadaraya_Watson <- function(user_data_x,user_data_y,user_input_h,user_input_arg) {
object <- new("Estimator3",H = user_input_h, x_vector = user_data_x, y_vector = user_data_y, input_argument = user_input_arg)
object_2 <- kernel.smoother(object)
show3(object_2)
}
