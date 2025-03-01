#include <catch2/catch_test_macros.hpp>

template<typename Number>
Number
add(Number a, Number b)
{
  return a + b;
}    

TEST_CASE("IntTest", "[add]")
{
  REQUIRE(add(2,3)==5);
}
