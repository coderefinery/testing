if (!require(testthat)) install.packages(testthat)

test_that("dice is working", {
  set.seed(42)
  expect_equal(roll_dice(5), c(6, 6, 2, 5, 4))
  expect_equal(roll_dice(5), c(4, 5, 1, 4, 5))
  expect_equal(roll_dice(5), c(3, 5, 6, 2, 3))
})


test_that("yahtzee is working", {
  n_games <- 1e6 #could be very slow, when in doubt change to 1e4

  n_winning <- sum(replicate(n_games, yahtzee()) == 5)
  res <- (n_winning / n_games)
  expected <- 0.046
  expect_lt(abs(res - expected), 0.003)
})
