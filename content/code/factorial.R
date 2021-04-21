#' Computes the factorial of n
#'
#' @param n The number to compute the factorial of.
#' @return The factorial of n
factorial <- function(n) {
  if (n < 0)
    stop('received negative input')
  if (n == 0)
    return(1)

  result <- 1
  for (i in 1:n)
    result <- result * i
  result
}
