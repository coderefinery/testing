# Motivation

```{questions}
- Why automated tests
- Can there be situations where automated tests are too much?
```


## Untested software can be compared to uncalibrated detectors

*"Before relying on a new experimental device, an experimental scientist always
establishes its accuracy. A new detector is calibrated when the scientist
observes its responses to known input signals. The results of this
calibration are compared against the expected response."*

> [From [Testing and Continuous Integration with Python](http://katyhuff.github.io/python-testing/), created by K. Huff]

Simulations and analysis using software *should* be held to the same standards!

Further motivation for testing:

- [A Scientist's Nightmare: Software Problem Leads to Five Retractions](https://science.sciencemag.org/content/314/5807/1856.summary)
- [Researchers find bug in Python script may have affected hundreds of studies](https://arstechnica.com/information-technology/2019/10/chemists-discover-cross-platform-python-scripts-not-so-cross-platform/)

---

## Testing in a nutshell

In software tests, expected results are compared with observed results in order
to establish accuracy:

````{tabs}
   ```{code-tab} py

   def fahrenheit_to_celsius(temp_f):
       """Converts temperature in Fahrenheit
       to Celsius.
       """
       temp_c = (temp_f - 32.0) * (5.0/9.0)
       return temp_c

   # This is the test function: `assert` raises an error if something
   # is wrong.
   def test_fahrenheit_to_celsius():
       temp_c = fahrenheit_to_celsius(temp_f=100.0)
       expected_result = 37.777777
       assert abs(temp_c - expected_result) < 1.0e-6
   ```

   ```{code-tab} r R

   To be added ...
   ```
````

Why are we not comparing directly all digits with the expected result?

---

## Tests help preserving expected functionality

- As projects grow, it becomes easier to break things without noticing immediately
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
- Users of your code publish papers based on results produced by your code
- Your peers need to be able to reproduce your (to be) published computational results

---

## Tests help other developers

- Tests make it easier to **refactor the code** (rewrite code while keeping functionality)
- Code can become unsustainable without runnable tests and becomes legacy software
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
   ```{code-tab} py

   def fahrenheit_to_celsius(temp_f):
       temp_c = (temp_f - 32.0) * (5.0/9.0)
       return temp_c

   temp_c = fahrenheit_to_celsius(temp_f=100.0)
   print(temp_c)
   ```

   ```{code-tab} r R

   To be added ...
   ```
````


### Less good code: has side effects and is difficult to test

How would you test this code:

````{tabs}
   ```{code-tab} py

   f_to_c_offset = 32.0
   f_to_c_factor = 0.555555555
   temp_c = 0.0

   def fahrenheit_to_celsius_bad(temp_f):
       global temp_c
       temp_c = (temp_f - f_to_c_offset) * f_to_c_factor

   fahrenheit_to_celsius_bad(temp_f=100.0)
   print(temp_c)
   ```

   ```{code-tab} r R

   To be added ...
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
