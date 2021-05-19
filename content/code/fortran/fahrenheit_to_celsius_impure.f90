real f_to_c_offset = 32.0
real f_to_c_factor = 0.555555555

function fahrenheit_to_celsius_bad(temp_f) result(temp_c)
   implicit none
   real temp_f
   real temp_c
   temp_c = (temp_f - f_to_c_offset) * f_to_c_factor
end function fahrenheit_to_celsius_bad

temp_c = fahrenheit_to_celsius_bad(100.0)
write(*,*) temp_c
