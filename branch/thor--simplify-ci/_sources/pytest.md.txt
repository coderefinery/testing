# Testing locally

```{questions}
- How can we implement a test suite using pytest?
```


## Exercise [pytest](http://doc.pytest.org)

In this exercise we will make a simple Python function and use
[pytest](http://doc.pytest.org) to test it.

* This is easy to use by almost any project and doesn't rely on any
  other servers or services.
* The downside is that you have to remember to run it yourself.

We will try to
keep things simple so that those who do not use Python can follow.

````{challenge} Exercise: 15 min
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

   Hint for participants trying this inside Spyder or IPython: try `!pytest -v example.py`.

4. Let us break the test!
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
   Notice how pytest is smart and includes context: lines that failed,
   values of the relevant variables.

````

````{challenge} Optional exercise: Testing with numerical tolerance (10 min)
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

````{solution}
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

```{keypoints}
- pytest collects and runs all test functions starting with `test_`.
- Python and C/C++ have better tooling for automated tests than Fortran and you can use those also for Fortran projects (via `iso_c_binding`).
```
