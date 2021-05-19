#include <cstdlib>
#include <iostream>

/* Converts temperature in Fahrenheit to Celsius. */
double fahrenheit_to_celsius(double temp_f) {
  auto temp_c = (temp_f - 32.0) * (5.0 / 9.0);
  return temp_c;
}

int main() {
  auto temp_c = fahrenheit_to_celsius(20);
  std::cout << temp_c << std::endl;
  return EXIT_SUCCESS;
}
