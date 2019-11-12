---
layout: episode
title: "Exercise: Testing with pytest"
teaching: 0
exercises: 15
questions:
  - "How can we implement a test suite using pytest?"
  - "I am a Fortran developer, do I need to care about pytest?"
objectives:
  - "Get comfortable with pytest."
keypoints:
  - "pytest collects and runs all test functions starting with `test_`"
  - "Python and C/C++ have better tooling for automated tests and you can use those also for Fortran projects (via `iso_c_binding`)."
---

## Type-along: [pytest](http://doc.pytest.org) exercise

In this exercise we will make a simple Python function and use
[pytest](http://doc.pytest.org) to test it. We will try to
keep things simple so that those who do not use Python can follow.

Create a new directory and change into it:

```shell
$ mkdir pytest-example
$ cd pytest-example
```

Then create a file called `example.py` and copy-paste the following code into it:

```python
def add(a, b):
    return a + b


def test_add():
    assert add(2, 3) == 5
    assert add('space', 'ship') == 'spaceship'
```

This code contains one genuine function and a test function.

Let us try to test it with pytest:

```shell
$ pytest -v example.py

============================================================ test session starts =================================
platform linux -- Python 3.7.2, pytest-4.3.1, py-1.8.0, pluggy-0.9.0 -- /home/user/pytest-example/venv/bin/python3
cachedir: .pytest_cache
rootdir: /home/user/pytest-example, inifile:
collected 1 item

example.py::test_add PASSED

========================================================= 1 passed in 0.01 seconds ===============================
```

Yay! The test passed!

Let us break the test!

Introduce a code change which breaks the code and check
whether pytest detects the change:

```shell
$ pytest -v example.py
============================================================ test session starts =================================
platform linux -- Python 3.7.2, pytest-4.3.1, py-1.8.0, pluggy-0.9.0 -- /home/user/pytest-example/venv/bin/python3
cachedir: .pytest_cache
rootdir: /home/user/pytest-example, inifile:
collected 1 item

example.py::test_add FAILED

================================================================= FAILURES =======================================
_________________________________________________________________ test_add _______________________________________

    def test_add():
>       assert add(2, 3) == 5
E       assert -1 == 5
E         --1
E         +5

example.py:6: AssertionError
========================================================= 1 failed in 0.05 seconds ==============
```

---

## Note to Fortran developers

Personal recommendation:

- Compile the Fortran code to a dynamic library with C interface using `iso_c_binding`
- Document your API in a C header file
- Use Python [CFFI](http://cffi.readthedocs.io) to create a Python module from your C header file and dynamic library
- Test your Fortran code with [pytest](http://doc.pytest.org)
- Since the library is dynamically linked, you do not need to recompile when designing tests
- [Example: Implementing context-aware APIs in different languages](https://github.com/dev-cafe/context-api-example)
