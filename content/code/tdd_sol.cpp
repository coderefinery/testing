// in the fizzbuzz.hpp header file
#include <string>

std::string fizzbuzz(unsigned int n) {
  if (n % 15 == 0) {
    return "FizzBuzz";
  } else if (n % 3 == 0) {
    return "Fizz";
  } else if (n % 5 == 0) {
    return "Buzz";
  } else {
    return std::to_string(n);
  }
}

// in the source file for the main executable
#include <cstdlib>
#include <iostream>

int main() {
  for (auto i = 0; i < 100; ++i) {
    std::cout << fizzbuzz(i) << std::endl;
  }
}

// in the source file for the test
#include <string>

#include <catch2/catch.hpp>

#include "fizzbuzz.hpp"

TEST_CASE("FizzBuzz", "[fizzbuzz]") {
  auto expected = std::vector<std::string>{
	"1",        "2",    "Fizz", "4",    "Buzz", "Fizz", "7",
	"8",        "Fizz", "Buzz", "11",   "Fizz", "13",   "14",
	"FizzBuzz", "16",   "17",   "Fizz", "19",   "Buzz"};

  for (auto i = 1; i <= 21; ++i) {
    REQUIRE(fizzbuzz(i) == expected[i]);
  }
}

