---
layout: episode
title: "Exercise: Testing with pytest"
teaching: 10
exercises: 20
questions:
  - "How can we implement a test suite using pytest?"
  - "I am a Fortran developer, do I need to care about pytest?"
objectives:
  - "Get comfortable with pytest."
---

## [pytest](http://doc.pytest.org) exercise

In this exercise we will use [pytest](http://doc.pytest.org). We will try to
keep things simple so that also C and Fortran developers can follow.

Create a new directory and change into it:

```shell
$ mkdir pytest-example
$ cd pytest-example
```

Then create a file called `example.py` and copy-paste the following code into it:

```python
def reverse_string(s):
    """
    Reverses order or characters in string s.
    """
    return s[::-1]


def test_reverse_string():
    assert reverse_string('foobar!') == '!raboof'
    assert reverse_string('stressed') == 'desserts'


def reverse_words(s):
    """
    Reverses order or words in string s.
    """
    words = s.split()
    words_reversed = words[::-1]
    return ' '.join(words_reversed)


def test_reverse_words():
    assert reverse_words('dogs hate cats') == 'cats hate dogs'
    assert reverse_words('dog eat dog') == 'dog eat dog'
    assert reverse_words('one two three four') == 'four three two one'
```

This code contains two genuine functions and two test functions. Before you
look at the implementations `reverse_string` and `reverse_words`, look at the
tests. From the test functions it should be clear what the implementations do
even without understanding Python. We remember now the point about tests
serving as documentation and entry point for new developers.

Let us try to test it with pytest:

```shell
$ py.test -vv example.py
============================================================ test session starts ==================================
platform linux -- Python 3.5.2, pytest-3.0.5, py-1.4.31, pluggy-0.4.0 -- /home/user/pytest-example/venv/bin/python3
cachedir: .cache
rootdir: /home/user/pytest-example, inifile:
collected 2 items

example.py::test_reverse_string PASSED
example.py::test_reverse_words PASSED

========================================================= 2 passed in 0.01 seconds ================================
```

Yay! All tests passed!

Let us break them!

Introduce a code change which breaks the code, for instance:

```shell
$ git diff

diff --git a/example.py b/example.py
index 50bff2d..2d0bfa6 100644
--- a/example.py
+++ b/example.py
@@ -2,7 +2,7 @@ def reverse_string(s):
     """
     Reverses order or characters in string s.
     """
-    return s[::-1]
+    return s
```

Now we want to see whether pytest detects the change:

```shell
$ py.test -vv example.py

============================================================ test session starts ==================================
platform linux -- Python 3.5.2, pytest-3.0.5, py-1.4.31, pluggy-0.4.0 -- /home/user/pytest-example/venv/bin/python3
cachedir: .cache
rootdir: /home/user/pytest-example, inifile:
collected 2 items

example.py::test_reverse_string FAILED
example.py::test_reverse_words PASSED

================================================================= FAILURES ========================================
____________________________________________________________ test_reverse_string __________________________________

    def test_reverse_string():
>       assert reverse_string('foobar!') == '!raboof'
E       assert 'foobar!' == '!raboof'
E         - foobar!
E         + !raboof

example.py:9: AssertionError
==================================================== 1 failed, 1 passed in 0.03 seconds ===========================
```

---

## Note to Fortran developers

Personal recommendation:

- Compile the Fortran code to a dynamic library with C interface using `iso_c_binding`
- Document your API in a C header file
- Use Python [CFFI](http://cffi.readthedocs.io) to create a Python module from your C header file and dynamic library
- Test your Fortran code with [pytest](http://doc.pytest.org)
- Since the library is dynamically linked, you do not need to recompile when designing tests
- [Example: Implementing context-aware APIs in different languages](https://github.com/bast/context-api-example)
