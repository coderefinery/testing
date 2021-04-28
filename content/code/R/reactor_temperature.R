# reactor <- namespace::makeNamespace("reactor")
# assign("max_temperature", 100, env = reactor)
# namespaceExport(reactor, "max_temperature")

#' Checks whether the temperature is above max_temperature
#' and returns the status.
#'
#' @param temperature_celsius The temperature of the core
#' @return 1 if the temperature is in range, otherwise 0
check_reactor_temperature <- function(temperature_celsius) {
  if (temperature_celsius > reactor::max_temperature)
    status <- 1
  else
    status <- 0
  status
}
