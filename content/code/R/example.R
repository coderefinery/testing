if (!require(testthat)) install.packages(testthat)
add <- function(a, b) {
    return(a + b)
}

test_that("Adding integers works", {
    res <- add(2, 3)

    # Test that the result has the correct value
    expect_identical(res, 5)

    # Test that the result is numeric
    expect_true(is.numeric(res))
})

