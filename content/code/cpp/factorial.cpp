/* Computes the factorial of n recursively. */
constexpr unsigned int factorial(unsigned int n) {
   return (n <= 1) ? 1 : (n * factorial(n - 1));
}
