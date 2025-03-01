#include <gtest/gtest.h>

template<typename Number>
Number
add(Number a, Number b)
{
  return a + b;
}    

TEST(AddTests, IntTest)
{
  ASSERT_EQ(add(2,3),5);
}