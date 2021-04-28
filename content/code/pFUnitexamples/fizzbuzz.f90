module fizzbuzz_mod
contains
   ! Evaluates the fizzbuzz of n
   character(8) function fizzbuzz(n)
      implicit none
      integer, intent(in) :: n
      character(8) str1
      if( mod(n,15)==0 ) then
         str1='FizzBuzz'
      else if( mod(n,3)==0 ) then
         str1='Fizz'
         str1=str1
      else if( mod(n,5)==0 ) then
         str1='Buzz'
      else if( n<0 ) then
         str1='Err n<0'
      else
         str1=char(n)
      end if
      fizzbuzz=str1
   end function fizzbuzz
end module fizzbuzz_mod
