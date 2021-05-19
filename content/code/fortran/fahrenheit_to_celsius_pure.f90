function fahrenheit_to_celsius(temp_f) result(temp_c)
implicit none
real temp_f
real temp_c
temp_c = (temp_f - 32.0) * (5.0/9.0)
end function fahrenheit_to_celsius

temp_c = fahrenheit_to_celsius(100.0)
write(*,*) temp_c
