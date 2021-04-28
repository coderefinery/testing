test_that("Test factorial", {
  expect_equal(factorial(0), 1)
  expect_equal(factorial(1), 1)
  expect_equal(factorial(2), 2)
  expect_equal(factorial(3), 6)
  # also try negatives (check that it raises an error), non-integers, etc.

  # Raise an error if factorial does *not* raise an error:
  expect_error(factorial(-1))
})
