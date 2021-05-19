fahrenheit_to_celsius <- function(temp_f)
{
  temp_c <- (temp_f - 32.0) * (5.0/9.0)
  temp_c
}

temp_c <- fahrenheit_to_celsius(temp_f = 100.0)
print(temp_c)
