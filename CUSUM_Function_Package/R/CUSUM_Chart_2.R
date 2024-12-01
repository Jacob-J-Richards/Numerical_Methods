#' Load a Matrix
#'
#' This function loads a file as a matrix. It assumes that the first column
#' contains the rownames and the subsequent columns are the sample identifiers.
#' Any rows with duplicated row names will be dropped with the first one being
#' kepted.
#'
#' @param infile Path to the input file
#' @return A matrix of the infile
setClass("CUSUM", representation(upper_signal = "numeric",
                                 lower_signal = "numeric",
                                 CL = "numeric",
                                 x = "numeric",
                                 Reject_H0 = "logical",
                                 time = "numeric",
                                 input = "numeric",
                                 stopped = "logical"))

################################################################################

setGeneric("signals", function(object) { standardGeneric("signals")  })
setMethod("signals", signature = "CUSUM", function(object) {
  
  object@upper_signal[object@time] <- max(0, object@upper_signal[object@time - 1] + object@x[object@time] - 0.5)
  
  object@lower_signal[object@time] <- min(0, object@lower_signal[object@time - 1] + object@x[object@time] + 0.5)
  
  return(object)
})

################################################################################


setGeneric("update", function(object) { standardGeneric("update")  })
setMethod("update", signature = "CUSUM", function(object) {
  
  object@time <- object@time + 1
  
  if (length(object@upper_signal) > 0) {
    object@stopped <- (tail(object@upper_signal, 1) > object@CL) || ((tail(object@lower_signal, 1)) < -object@CL)
    object@Reject_H0 <- TRUE
  }
  
  if (length(object@lower_signal) > 0 ) {
    object@stopped <- (tail(object@upper_signal, 1) > object@CL) || ((tail(object@lower_signal, 1)) < -object@CL)
    object@Reject_H0 <- TRUE
  }
  
  if (object@time > length(object@input)) {
    object@stopped <- TRUE
    object@Reject_H0 <- FALSE
  }
  
  return(object)
})

################################################################################


setGeneric("creator", function(object) {standardGeneric("creator")})
setMethod("creator", signature = "CUSUM", function(object) {
  
  object@upper_signal = 0
  object@lower_signal = 0
  object@stopped = FALSE
  object@time = 1
  
  while (!object@stopped) {
    
    object@x[object@time] <- object@input[object@time]
    
    object <- signals(object)
    
    object <- update(object)
    
  }
  
  return(object)
})

################################################################################

setGeneric("show", function(object) {standardGeneric("show")})
setMethod("show", signature = "CUSUM", function(object) {
  
  plot(seq_along(object@upper_signal), object@upper_signal, type = "l", col = "blue",
       ylab = "Signal", xlab = "Time", main = "Upper and Lower Signals Over Time",
       ylim = range(c(object@upper_signal, object@lower_signal, object@CL, -object@CL)))
  
  lines(seq_along(object@lower_signal), object@lower_signal, col = "red")
  abline(h = object@CL, col = "green", lty = 2)
  abline(h = -object@CL, col = "orange", lty = 2)
  
  cat("Control limit reached at time =", tail(object@time, 1), "\n")
  cat("Absolute value control limit:", object@CL, "\n")
  cat("Reject the null hypothesis:", object@Reject_H0, "\n")
  cat("length of input", length(object@input), "\n")
  cat("Last five upper limits:", tail(object@upper_signal, 5), "\n")
  cat("Last five lower limits:", tail(object@lower_signal, 5), "\n")
})

################################################################################

#' @export
CUSUM_Chart_2 <- function(user_data, user_k, user_L0, user_mu0, user_hs, user_sided, user_r) {
  
  data_2 <- as.vector(user_data)
  data_3 <- unlist(data_2)
  data_4 <- unname(data_3)
  
  object <- new("CUSUM", 
                upper_signal = numeric(),
                lower_signal = numeric(),
                CL = spc::xcusum.crit(k = user_k, L0 = user_L0, mu0 = user_mu0, hs = user_hs, 
                                      sided = user_sided, r = user_r), 
                x = numeric(), 
                time = numeric(), 
                input = data_4, 
                Reject_H0 = FALSE, 
                stopped = FALSE)
  
  object <- creator(object) # Initialize and process
  show(object)              # Display the results
}

