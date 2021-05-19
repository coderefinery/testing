#include <cstdlib>
#include <iostream>

constexpr double f_to_c_offset = 32.0;
constexpr double f_to_c_factor = 0.555555555;
double temp_c = 0.0;

/* Converts temperature in Fahrenheit to Celsius. */
void fahrenheit_to_celsius(double temp_f) {
  temp_c = (temp_f - f_to_c_offset) * f_to_c_factor;
}

int main() {
  fahrenheit_to_celsius(20);
  std::cout << temp_c << std::endl;
  return EXIT_SUCCESS;
}
