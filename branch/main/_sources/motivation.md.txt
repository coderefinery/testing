# Motivation

```{objectives}
- Appreciate the importance of testing software
- Understand various benefits of testing
```

Most scientists nowadays depend on software for research.  
What can go wrong when research software has bugs?  Look no further:

- [A Scientist's Nightmare: Software Problem Leads to Five Retractions](https://science.sciencemag.org/content/314/5807/1856.summary)
- [Researchers find bug in Python script may have affected hundreds of studies](https://arstechnica.com/information-technology/2019/10/chemists-discover-cross-platform-python-scripts-not-so-cross-platform/)

How can we avoid problems like these?

## What are typical problems that *automated* tests can address?

Have you ever had any of these problems?

- You change B and C, and suddenly A doesn't work anymore.  Time
  wasted trying to figure out what changed.
- There was some simple problem, systematically testing could have
  found it.
  But testing manually takes too much time,
  so nobody has ever done it
  with the appropriate care.
- You get someone else's code. 
  You really need to change it 
  but are afraid to touch it because who
  knows what might break.
  Plot twist: it's your own code!
- You implement features to someone else's code and want to merge it,
  but they are not sure your changes haven't broken anything 
  and it's time consuming to test that.

People have learned that some automatic way to check problems makes
software development much easier.  This lesson will talk about the
places it's useful for research code, and how easy it can be.

## Untested software can be compared to uncalibrated measurement devices 

```{epigraph}
*Before relying on a new experimental device, an experimental scientist always
establishes its accuracy. A new detector is calibrated when the scientist
observes its responses to known input signals. The results of this
calibration are compared against the expected response.*

-- From [Testing and Continuous Integration with Python](https://carpentries-incubator.github.io/python-testing/), created by K. Huff
```

With testing, simulations and analysis using software *can* be held to the same standards as experimental measurement devices!

---

## What can tests help you do?

```{list-table} Problems, Solution and who is affected?
:widths: 40 30 30
* - **Problem**
  - **Solution**
  - **Who is affected?**
* - Breaking old functionality  
    when adding new features 
  - {term}`End-to-End test`s
  - Developers
* - Verify installation
  - {term}`Smoke test`s
  - Users
* - Make small incremental changes,  
    (e.g., improving readability, names)
  - {term}`Unit test`s
  - Developers
* - Make architectural changes,  
    (e.g., shifting code between  
    classes, modules and functions)
  - {term}`Integration test`s  
    {term}`End-to-End test`s
  - Developers
* - Change things with confidence  
    that nothing is breaking
  - All tests
  - Developers
* - Documentation out of date  
    including code examples
  - Executable notebooks  
    and [nbval](https://github.com/computationalmodelling/nbval),  
    {term}`End-to-End test`s
  - Users

```

Very few people are proud of the code they write 
the first time they write it.

Often, they'd like to improve it.

But code without automated tests cannot be improved as easily
as code with automated tests.

Moreover, **code that is easy to test is probably easier to maintain**,
since it needs to be more modular and have better separation of concerns.

The [Modular code development lesson](https://coderefinery.github.io/modular-type-along/)
  demonstrates this.

---

## Testing in a nutshell

There are many forms of testing.

One can write test programs and run them (a form of {term}`end-to-end test`ing):
```console
$ python3 run-test.py

running: sample_data/set1.csv --output=tests/set1.txt
CORRECT
```

In the most basic form of a software test, 
the observed result is compared with expected result (an "*oracle*")
in order to establish correctness.  
Here are some examples of this testing pattern 
in different programming languages (in this case, {term}`unit test`s):

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


---

## Discussion: When is it OK not to add automated tests?

::::{discussion} Discussion: When is it OK not to add automated tests?

Vote in the notes and we'll discuss soon.  **It is always a balance: there is no "always"/"never"**.

1. Jupyter or R Markdown notebook which produces a plot and you know by
   looking at the plot whether it worked?
2. A short, "obviously correct" Python or R script which you never intend to reuse?
3. A simple short, "obviously correct" shell script?
4. Can you give other examples?

:::{solution}
The role of automated tests is to save time when making changes to code.

1. In this case you just "test manually" the notebook by running it. Automated tests might not save you time. 
   But if some non trivial functions are added, you might want to have automated {term}`unit test`s for these separately.

2. Writing automated tests for "throwaway code" can be a waste of time. But if you get back to it, then you should think about writing automated tests for it.

3. "Manual test" can be sufficient. In case of changes, checking the script with a {term}`linter` like [Shellcheck](https://www.shellcheck.net/) might still be useful!

:::

::::

---

## What should you do?


* If code is interactive-only (Jupyter Notebook), it's usually hard to
  test.

  * But also hard to run: the [next lesson](https://coderefinery.github.io/modular-type-along/) will discuss!

* At least end-to-end is often easy to add.

* Add tests of tricky functions.

  * If you'd have to run it over and over to test while writing, why
    not make it a proper automated test?

* It's easy to have Gitlab/Github run the tests.

  * It's nice to push without thinking, and the system tells you when
    it's broken.

* **Learning how to test well make the rest of your code better, too.**


