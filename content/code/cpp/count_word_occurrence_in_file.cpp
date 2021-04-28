#include <fstream>
#include <streambuf>
#include <string>

/* Counts how often word appears in file fname.
 * Example: if file contains "one two one two three four"
 *          and word is "one", then this function returns 2
 */
int count_word_occurrence_in_file(std::string fname, std::string word) {
  std::ifstream fh(fname);
  std::string text((std::istreambuf_iterator<char>(fh)),
		   std::istreambuf_iterator<char>());

  auto word_count = 0lu; // will be used for indexing and therefore it has to be *long unsigned* int for the safe conversion to 'std::__cxx11::basic_string<char>::size_type'.
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
