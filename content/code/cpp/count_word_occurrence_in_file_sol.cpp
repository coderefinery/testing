#include <filesystem> // for temp_directory_path(), requires C++17.
#include <fstream>

#include <catch2/catch.hpp>

#include "word_count.hpp"

TEST_CASE("Count occurrences of substring in file", "[count_word_occurrence_in_file]") {
  namespace fs = std::filesystem;
  auto tmp_dir{ fs::temp_directory_path() };
  auto fpath{ fs::temp_directory_path() / "temp_file" };

  std::ofstream s(fpath, std::ios::out | std::ios::trunc);
  s << "one two one two three four" << std::endl;
  s.close();

  REQUIRE(count_word_occurrence_in_file(fname, "one") == 2);
  REQUIRE(count_word_occurrence_in_file(fname, "three") == 1);
  REQUIRE(count_word_occurrence_in_file(fname, "six") == 0);

  fs::remove( fpath );
}
