# Motivation

```{objectives}
- Appreciate the importance of testing software
- Understand various benefits of testing
```


## Untested software can be compared to uncalibrated detectors

*"Before relying on a new experimental device, an experimental scientist always
establishes its accuracy. A new detector is calibrated when the scientist
observes its responses to known input signals. The results of this
calibration are compared against the expected response."*

> [From [Testing and Continuous Integration with Python](https://carpentries-incubator.github.io/python-testing/), created by K. Huff]

With testing, simulations and analysis using software *can* be held to the same standards as experimental measurement devices!

What can go wrong when research software has bugs?  Look no further:

- [A Scientist's Nightmare: Software Problem Leads to Five Retractions](https://science.sciencemag.org/content/314/5807/1856.summary)
- [Researchers find bug in Python script may have affected hundreds of studies](https://arstechnica.com/information-technology/2019/10/chemists-discover-cross-platform-python-scripts-not-so-cross-platform/)

---

## Testing in a nutshell

In software tests, expected results are compared with observed results
in order to establish accuracy.  Why are we not comparing directly all
digits with the expected result?:

````{tabs}
   ```{group-tab} Python

      ```{literalinclude} code/python/fahrenheit_to_celsius_test.py
      :language: python
      ```
   ```

   ```{group-tab} C++

      ```{literalinclude} code/cpp/fahrenheit_to_celsius_test.cpp
      :language: C++
      ```
   ```

   ```{group-tab} R

      ```{literalinclude} code/R/fahrenheit_to_celsius_test.R
      :language: R
      ```
   ```

   ```{group-tab} Julia

      ```{literalinclude} code/julia/fahrenheit_to_celsius_test.jl
      :language: Julia
      ```
   ```

   ```{group-tab} Fortran

      ```{literalinclude} code/fortran/fahrenheit_to_celsius_test.f90
      :language: fortran
      ```
   ```
````

Or you can test whole programs:
```console
$ python3 run-test.py

running: sample_data/set1.csv --output=tests/set1.txt
CORRECT
```

---

## What can tests help you do?

**Preserving expected functionality**
- Check old things when you add new ones

**Help users of your code**
- Verify it's installed correctly and works.
- See examples of what it should do.

**Help other developers modify it**
- Change things with confidence that nothing is breaking.
- Warning if documentation/examples go out of date.

**Manage complexity**
- If code is easy to test, it's probably easier to maintain.
- The next lesson [Modular code development](https://coderefinery.github.io/modular-type-along/)
  demonstrates this.

---

## Discussion: When is it OK not to add tests?

```{discussion} Discussion: When is it OK not to add tests?

Vote in the notes and we'll discuss soon.  **It is always a balance: there is no "always"/"never"**.

1. Jupyter or R Markdown notebook which produces a plot and you know by
   looking at the plot whether it worked?
2. A short, "obviously correct" Python or R script which you never intend to reuse?
3. A simple short, "obviously correct" shell script?
4. Can you give other examples?

```

---

## Discussion: What's easy and hard to test?

```{discussion} Discussion: Testing in practice

Use the collaborative notes to answer these questions:

1. Give examples of things (from your work) that are easy to test.
2. Give examples of things (from your work) that are hard to test.
```

---

## Types of tests

* Test functions one at a time - **Unit tests**

* Test how parts work together - **Integration tests**

* Test the whole thing running - **End-to-end tests**
  * For example, running on sample data.

* Check same results as before - **Regression tests**

* Write test first (the output), then write code to make test pass -
  **Test-driven development**

* GitHub or GitLab runs tests automatically - **Continuous
  integration**

* Report that tells you which lines were/were not run by tests -
  **Code coverage**

* Framework that runs test for you - **Testing framework**
  * See [Quick Reference](./quick-reference) for some examples.

---

## What should you do?

* Not every code needs perfect test coverage.

* If code is interactive-only (Jupyter Notebook), it's usually hard to
  test.

  * But also hard to run: the next lesson will discuss!

* At least end-to-end is often easy to add.

* Add tests of tricky functions.

  * If you'd have to run it over and over to test while writing, why
    not make it a property test?

* It's easy to have Gitlab/Github run the tests.

  * It's nice to push without thinking, and the system tells you when
    it's broke.

* **Learning how to test well make the rest of your code better, too.**

---

## Where to start

- A simple script or notebook probably does not need an automated test.

**If you have nothing yet**
- Start with an end-to-end test.
- Describe in words how *you* check whether the code still works.
- Translate the words into a script.
- Run the script automatically on every code change.

**If you want to start with unit-testing**
- You want to rewrite a function? Start adding a unit test right there first.
