! The pFUnit test case
@test
subroutine test_fizzbuzz()
   use fizzbuzz_mod
   use funit
   @assertEqual('Fizz', fizzbuzz(12), 'fizzbuzz(12)')
   @assertEqual('Buzz', fizzbuzz(25), 'fizzbuzz(25)')
   @assertEqual('FizzBuzz', fizzbuzz(60), 'fizzbuzz(60)')
end subroutine test_fizzbuzz

! The fizzbuzz function
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
