// Changing variables included from headers (monkey patching) is not possible in C++.
#include <catch2/catch.hpp>

#include "reactor.hpp"

TEST_CASE("Check reactor state", "[reactor_state]") {
  REQUIRE(check_reactor_temperature(99) == ReactorState::FINE);
  REQUIRE(check_reactor_temperature(100) == ReactorState::FINE);
  REQUIRE(check_reactor_temperature(101) == ReactorState::CRITICAL);
