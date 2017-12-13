---
layout: episode
title: "Concepts"
teaching: 10
exercises: 0
questions:
  - "What are unit tests, regression tests, and integration tests?"
  - "What is test coverage?"
  - "How should we approach testing?"
objectives:
  - "Understand how the different layers of testing fit to each other."
keypoints:
  - "Automatize testing."
---

## Defensive programming

Assume that mistakes will happen and introduce guards against them:
- Assertions
- Unit tests
- Regression tests

---

## How?

Imperfect tests run frequently are better than perfect tests which are never written

### Important

- Test frequently (each commit)
- Test automatically ([Travis CI](https://travis-ci.org))
- Test with [numerical tolerance](http://www.smbc-comics.com/comic/2013-06-05)
- Think about code coverage ([Coveralls](https://coveralls.io) or [Codecov](https://codecov.io))

---

## Unit tests

- Unit tests are functions ([Testing and Continuous Integration with Python](http://katyhuff.github.io/python-testing/))
- Test one unit: module or even single function
- Help to sharpen interfaces by identifying dependencies
- Speed up testing
- Good documentation of the capability and dependencies of a module
- In fact it is a documentation that is up to date by definition

---

## Integration tests

- Integration tests verify whether muliple modules are working well together ([Testing and Continuous Integration with Python](http://katyhuff.github.io/python-testing/))
- Like in a car assembly we have to test all components independently and also whether the components are working together when combined
- Unit tests can be used for testing independent components (e.g. engine, radiator, transmission) and integration tests to check if car is working overall
- Essential for having adequate testing
- An imperfect integration test is better than no integration test at all

---
## Test-driven development

- Write tests before writing code
- Very often we know the result that a function is supposed to produce
- Development cycle (red, green, refactor):
    - Write the test
    - Write an empty function template
    - Test that the test fails
    - Program until the test passes
    - Perhaps refactor
    - Move on

---

## Functionality regression tests

- The past is what we accept as correct ([Testing and Continuous Integration with Python](http://katyhuff.github.io/python-testing/))
- If a defect in car engine is fixed, then regression tests can be used to check if the fixed defect has caused any new problems  
- Typically tests entire code for a set of input examples and compares them with reference outputs
- Hopefully with numerical tolerance
- Typically we need both unit and functionality regression tests
- Both are no guarantee that the code is correct "always"

Tests are no guarantee ([@dave1010](https://twitter.com/dave1010/status/613601365529657344)):

<img src="{{ site.baseurl }}/img/unit-testing.jpg" style="width: 500px;"/>

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

- Test each commit (push) on every branch
- Makes it possible for the mainline maintainer to see whether a modification
  breaks functionality before accepting the merge

---

## Good practices

- Test before committing (use the Git staging area)
- Fix broken tests immediately (dirty dishes effect)
- Do not deactivate tests "temporarily"
- Think about coverage (physics and lines of code)
- Go public with your testing dashboard and issues/tickets
- Dogfooding: use the code/scripts that you ship
- Think about input sanitization (green testing dashboard does not prevent me from making unexpected keyword combinations)
- Test controlled errors: if something is expected to fail, test for that
- Make testing easy to run (`make test`)
- Make testing easy to analyze
    - Do not flood screen with pages of output in case everything runs OK
    - Test with numerical tolerance (extremely annoying to compare digits by eye)

<img src="{{ site.baseurl }}/img/commenting-out-tests.jpg" style="width: 500px;"/>

Image by [@thepracticaldev](https://github.com/thepracticaldev/orly-full-res), CC-BY-NC.
