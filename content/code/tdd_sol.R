# define the function
fizz_buzz <- function(number){
  if(!number%%1==0 | number < 0) {
     stop("non-integer or negative input not allowed!")
  }
  if(number%%3 == 0 & number%%5 == 0) {
    return('FizzBuzz')
  }
  else if(number%%3 == 0) {
    return('Fizz')
  }
  else if (number%%5 == 0){
    return('Buzz')
  }
  else {
    return(number)
  }
  
}

# apply it to the numbers 1 to 50
for (number in 1:50) {
  print(fizz_buzz(number))
}


library(testthat)

test_that("Test FizzBuzz", {
  expect_equal(fizz_buzz(1), 1)
  expect_equal(fizz_buzz(2), 2)
  expect_equal(fizz_buzz(3), 'Fizz')
  expect_equal(fizz_buzz(4), 4)
  expect_equal(fizz_buzz(5), 'Buzz')
  expect_equal(fizz_buzz(15), 'FizzBuzz')  

  expect_error(fizz_buzz(-1))
  expect_error(fizz_buzz(1.5))
  expect_error(fizz_buzz('rabbit'))    
})
