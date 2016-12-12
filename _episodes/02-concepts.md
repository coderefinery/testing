---
layout: episode
title: "Concepts"
teaching: 20
exercises: 0
questions:
  - "What are unit tests, regression tests, and integration tests?"
  - "What is test coverage?"
  - "How should we approach testing?"
objectives:
  - "Write me"
keypoints:
  - "Write me"
---

## Tests are no guarantee

<img src="{{ site.baseurl }}/img/unit-testing.jpg" style="width: 500px;"/>

- https://twitter.com/dave1010/status/613601365529657344

---

## Imperfect tests run frequently are better than perfect tests which are never written

## Important

- Test frequently (each commit)
- Test automatically (Travis CI)
- Test with numerical tolerance
- Think about code coverage (https://coveralls.io)
- Write test, red, green, refactor

---

## Unit tests

- Test one unit: module or even single function
- Sharpen interfaces
- Speed up testing
- Good documentation of the capability and dependencies of a module
- In fact it is a documentation that is up to date by definition

---

## Test-driven development

- Write tests before writing code
- Very often we know the result that a function is supposed to produce
- Development cycle:
    - Write the test
    - Write an empty function template
    - Test that the test fails
    - Program until the test passes
    - Perhaps refactor
    - Move on

---

## Functionality regression tests

- Like in a car assembly we have to test all components and also whether the components work together
- Typically tests entire code for a set of input examples and compares them with reference outputs
- Hopefully with numerical tolerance
- Typically we need both unit and functionality regression tests
- Both are no guarantee that the code is correct "always"

---

## Performance regression tests

- Real example
    - In one code module somebody forgot and committed debug code
    - This did not break functionality
    - It slowed down that part of the code by factor 2
    - Nobody noticed for one year because we had no automatic detection of performance degradation

- Good idea
    - Create benchmark calculations to cover various performance-critical modules
    - Run these benchmarks regularly (weekly?)
    - Monitor the timing
    - If timing changes significantly, alarm bells should be ringing

---

## Code coverage

- If I break the code and all tests pass who is to blame?
- A code that is not tested will break sooner or later
- Code coverage measures and documents which lines of code have been traversed during a test run
- It is possible to have line-by-line coverage (example later)
- In all the files that have zero coverage you can multiply all numbers with 10E5 and all tests
  will happily pass

---

## Total time to test matters

- You should require developers to run the test set before each `git push`
- Professional projects require running the test set before each commit
- In extreme cases after each save
- With a `pre-commit` hook you can make sure that commits that break tests are rejected
- Total time to test matters
- If the test set takes 7 hours to run, it is likely that nobody will run it
- Identify fast essential test set that has sufficient coverage and is sufficiently
  short to be run before each commit or push

---

## Continuous integration

- Test each commit on every branch
- Makes it possible for the mainline maintainer to see whether a modification
  breaks functionality before accepting the merge

---

## Good practices (1/2)

- Test before committing (use the Git staging area)
- Fix broken tests immediately (dirty dishes effect)
- Do not deactivate tests "temporarily"
- Think about coverage (physics and lines of code)
- Go public with your testing dashboard and issues/tickets
- Dogfooding: use the code/scripts that you ship

---

## Good practices (2/2)

- Think about input sanitization (green testing dashboard does not prevent me from making unexpected keyword combinations)
- Test controlled errors: if something is expected to fail, test for that
- Make testing easy to run (`make test`)
- Make testing easy to analyze
    - Do not flood screen with pages of output in case everything runs OK
    - Test with numerical tolerance (extremely annoying to compare digits by eye)

---

## Missing

- defensive programming
- assertions
- exceptions
- unit tests: they are just functions [cite katy]
- regression tests: the past is what we accept as correct [cite katy]
- integration tests
- CI
- test driven development
- test coverage

Robert C. Martin, the author of “Clean Code” said : “The first rule of
functions is that they should be small. The second rule of functions is that
they should be smaller than that.” [cite katy]

Test suite: Collection of all of the tests for a given code.
