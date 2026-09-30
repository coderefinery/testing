# Conclusions and recommendations

```{objectives}
- What is a realistic approach to automated test?
- How can I start?
```

---

## Discussion: What's easy and hard to test?

```{discussion} Discussion: Testing in practice

Use the collaborative notes to answer these questions:

1. Give examples of things (from your work) that are easy to test.
2. Give examples of things (from your work) that are hard to test.
```

---

Considering automated tests when writing code 
is a major mental shift, that you will hopefully embrace 
after attending this lesson.

## The basics: what knowledge do you need?

Learn one {term}`testing framework` well enough for basics:
- Explore and use the good tools that exist out there.
- An incomplete list of testing frameworks 
  can be found [here](#unit-test-frameworks).

### Why use a testing framework?

Automated testing typically involves a number of repetitive tasks
and tricky problem solving.

Fortunately for us, 
someone has already found a solution for most of these
and created {term}`testing framework`s that we can use.

Note: not all frameworks solve all problems 
(also because sometimes the underlying language does not have the necessary features).

```{list-table} Why use a testing framework?
:widths: 40 40 20
* - **Typical problem**
  - **Solution**
  - **Examples**
* - Report failures/successes  
    consistently  
    (to humans or other machines)
  - Automated collection and output,  
    (e.g., Junit XML format or [TAP](https://en.wikipedia.org/wiki/Test_Anything_Protocol))
  - Fundamental feature that  
    all testing frameworks have
* - Remember to run  
    all the tests you write  
    in the main test script/program
  - Automatic discovery,  
    automatic {term}`registration<test registration>`  
    when declaring test functions
  - [pytest](https://docs.pytest.org/en/stable/)
* - Run only some tests  
    (to save time)
  - Test filtering  
    via patterns
  - [pytest](https://docs.pytest.org/en/stable/how-to/usage.html#specifying-which-tests-to-run)
* - Provide useful information  
    on why a test has failed
  - "Smart" assertions/macros
  - [pytest](https://docs.pytest.org/en/stable/how-to/assert.html#assert), 
    [GoogleTest](https://google.github.io/googletest/primer.html#assertions)
* - Run same test for many  
    known input/output combinations
  - Parametric tests
  - [pytest](https://docs.pytest.org/en/stable/how-to/parametrize.html#pytest-mark-parametrize-parametrizing-test-functions),  
    [Julia](https://docs.julialang.org/en/v1/stdlib/Test/#Working-with-Test-Sets) (see `testset for`)
* - Check that a property holds  
    for a class of inputs and outputs
  - Automatically generate test cases  
    based on a strategy  
    (property testing)
  - [hypothesis](https://hypothesis.readthedocs.io/en/latest/tutorial/introduction.html)  
    (Python)
* - Debugging on failure 
  - Start debugger on test failure
  - `pytest --pdb`
* - Floating point equalities  
    with tolerance
  - Macros/classes
  - `≈` (Julia), `pytest.approx` 
* - Set up and tear down  
    of complex test cases
  - {term}`Fixture`s
  - [pytest](https://docs.pytest.org/en/stable/explanation/fixtures.html),  
    [GoogleTest](https://google.github.io/googletest/primer.html#same-data-multiple-tests)
* - Estimate how much of your code  
    is *run* in the test suite
  - Automatic {term}`coverage<code coverage>`  
    measurement
  - [Pytest-cov](https://pytest-cov.readthedocs.io/en/latest/),  
    [gcov/lcov](https://wiki.cs.jmu.edu/reference/gcov/)  
    (for C/C++/Fortran)
* - Do code examples  
    in documentation  
    work as expected?
  - Documentation tests  
    (doctests)
  - [Python](https://docs.python.org/3/library/doctest.html),  
    [Julia](https://documenter.juliadocs.org/stable/man/doctests/),
    [R](https://cran.r-project.org/web/packages/doctest/vignettes/doctest.html)
* - Will my code work  
    with different versions  
    of the dependencies?
  - Test in different environments
  - [tox](https://tox.wiki/en), [Nox](https://nox.thea.codes/en/stable/index.html)  
    (Python)
```


## Don't over-test

- Not every code needs perfect {term}`test coverage<code coverage>`. 
- A simple script or notebook probably does not need an automated test.

## Pick the low-hanging fruits first

You probably won't do everything perfectly when you start off... But
what are some of the easy starting points?

**If you have got nothing yet**:
1. Start with an end-to-end test. 
  Typically easy to add, from a "manual" use case.
  This should match (or serve as) an **example in the code documentation** anyway.
  - Describe in words how *you* check whether the code still works.
  - Translate the words into a script.
  - Run the script as often as reasonable.

2. Do you have some single functions that are easy to test, but hard to
  verify just by looking at them?  Add unit tests.

3. A local testing framework + GitHub actions/Gitlab CI-CD is very easy!
  And works well in the background - you do whatever you want and get an email
  if you break things.  It's actually pretty freeing.

**If you need to start modifying some existing code:**
1. Add a {term}`characterization test` for the part of the code you need to change.
2. Add tests for any functionality you intend to add.
3. Consider adding some end-to-end tests for the use case you have in mind.

## Going more in-depth

**With time**:
- The code gets larger, 
  the chance of undetected bugs increases, 
  tests should increase.
- Bugs will be found. When you find them, add tests against those.


**How to improve your code:**
- Use {term}`code coverage` analysis to identify untested or unused code.
  Remember [Goodhart's Law](https://en.wikipedia.org/wiki/Goodhart%27s_law).
- Strike a healthy balance between different kinds of tests:
  - Fast tests give you information quicker but can be shallow;
  - Thorough tests can catch more bugs but take longer to run
    and can be brittle.
  
  The {term}`test pyramid` 
  is a recommended strategy to balance between test types.

- If you make your code easier to test, it becomes more modular (and vice versa - see the [modular code development lesson](https://coderefinery.github.io/modular-type-along/)).
- **Learning how to test well make the rest of your code better, too.**

