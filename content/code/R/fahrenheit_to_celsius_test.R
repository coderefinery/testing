# Converts temperature in Fahrenheit to Celsius.
fahrenheit_to_celsius <- function(temp_f)
{
  temp_c <- (temp_f - 32.0) * (5.0/9.0)
  temp_c
}

# This is the test function: `assertive::is_true` raises an error if something
# is wrong.
test_fahrenheit_to_celsius <- function()
{
  temp_c <- fahrenheit_to_celsius(temp_f = 100.0)
  expected_result <- 37.777777
  assertive::is_true(abs(temp_c - expected_result) < 1.0e-6)
}
