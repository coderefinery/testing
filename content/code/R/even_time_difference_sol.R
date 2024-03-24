# Changing variables imported from modules (monkey patching) is not possible in R.
# To be able to test this function properly it needs to be made pure:
check_reactor_temperature <- function(max_temperature, temperature_celsius) {
  if (temperature_celsius > max_temperature)
    status <- 1
  else
    status <- 0
  status
}
test_that("Test reactor temperature", {
  expect_equal(check_reactor_temperature(100, 99), 0)
  expect_equal(check_reactor_temperature(100, 100), 0)  # boundary cases easily go wrong
  expect_equal(check_reactor_temperature(100, 101), 1)
})
