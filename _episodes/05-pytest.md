---
layout: episode
title: "Exercise: Testing with pytest"
teaching: 0
exercises: 20
questions:
  - "How can we implement a test suite using pytest?"
  - "What is TDD?"
  - "I am a Fortran developer, do I need to care about pytest?"
objectives:
  - "Get comfortable with pytest."
---

## [pytest](http://doc.pytest.org) exercise

In this exercise we will use [pytest](http://doc.pytest.org).
We will try to keep things simple so that also C and Fortran
developers can follow.

You will get a taste of Test-Driven Development, how it can be done.
Under [Concepts](../02-concepts) we stated the development cycle (red,
green, refactor), where you write the test first. When exampleified
we often see a set of tests together with the functions to be tested.
We do not see the inital stages, only the result of a finished process.
We will go step-by-step testing our code as we go along.

Let us start with a specification of two functions:
 - reverse_string(s):  Reverses order or characters in string s.
 - reverse_word(s):    Reverses order or words in string s.
 
Create a new directory and change into it:

```shell
$ mkdir pytest-example
$ cd pytest-example
```

Then create a file called `example.py` and copy-paste the following
code into it:

```python
def reverse_string(s):
    """
    Reverses order or characters in string s.
    """
    return s

def test_reverse_string():
    assert reverse_string('foobar!') == '!raboof'
    
```

Let us try to test it with pytest:

```shell
$ py.test -vv example.py
==================================== test session starts =====================================
platform darwin -- Python 2.7.14, pytest-3.2.1, py-1.4.34, pluggy-0.4.0 -- /Users/user/anaconda/bin/python
cachedir: .cache
rootdir: /Users/user/projects/pytest/reverse_string, inifile:
collected 1 item                                                                              

example.py::test_reverse_string FAILED

========================================== FAILURES ==========================================
____________________________________ test_reverse_string _____________________________________

    def test_reverse_string():
>       assert reverse_string('foobar!') == '!raboof'
E       AssertionError: assert 'foobar!' == '!raboof'
E         - foobar!
E         + !raboof

example.py:5: AssertionError
================================== 1 failed in 0.04 seconds ==================================
$ 

```

What can we do to make this test pass, getting it "Green"? Let the
function return the reversed string explicitly:

```python
def reverse_string(s):
    """
    Reverses order or characters in string s.
    """
    s = '!raboof'
    return s

def test_reverse_string():
    assert reverse_string('foobar!') == '!raboof'
```

This time the test passes:

```shell
$ py.test -vv example.py                              
==================================== test session starts =====================================
platform darwin -- Python 2.7.14, pytest-3.2.1, py-1.4.34, pluggy-0.4.0 -- /Users/user/anaconda/bin/python       
cachedir: .cache       
rootdir: /Users/user/projects/pytest/reverse_string, inifile:                             
collected 1 item                                                                              

example.py::test_reverse_string PASSED         

================================== 1 passed in 0.01 seconds ==================================
$
```

Ok, so it reverses string 'foobar!'. But we know this breaks as soon as
we test for reversal of another string:

```python
def reverse_string(s):
    """
    Reverses order or characters in string s.
    """
    s = '!raboof'
    return s

def test_reverse_string():
    assert reverse_string('foobar!') == '!raboof'
    assert reverse_string('desserts') == 'stressed'
```

The test breaks again (which is not a surprise):

```shell
$ py.test -vv example.py
==================================== test session starts =====================================
platform darwin -- Python 2.7.14, pytest-3.2.1, py-1.4.34, pluggy-0.4.0 -- /Users/user/anaconda/bin/python
cachedir: .cache
rootdir: /Users/user/projects/pytest/reverse_string, inifile:
collected 1 item                                                                              

example.py::test_reverse_string FAILED

========================================== FAILURES ==========================================
____________________________________ test_reverse_string _____________________________________

    def test_reverse_string():
        assert reverse_string('foobar!') == '!raboof'
>       assert reverse_string('desserts') == 'stressed'
E       AssertionError: assert '!raboof' == 'stressed'
E         - !raboof
E         + stressed

example.py:7: AssertionError
================================== 1 failed in 0.05 seconds ==================================
$ 
```

After some searching, we find a solution for reversing a string in
a general way. Here from the "Python Cookbook":

```python
def reverse_string(s):
    """
    Reverses order or characters in string s.
    """
    revchars = list(s)
    revchars.reverse()
    revchars = ''.join(revchars)
    return revchars

def test_reverse_string():
    assert reverse_string('foobar!') == '!raboof'
    assert reverse_string('desserts') == 'stressed'
```

Now we have a code that reverses a general string. Our tests pass:

```shell
$ py.test -vv example.py
==================================== test session starts =====================================
platform darwin -- Python 2.7.14, pytest-3.2.1, py-1.4.34, pluggy-0.4.0 -- /Users/user/anaconda/bin/python
cachedir: .cache
rootdir: /Users/user/projects/pytest/reverse_string, inifile:
collected 1 item                                                                              

example.py::test_reverse_string PASSED

================================== 1 passed in 0.01 seconds ==================================
$ 
```

We learn (from our nearest neighbour, perhaps) that there is a simpler
way to do it, just return $s[::-1]$. We refactor the code:

```python
def reverse_string(s):
    """
    Reverses order or characters in string s.
    """
    return s[::-1]

def test_reverse_string():
    assert reverse_string('foobar!') == '!raboof'
    assert reverse_string('desserts') == 'stressed'
```

Our tests pass:

```shell
$ py.test -vv example.py
==================================== test session starts =====================================
platform darwin -- Python 2.7.14, pytest-3.2.1, py-1.4.34, pluggy-0.4.0 -- /Users/user/anaconda/bin/python
cachedir: .cache
rootdir: /Users/user/projects/pytest/reverse_string, inifile:
collected 1 item                                                                              

example.py::test_reverse_string PASSED

================================== 1 passed in 0.01 seconds ==================================
$ 
```

What we have seen here is the essentials of Test-Driven-Development:
 - incrementalism
 - using tests to tests to describe behaviour
 - keeping it simple
 - sticking to a cycle (= getting green on red)
 - once we meet the specification, can we simplify(=refactor)?

There is still one function remaining. See if you can use this stepwise
process to implement reverse_words():

```python
def reverse_string(s):
    """
    Reverses order or characters in string s.
    """
    return s[::-1]

def test_reverse_string():
    assert reverse_string('foobar!') == '!raboof'
    assert reverse_string('desserts') == 'stressed'

def reverse_words(s):
    """
    Reverses order or words in string s.
    """
    return s

def test_reverse_words():
    assert reverse_words('dogs hate cats') == 'cats hate dogs'
#    assert reverse_words('dog eat dog') == 'dog eat dog'
#    assert reverse_words('one two three four') == 'four three two one'

```

Now we are back in red again, as tests break:

```shell
$ py.test -vv example.py
==================================== test session starts =====================================
platform darwin -- Python 2.7.14, pytest-3.2.1, py-1.4.34, pluggy-0.4.0 -- /Users/user/anaconda/bin/python
cachedir: .cache
rootdir: /Users/user/projects/pytest/reverse_string, inifile:
collected 2 items                                                                             

example.py::test_reverse_string PASSED
example.py::test_reverse_words FAILED

========================================== FAILURES ==========================================
_____________________________________ test_reverse_words _____________________________________

    def test_reverse_words():
>       assert reverse_words('dogs hate cats') == 'cats hate dogs'
E       AssertionError: assert 'dogs hate cats' == 'cats hate dogs'
E         - dogs hate cats
E         + cats hate dogs

example.py:18: AssertionError
============================= 1 failed, 1 passed in 0.05 seconds =============================
$

```

Here is code which includes a reverse_words() which reverse words
in strings in general way:

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

Let us try to test it with pytest:

```shell
$ py.test -vv example.py
==================================== test session starts =====================================
platform darwin -- Python 2.7.14, pytest-3.2.1, py-1.4.34, pluggy-0.4.0 -- /Users/user/anaconda/bin/python
cachedir: .cache
rootdir: /Users/user/projects/pytest/reverse_string, inifile:
collected 2 items                                                                             

example.py::test_reverse_string PASSED
example.py::test_reverse_words PASSED

================================== 2 passed in 0.01 seconds ==================================
$  
```

Yay! All tests passed!

Note how the code becomes more understandable as we state what we expect
from these functions.

With Test-Driven-Developement code grows increment by increment. We make
progess in small steps. The expected functionality gets documented underway
due to the tests we make beforehand.

---

## Note to Fortran developers

Personal recommendation:

- Compile the Fortran code to a dynamic library with C interface using `iso_c_binding`
- Document your API in a C header file
- Use Python [CFFI](http://cffi.readthedocs.io) to create a Python module from your C header file and dynamic library
- Test your Fortran code with [pytest](http://doc.pytest.org)
- Since the library is dynamically linked, you do not need to recompile when designing tests
- [Example: Implementing context-aware APIs in different languages](https://github.com/bast/context-api-example)
