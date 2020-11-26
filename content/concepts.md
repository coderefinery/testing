# Concepts

```{questions}
- What are unit tests, regression tests, and integration tests?
- What is test coverage?
- How should we approach testing?
```

```{figure} img/unit-testing.jpg
:alt: Tests is no guarantee
:width: 400px

Tests are no guarantee. Figure source: <https://twitter.com/dave1010/status/613601365529657344>
```


## How to test?

Imperfect tests **run frequently** are better than perfect tests which are
never written:
- Test **frequently** (each commit/push)
- Test **automatically** (e.g. using [Travis CI](https://travis-ci.org) or
  [GitHub Actions](https://github.com/marketplace?type=actions) or [GitLab CI](https://docs.gitlab.com/ee/ci/) or similar services)
- Test with [numerical tolerance](http://www.smbc-comics.com/comic/2013-06-05)
- Think about **code coverage** ([Coveralls](https://coveralls.io) or [Codecov](https://codecov.io) or similar services)

---

## Defensive programming

- Assume that mistakes will happen and introduce guards against them.
- Use **assertions** for things you believe will/should never happen.
- Use **exceptions** for anomalous or exceptional conditions requiring
  special processing.

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
- Unit tests can be used for testing independent components (_e.g._ battery, controller, motor) and integration tests to check if car is working overall

---

## Regression tests

- Similarly to integration tests, **regression tests** often operate on the
  whole code base
- Rather than assuming that the test author knows what the correct
  result should be, regression tests look to the past for the expected behavior
- Often spans multiple code versions: when developing a new version, input
  and output files of a previous version are used to test that the same
  behaviour is observed

---

## Test-driven development

- In **test-driven development**, one writes tests before writing code
- Very often we know the result that a function is supposed to produce
- Development cycle (red, green, refactor):
    - Write the test
    - Write an empty function template
    - **Verify that the test fails**
    - Program until the test passes
    - Perhaps improve until you are happy (refactor)
    - Move on

---

## Continuous integration

- **Continuous integration** is basically when you automatically test
  every single commit/push (you test whether code integrates **before** you integrate it)

---

## Code coverage

- If I break the code and all tests pass who is to blame?
- **Code coverage** measures and documents which lines of code have been traversed during a test run
- It is possible to have line-by-line coverage
- [Real-life example](https://coveralls.io/github/bast/runtest)

---

## Total time to test matters

- Total time to test matters
- If the test set takes 7 hours to run, it is likely that nobody will run it
- Identify fast essential test set that has sufficient coverage and is sufficiently
  short to be run before each commit or push
- Test code can be marked (grouped). Here our `pytest` is marked:

```python
@pytest.mark.conversion
def test_fahrenheit_to_celsius():
    temp_c = fahrenheit_to_celsius(temp_f=100.0)
    expected_result = 37.777777
    assert abs(temp_c - expected_result) < 1.0e-6
```

```sh
$ pytest -v -m conversion
```

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


```{keypoints}
- Assertions, exceptions, unit tests, integration tests and regression
  tests are used to test a code on different levels
- Test driven development is one way to develop code which is tested
  from the start
- Continuous integration is when every commit/merge is tested
  automatically
```
