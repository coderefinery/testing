program temperature_conversion

implicit none
call test_fahrenheit_to_celsius()

contains

function fahrenheit_to_celsius(temp_f) result(temp_c)
   implicit none
   real temp_f
   real temp_c
   temp_c = (temp_f - 32.0) * (5.0/9.0)
end function fahrenheit_to_celsius

subroutine test_fahrenheit_to_celsius()
   implicit none
   real temp_c
   real expected_result
   temp_c = fahrenheit_to_celsius(100.0)
   expected_result = 37.777777
   if( abs(temp_c - expected_result) > 1.0e-6) then
      write(*,*) 'Error'
   else
      write(*,*) 'Pass'
   end if
end subroutine test_fahrenheit_to_celsius

end program temperature_conversion
