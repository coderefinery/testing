@test
subroutine test_factorial()
   use factorial_mod
   use funit
   @assertEqual(120, factorial(5), 'factorial(5)')
end subroutine test_factorial
