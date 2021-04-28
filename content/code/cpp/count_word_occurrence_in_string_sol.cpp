#include <catch2/catch.hpp>

#include "word_count.hpp"

TEST_CASE("Count occurrences of substring in string", "[count_word_occurrence_in_string]") {
  REQUIRE(count_word_occurrence_in_string("AAA BBB", "AAA") == 1);
  REQUIRE(count_word_occurrence_in_string("AAA AAA", "AAA") == 2);
  REQUIRE(count_word_occurrence_in_string("AAAA", "AAA") == 0);

