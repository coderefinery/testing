// Changing variables included from headers (monkey patching) is not possible in C++.
#include <catch2/catch.hpp>

#include "reactor.hpp"
#include "constants.hpp"

TEST_CASE("Check reactor state", "[reactor_state]") {
  REQUIRE(check_reactor_temperature(constants::max_temperature-1) == ReactorState::FINE);
  REQUIRE(check_reactor_temperature(constants::max_temperature) == ReactorState::FINE);
  REQUIRE(check_reactor_temperature(constants::max_temperature+1) == ReactorState::CRITICAL);
