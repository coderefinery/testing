f_to_c_offset <- 32.0
f_to_c_factor <- 0.555555555
temp_c <- 0.0

fahrenheit_to_celsius_bad <- function(temp_f)
{
  temp_c <<- (temp_f - f_to_c_offset) * f_to_c_factor
}

fahrenheit_to_celsius_bad(temp_f = 100.0)
print(temp_c)
