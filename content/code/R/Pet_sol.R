test_that("Test Pet class", {
  p <- Pet(name = "fido")
  expect_equal(p$hunger, 0)
  p <- take_for_a_walk(p)
  expect_equal(p$hunger, 1)

  p$hunger <- -1
  p <- take_for_a_walk(p)
  expect_equal(p$hunger, 0)
})
