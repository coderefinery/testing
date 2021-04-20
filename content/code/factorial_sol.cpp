#include <catch2/catch.hpp>

#include "factorial.hpp"

TEST_CASE("Compute the factorial", "[factorial]") {
  REQUIRE(factorial(0) == 1);
  REQUIRE(factorial(1) == 1);
  REQUIRE(factorial(2) == 2);
  REQUIRE(factorial(3) == 6);
}
