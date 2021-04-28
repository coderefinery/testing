test_that("Test count word occurrence in file", {
  fname <- tempfile()
  write("one two one two three four", fname)
  expect_equal(count_word_occurrence_in_file(fname, "one"), 2)
  expect_equal(count_word_occurrence_in_file(fname, "three"), 1)
  expect_equal(count_word_occurrence_in_file(fname, "six"), 0)
  unlink(fname)
})
