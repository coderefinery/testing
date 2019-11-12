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

[@dave1010](https://twitter.com/dave1010/status/613601365529657344):

<img src="{{ site.baseurl }}/img/unit-testing.jpg" style="width: 500px;"/>


## How?

Imperfect tests **run frequently** are better than perfect tests which are never written

### Important

- Test frequently (each commit)
- Test automatically (e.g. using [Travis CI](https://travis-ci.org))
- Test with [numerical tolerance](http://www.smbc-comics.com/comic/2013-06-05)
- Think about code coverage ([Coveralls](https://coveralls.io) or [Codecov](https://codecov.io))

---

## Defensive programming

- Assume that mistakes will happen and introduce guards against them.

```python
def kelvin_to_celsius(temp_k):
    """
    Converts temperature in Kelvin
    to Celsius.
    """
    assert temp_k >= 0.0, "ERROR: negative T_K"
    temp_c = temp_k + 273.15
    return temp_c
```

---

## Unit tests

- **Unit tests** are functions 
- Test one unit: module or even single function
- Good documentation of the capability and dependencies of a module

---

## Integration tests

- **Integration tests** verify whether multiple modules are working well together 
- Like in a car assembly we have to test all components independently and also whether the components are working together when combined
- Unit tests can be used for testing independent components (e.g. engine, radiator, transmission) and integration tests to check if car is working overall

---

## Regression tests

- Similarly to integration tests, regression tests often operate on the 
  whole code base
- Rather than assuming that the test author knows what the correct 
  result should be, regression tests look to the past for the expected behavior
- Often spans multiple code versions: when developing a new version, input 
  and output files of a previous version are used to test that the same 
  behaviour is observed

---

## Test-driven development

- In **test-driven devlopment**, one writes tests before writing code
- Very often we know the result that a function is supposed to produce
- Development cycle (red, green, refactor):
    - Write the test
    - Write an empty function template
    - Test that the test fails
    - Program until the test passes
    - Perhaps refactor
    - Move on

---

## Code coverage

- If I break the code and all tests pass who is to blame?
- **Code coverage** measures and documents which lines of code have been traversed during a test run
- It is possible to have line-by-line coverage (example later)

---

## Total time to test matters

- Total time to test matters
- If the test set takes 7 hours to run, it is likely that nobody will run it
- Identify fast essential test set that has sufficient coverage and is sufficiently
  short to be run before each commit or push

---

## Continuous integration

- **Continuous integration** is basically when you automatically test
  every single commit or merge automatically
- Test each commit (push) on every branch
- Test merges before they are accepted
- Makes it possible for the mainline maintainer to see whether a modification
  breaks functionality before accepting the merge

---

## Good practices

- Test before committing (use the Git staging area)
- Fix broken tests immediately (dirty dishes effect)
- Do not deactivate tests "temporarily"
- Think about coverage (physics and lines of code)
- Go public with your testing dashboard and issues/tickets
- Test controlled errors: if something is expected to fail, test for that
- Create benchmark calculations to cover various performance-critical modules and monitor timing
- Make testing easy to run (`make test`)
- Make testing easy to analyze
    - Do not flood screen with pages of output in case everything runs OK
    - Test with numerical tolerance (extremely annoying to compare digits by eye)

<img src="{{ site.baseurl }}/img/commenting-out-tests.jpg" style="width: 500px;"/>

Image by [@thepracticaldev](https://github.com/thepracticaldev/orly-full-res), CC-BY-NC.

---

## References

- For a more detailed exposition of these concepts, see 
  [this Carpentry lesson](https://katyhuff.github.io/python-testing/)

---

## Discussion

- For which situations would you consider automated testing as overkill?
