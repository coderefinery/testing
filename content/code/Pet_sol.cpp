#include <catch2/catch.hpp>

#include "pet.hpp"

TEST_CASE("Check my pets", "[pets]") {
  auto fido = Pet("fido");
  REQUIRE(fido.hunger() == 0);

  fido.go_for_a_walk();
  REQUIRE(fido.hunger() == 1);
}
