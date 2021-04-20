#' Counts how often a given word appears in a file.
#'
#' @param file_name The name of the file to search in.
#' @param word The word to search for in the file.
#' @return The number of times the word appeared in the file.
count_word_occurrence_in_file <- function(file_name, word) {
  count <- 0
  for (line in readLines(file_name)) {
    words <- strsplit(line, ' ')[[1]]
    count <- count + sum(words == word)
  }
  count
}
