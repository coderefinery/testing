#include <random>

#include <catch2/catch.hpp>

#include "yahtzee.hpp"

using namespace Catch::literals;

TEST_CASE("Tossing 5 dice", "[toss]") {
  auto n_dice = 5;
  auto faces = std::vector<unsigned int>{1, 2, 3, 4, 5, 6};

  // we fix both the random device and the random engine.
  // the latter is necessary since the default random engine is implementation-dependent
  std::mt19937 prng;
  prng.seed(1234);

  auto expected_1 = std::vector<unsigned int>{3, 5, 4, 5, 6};
  auto toss_1  = roll_dice(n_dice, faces, prng);
  REQUIRE(toss_1 == expected_1);

  auto expected_2 = std::vector<unsigned int>{1, 2, 5, 1, 1};
  auto toss_2  = roll_dice(n_dice, faces, prng);
  REQUIRE(toss_2 == expected_2);

  auto expected_3 = std::vector<unsigned int>{1, 3, 2, 5, 1};
  auto toss_3  = roll_dice(n_dice, faces, prng);
  REQUIRE(toss_3 == expected_3);
}

TEST_CASE("Distribution of Yahtzee", "[yahtzee]") {
  // try a million throws and see if we get close
  // to the statistical average of 4.6%
  // (https://en.wikipedia.org/wiki/Yahtzee#Probabilities)
  auto n_yahtzees = 0;
  auto n_trials = 1e6;

  for (auto i = 0; i < n_trials; ++i) {
    unsigned int value = 0, times = 0;
    std::tie(value, times) = yahtzee();
    if (times == 5) {
      ++n_yahtzees;
    }
  }

  REQUIRE( n_yahtzees / n_tests == 0.046_a)
}
