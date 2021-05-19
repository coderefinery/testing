#include <cmath>  // std::abs
#include <cstdlib>
#include <iostream>

using namespace std;

/* Converts temperature in Fahrenheit to Celsius. */
double fahrenheit_to_celsius(double temp_f) {
  auto temp_c = (temp_f - 32.0) * (5.0 / 9.0);
  return temp_c;
}

/* This is the test function: `throws` raises an error if something is wrong. */
void test_fahrenheit_to_celsius() {
  auto temp_c = fahrenheit_to_celsius(100.0);
  auto expected_result = 37.777777;
  try {
    if (abs(temp_c - expected_result) > 1.0e-6) throw "Error";
  } catch (char const* err) {
    cout << err;
  }
}

int main() {
  cout << fahrenheit_to_celsius(20);
  test_fahrenheit_to_celsius();
  return EXIT_SUCCESS;
}
