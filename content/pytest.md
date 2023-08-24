# Testing locally

```{questions}
- How hard is it to implement a test suite using pytest?
```


## Exercise [pytest](http://doc.pytest.org)

In this exercise we will make a simple Python function and use
[pytest](http://doc.pytest.org) to test it.

* This is easy to use by almost any Python project and doesn't rely on any
  other servers or services.  Similar things exist in other languages.
* The downside is that you have to remember to run it yourself.

We will try to
keep things simple so that those who do not use Python can follow.

````{challenge} Local-1: Create a minimal Pytest example (15 min)
In this exercise, we will create a minimal example using
the [pytest](http://doc.pytest.org), run the test, and show what
happens when a test breaks.


1. Create a new directory and change into it:
   ```console
   $ mkdir pytest-example
   $ cd pytest-example
   ```

2. Then create a file called `example.py` and copy-paste the following code into it:
   ```python
   def add(a, b):
       return a + b


   def test_add():
       assert add(2, 3) == 5
       assert add('space', 'ship') == 'spaceship'
   ```
   This code contains one genuine function and a test function.
   `pytest` finds any functions beginning with `test_` and treats them
   as tests.

3. Let us try to test it with pytest:
   ```console
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

   Hint for participants trying this inside Spyder or IPython: try `!pytest -v example.py`.

4. Let us break the test!
   Introduce a code change which breaks the code and check
   whether pytest detects the change:
   ```console
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
   Notice how pytest is smart and includes context: lines that failed,
   values of the relevant variables.

````

````{challenge} (optional) Local-2: Create a test that considers numerical tolerance (10 min)
Let's see an example where the test has to be more clever in order to
avoid false negative.

In the above exercise we have compared integers.  In this optional exercise we
want to learn how to compare floating point numbers since they are more tricky
(see also ["What Every Programmer Should Know About Floating-Point Arithmetic"](https://floating-point-gui.de/)).

The following test will fail and this might be surprising. Try it out:
   ```python
   def add(a, b):
       return a + b


   def test_add():
       assert add(0.1, 0.2) == 0.3
   ```

Your goal: find a more robust way to test this addition.
````

````{solution} Solution: Local-2
One solution is to use
[pytest.approx](https://docs.pytest.org/en/4.6.x/reference.html#pytest-approx):
```python
from pytest import approx

def add(a, b):
    return a + b

def test_add():
    assert add(0.1, 0.2) == approx(0.3)
```

But maybe you didn't know about
[pytest.approx](https://docs.pytest.org/en/4.6.x/reference.html#pytest-approx):
and did this instead:
```python
def test_add():
    result = add(0.1, 0.2)
    assert abs(result - 0.3) < 1.0e-7
```
This is OK but the `1.0e-7` can be a bit arbitrary.
````


## Exercise end-to-end test (advanced)

If you have spare time, you can work on this.  It isn't required for
anything else.  It counts as a bit advanced, because you are writing
one program to run another program and check it's output.  This isn't
necessarily hard, but it is different from what most people do!

````{exercise} Local-3: Create an end-to-end test (advanced, optional)

Often, you can include tests that run your whole workflow or program.
For example, you might include sample data and check the output
against what you expect.  (including sample data is a great idea
anyway, so this helps a lot!)

We'll use the word-count example repository
<https://github.com/coderefinery/word-count>, as used in [the
Documentation
lesson](https://coderefinery.github.io/reproducible-research/workflow-management/).

As a reminder, you can run the script like this to get some output,
which prints to standard output (the terminal):

```console
$ python3 statistics/count.py data/abyss.txt
```

Your goal is to make a test that can run this and let you know if it's
successful or not.  You could use Python, or you could use shell
scripting.  You can test if these two lines are in the output: `the
4044` and `and 2807`.

Python hint:
[subprocess.check_output](https://docs.python.org/3/library/subprocess.html#subprocess.check_output)
will run a command and return its output as a string.

Bash hint: `COMMAND | grep "PATTERN"` ("pipe to grep") will be true if
the pattern is in the command.

````

````{solution} Solution: Local-3
There are two solutions in the repository already, in the `tests/`
dierectory <https://github.com/coderefinery/word-count>, one in Python
and one in bash shell.  Neither of these are a very advanced or
perfect solution, and you could integrate them with pytest or whatever
other test framework you use.

The shell one works with shell and prints a bit more output:

```console
$ sh tests/end-to-end-shell.sh
the 4044
Success: 'the' found correct number of times
and 2807
Success: 'and' found correct number of times
Success
```

The Python one:
```console
$ python3 tests/end-to-end-python.py
Success
```

````


## Spare time?

We give a lot of time here, since it can be tricky for some people.
If you have more time, try looking at {doc}`test-design` - there are
many more tests to start writing there, and you now know enough to do
that.

We'll discuss these in more detail later.


## Summary

* Local testing can be very easy.
* Even simple tests can provide checks for obviously breaking things.



```{keypoints}
- pytest collects and runs all test functions starting with
  `test_`. If run on a directory, it collects all files matching `test_*.py`
- Python and C/C++ have better tooling for automated tests than Fortran and you can use those also for Fortran projects (via `iso_c_binding`).
```
