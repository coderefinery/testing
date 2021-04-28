#' Counts how often a given word appears in text
#'
#' @param text The text to search in.
#' @param word The word to search for.
#' @return The number of times the word occurs in the text.
count_word_occurrence_in_string <- function(text, word) {
  words <- strsplit(text, ' ')[[1]]
  sum(words == word)
}
