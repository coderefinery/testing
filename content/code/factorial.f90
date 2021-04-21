module factorial_mod
contains
   ! computes the factorial of n
   integer function factorial(n)
      implicit none
      integer, intent(in) :: n
      integer r
      integer i
      if(n < 0) then
         write(*,*) 'Received negative input'
         stop
      end if
      r = 1
      do i = 1,n
         r = r*i
      end do
      factorial=r
   end function factorial
end module factorial_mod
