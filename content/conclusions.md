# Conclusions and recommendations

## The basics
- Learn one test framework well enough for basics
  - Explore and use the good tools that exist out there
  - An incomplete list of testing frameworks can be found in the [Quick Reference](quick-reference)
- Start with some basics
  - Some simple thing that test all parts
- Automate tests
  - Faster feedback and reduce the number of surprises

## Going more in-depth

- Strike a healthy balance between unit tests and integration tests
- As the code gets larger and the chance of undetected bugs
  increases, tests should increase.
- When adding new functionality, also add tests
- When you discover and fix a bug, also commit a test against this bug
- Use code coverage analysis to identify untested or unused code
- If you make your code easier to test, it becomes more modular


## Ways to get started

You probably won't do everything perfectly when you start off... But
what are some of the easy starting points?

- Do you have some single functions that are easy to test, but hard to
  verify just by looking at them?  Add unit tests.

- Do you have data analysis or simulation of some sort?  Make an
  end-to-end test with sample data, or sample parameters.  This is
  useful as an example anyway.

- A local testing framework + Github actions is very easy!  And works
  well in the background - you do whatever you want and get an email
  if you break things.  It's actually pretty freeing.
