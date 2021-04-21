test_that("Test count word occurrence in string", {
  expect_equal(count_word_occurrence_in_string("AAA BBB", "AAA"), 1)
  expect_equal(count_word_occurrence_in_string("AAA AAA", "AAA"), 2)
  expect_equal(count_word_occurrence_in_string("AAAAA", "AAA"), 0)
})
