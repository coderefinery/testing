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

Simulations and analysis using software *should* be held to the same standards as experimental measurement devices!

Further motivation for testing:

- [A Scientist's Nightmare: Software Problem Leads to Five Retractions](https://science.sciencemag.org/content/314/5807/1856.summary)
- [Researchers find bug in Python script may have affected hundreds of studies](https://arstechnica.com/information-technology/2019/10/chemists-discover-cross-platform-python-scripts-not-so-cross-platform/)

---

## Testing in a nutshell

In software tests, expected results are compared with observed results in order
to establish accuracy:

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

Why are we not comparing directly all digits with the expected result?

---

## Tests help preserving expected functionality

- As projects grow, it becomes easier to break things without noticing immediately
- Software defects can be caused by both human errors and non-controllable events (i.e. environmental conditions)
- Testing helps **detecting new errors early**
- Interpreted dynamically typed imperative languages often need to be tested
- So do compiled languages but the compiler catches at least some errors
- Testing is essential for research software because we care about
  reproducibility of scientific results and because derivative research and
  programs depend on research software
- "Program testing can be used to show the presence of bugs, but never to show their absence!" (Edsger W. Dijkstra)

---

## Tests help users of your code

- Make it easier for others to verify whether the code has been correctly installed
- Provide basis to judge the quality of the code
- Users of your code publish papers based on results produced by your code
- Your peers need to be able to reproduce your (to be) published computational results

---

## Tests help other developers

- Tests make it easier to **refactor the code** (rewrite code while keeping functionality)
- Code can become unsustainable without runnable tests and becomes legacy software (i.e. software outdated and not usable anymore)
- Documentation which is up to date by definition
- Easier for external developers to contribute to the project without breaking your code
  (**you may immediately see problems in your code but others may not**)
  - You are confident accepting contributions
  - *You* can confidently improve your code

```{figure} img/suit.jpg
:alt: Old-fashioned diving suit
:width: 300px

Suiting up to modify untested code.
```

---

## Tests help managing complexity


### Good code: pure and easy to test

"Pure": no side effects.
We already know how to test this code (see above):

````{tabs}
   ```{group-tab} Python

      ```{literalinclude} code/python/fahrenheit_to_celsius_pure.py
      :language: python
      ```
   ```

   ```{group-tab} C++

      ```{literalinclude} code/cpp/fahrenheit_to_celsius_pure.cpp
      :language: C++
      ```
   ```
   
   ```{group-tab} R

      ```{literalinclude} code/R/fahrenheit_to_celsius_pure.R
      :language: R
      ```
   ```

   ```{group-tab} Julia

      ```{literalinclude} code/julia/fahrenheit_to_celsius_pure.jl
      :language: Julia
      ```
   ```

   ```{group-tab} Fortran

      ```{literalinclude} code/fortran/fahrenheit_to_celsius_pure.f90
      :language: fortran
      ```
   ```
````


### Less good code: has side effects and is difficult to test

How would you test this code:

````{tabs}
   ```{group-tab} Python

      ```{literalinclude} code/python/fahrenheit_to_celsius_impure.py
      :language: python
      ```
   ```

   ```{group-tab} C++

      ```{literalinclude} code/cpp/fahrenheit_to_celsius_impure.cpp
      :language: C++
      ```
   ```
   
   ```{group-tab} R

      ```{literalinclude} code/R/fahrenheit_to_celsius_impure.R
      :language: R
      ```
   ```

   ```{group-tab} Julia

      ```{literalinclude} code/julia/fahrenheit_to_celsius_impure.jl
      :language: Julia
      ```
   ```

   ```{group-tab} Fortran

      ```{literalinclude} code/fortran/fahrenheit_to_celsius_impure.f90
      :language: fortran
      ```
   ```
````


> ## Tests guide towards modular code structure
>
> - Well structured code (modular code) is easy to test
> - "Badly" structured code is difficult to test automatically
> - If you make it easier to test, it becomes more modular
> - To make code more modular, maybe start by thinking about how to make it testable if you need inspiration?
{: .discussion}

---

> ## Discussion: When is it OK not to add tests?
>
> **It is always a balance: there is no "always"/"never"**.
> - Jupyter or R Markdown notebook which produces a plot and you know by
>   looking at the plot whether it worked?
> - A short, "obviously correct" Python or R script which you never intend to reuse?
> - A simple short, "obviously correct" shell script?
> - Can you give other examples?
{: .discussion}
