#include <string>

/* Counts how often word appears in text.
 * Example: if text is "one two one two three four"
 *          and word is "one", then this function returns 2
 */
int count_word_occurrence_in_string(const std::string& text, const std::string& word) {
  auto word_count = 0;
  auto count = 0;

  for (const auto ch : text) {
    if (ch == word[word_count]) ++word_count;
    if (word[word_count] == '\0') {
      word_count = 0;
      ++count;
    }
  }

  return count;
}
