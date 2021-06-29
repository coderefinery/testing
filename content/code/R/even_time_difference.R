#' Check time to now even
#'
#' Checks whether time difference between now and given time in seconds is even
#'
#' @param seconds input time in whole seconds
#'
#' @return returns true or false
check_time_to_now_even <- function(seconds) {
  if(seconds < 0) stop('received negative input')
  now <- as.integer(format(Sys.time(), '%s'))
  return((seconds - now) %% 2 == 0)
}
