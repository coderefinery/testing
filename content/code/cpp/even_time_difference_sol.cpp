// Changing variables included from headers (monkey patching) is not possible in C++.
#include <catch2/catch.hpp>


TEST_CASE("Check time difference", "[reactor_state]") {
  REQUIRE(check_reactor_temperature(99) == ReactorState::FINE);
  REQUIRE(check_reactor_temperature(100) == ReactorState::FINE);
  REQUIRE(check_reactor_temperature(101) == ReactorState::CRITICAL);
}