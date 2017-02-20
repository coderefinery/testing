---
layout: episode
title: "Motivation"
teaching: 10
exercises: 0
questions:
  - "Why should we write tests?"
objectives:
  - "Discuss the advantages of writing and maintaining tests in research software."
keypoints:
  - "Do not trust software when its tests do not cover its claimed capabilities
     (test coverage) and when its tests do not pass or if there are no tests at all
     or if the tests are never run."
---

## Simulations and analysis with untested software do not constitute science

"Before relying on a new experimental device, an experimental scientist always
establishes its accuracy. A new detector is calibrated when the scientist
observes its responses to known input signals. The results of this
calibration are compared against the expected response. An experimental
scientist would never conduct an experiment with uncalibrated detectors - that
would be unscientific. So too, simulations and analysis with untested
software do not constitute science."
(copied from [Testing and Continuous Integration with Python](http://katyhuff.github.io/python-testing/),
created by Kathryn Huff, see also the Testing chapter in
[Effective Computation In Physics](http://physics.codes) by Anthony Scopatz and Kathryn Huff)

---

## Testing in a nutshell

In software tests, expected results are compared with observed results in order
to establish accuracy:

```python
def get_bmi(mass_kg, height_m):
    """
    Calculates the body mass index.
    """
    return mass_kg/(height_m**2)


def test_get_bmi():
    bmi = get_bmi(mass_kg=90.0, height_m=1.91)
    expected_result = 24.670376
    assert abs(bmi - expected_result) < 1.0e-6
```

`assert` translates to English as "make sure that".

Why are we not comparing directly all digits with the expected result?

---

## Tests make sure that expected functionality is preserved

- More robust code
- As projects grow, it becomes easier to break things without noticing immediately
- In particular for non-modular entangled projects (effects at distance)
- Testing helps detecting errors early:
  programming without constantly testing your changes will introduce errors
  and it is extremely time consuming to detect and fix them
- Interpreted dynamically typed imperative languages need to be tested
- So do compiled languages but the compiler catches at least some errors
- We publish scientific papers based on scientific code
- Scientific software cannot be called scientific unless it has been validated
  (taken from [Testing and Continuous Integration with Python](http://katyhuff.github.io/python-testing/))
- Testing is essential for research software because we care about
  reproducibility of scientific results and because derivative research and
  programs depend on research software
- "Program testing can be used to show the presence of bugs, but never to show their absence!" (Edsger W. Dijkstra)

---

## Tests help users of your code

- Users and computing center personnel may not be able to identify incorrect
  installation without automated testing (running a calculation and checking results
  with the naked eye is not automated testing)
- Users of your code publish papers based on results produced by your code
- Your peers need to be able to reproduce your (to be) published computational results

---

## Tests help developers of your code

- Satisfying instant visual feedback
- Avoid coding constipation
- Avoid "gold-plating" the code
- Tests make it possible to refactor the code
- Code is unsustainable without runnable tests and becomes legacy software

---

## Tests facilitate external contributions

Tests can be good documentation of what the code is capable to do and how it is
supposed to be used since the tests are **documentation which is up to date by
definition**.

Easier for external developers to contribute to the project without breaking
your code.

Suiting up to modify untested code:

<img src="{{ site.baseurl }}/img/suit.jpg" style="width: 400px;"/>

Easier for you to accept contributions from others knowing that functionality
has been preserved.

---

## Tests help managing complexity

- Help to identify dependcies when modularizing and encapsulating code
- Unit tests sharpen and document interfaces
- Enable reuse and migration
- Faster coding: allows to make big changes quickly; refactoring
- You start with design; often leads to better design
- Well structured code is easy to test
- **Tests guide towards modular code structure**

#### Good code: pure and easy to test

```python
# function which computes the body mass index
def get_bmi(mass_kg, height_m):
    return mass_kg/(height_m**2)

# compute the body mass index
bmi = get_bmi(mass_kg=90.0, height_m=1.91))
```

#### Less good code: has side effects and is difficult to test

```python
mass_kg = 90.0
height_m = 1.91
bmi = 0.0

# function which computes the body mass index
def get_bmi():
    global bmi
    bmi = mass_kg/(height_m**2)

# compute the body mass index
get_bmi()
```
