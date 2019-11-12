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
  - "Tests make sure that expected functionality is preserved"
  - "Tests help both users and developers of your code"
  - "Tests help managing complexity"
---

## Untested software can be compared to uncalibrated detectors

Before relying on a new experimental device, an experimental scientist always
establishes its accuracy. A new detector is calibrated when the scientist
observes its responses to known input signals. The results of this
calibration are compared against the expected response.  

Simulations and analysis using software *should* be held to the same 
standards!  

> Adapted from [Testing and Continuous Integration with Python](http://katyhuff.github.io/python-testing/), created by Kathryn Huff


Further motivation for testing:

- [A Scientist's Nightmare: Software Problem Leads to Five Retractions](https://science.sciencemag.org/content/314/5807/1856.summary)
- [Researchers find bug in Python script may have affected hundreds of studies](https://arstechnica.com/information-technology/2019/10/chemists-discover-cross-platform-python-scripts-not-so-cross-platform/)

---

## Testing in a nutshell

In software tests, expected results are compared with observed results in order
to establish accuracy:

```python
def fahrenheit_to_celsius(temp_f):
    """
    Converts temperature in Fahrenheit
    to Celsius.
    """
    temp_c = (temp_f - 32.0) * (5.0/9.0)
    return temp_c


def test_fahrenheit_to_celsius():
    temp_c = fahrenheit_to_celsius(temp_f=100.0)
    expected_result = 37.777777
    assert abs(temp_c - expected_result) < 1.0e-6
```

Why are we not comparing directly all digits with the expected result?

---

## Tests make sure that expected functionality is preserved

- As projects grow, it becomes easier to break things without noticing immediately
- Testing helps detecting errors early
- Interpreted dynamically typed imperative languages need to be tested
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

## Tests help developers of your code

- Tests make it possible to refactor the code
- Code is unsustainable without runnable tests and becomes legacy software
- Documentation which is up to date by definition
- Easier for external developers to contribute to the project without breaking your code

Suiting up to modify untested code:

<img src="{{ site.baseurl }}/img/suit.jpg" style="width: 400px;"/>

---

## Tests help managing complexity

- Well structured code is easy to test
- Badly structured code is difficult to test automatically
- **Tests guide towards modular code structure**

#### Good code: pure and easy to test

```python
def fahrenheit_to_celsius(temp_f):
    temp_c = (temp_f - 32.0) * (5.0/9.0)
    return temp_c

temp_c = fahrenheit_to_celsius(temp_f=100.0)
print(temp_c)
```

#### Less good code: has side effects and is difficult to test

```python
f_to_c_offset = 32.0
f_to_c_factor = 0.555555555
temp_c = 0.0

def fahrenheit_to_celsius_bad(temp_f):
    global temp_c
    temp_c = (temp_f - f_to_c_offset) * f_to_c_factor

fahrenheit_to_celsius_bad(temp_f=100.0)
print(temp_c)
```

---

> ## Would you trust a code ...
> 
> - ... when its tests do not pass?
> - ... if there are no tests at all?
> - ... if the tests are never run?
{: .task}
