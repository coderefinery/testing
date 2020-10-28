# Testing locally

```{questions}
- How can we implement a test suite using pytest?
- I am a Fortran developer, do I need to care about pytest?
- How can we use Git hooks to make sure we do not commit broken code?
```


## Exercise [pytest](http://doc.pytest.org)

In this exercise we will make a simple Python function and use
[pytest](http://doc.pytest.org) to test it. We will try to
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
````

---

## Exercise using a pre-commit hook

**Git hooks** are scripts that we can define and which can be run when certain Git
events happen.  They can, for example, run tests before a commit and
reject if it fails.

There are **client-side hooks** (run on your own computer when
committing) and **server-side hooks** (run on server after pushing,
usually used to test if merging is okay).


````{discussion} Demonstration
Here we will use our previous `example.py` and add a git client-side hook the
`pre-commit` hook to run a script before a commit is recorded.

**Instructor demonstrates** this example (the reason is that we are unsure
whether this works 100% on Windows):

1. The starting point is our `example.py` file.  We are still in the
  directory `pytest-example` which contains `example.py`:
   ```python
   def add(a, b):
       return a + b


   def test_add():
       assert add(2, 3) == 5
       assert add('space', 'ship') == 'spaceship'
   ```
2. Make sure the test passes:
   ```console
   $ pytest example.py
   ```
3. Initialize a Git repository:
   ```console
   $ git init
   ```
4. Git add and commit the file:
   ```console
   $ git add example.py
   $ git commit
   ```
5. Create the following shell script:
      `````{tabs}
         ````{group-tab} Bash, Linux or macOS

         Save the file as `pre-commit`
         ````
         ````{group-tab} Windows Anaconda prompt

         Save the file as `pre-commit.bat`
         ````
      `````

   The script is the same for all operating systems:
   ```shell
   #!/bin/bash

   pytest example.py
   ```
6. Make the script executable:
      `````{tabs}
         ````{group-tab} Bash, Linux or macOS

            ```console
            $ chmod +x pre-commit
            ```
         ````
         ````{group-tab} Windows Anaconda prompt

            Nothing to do.
         ````
      `````
7. Check the hook script:
      `````{tabs}
         ````{group-tab} Bash, Linux or macOS

            ```console
            $ ./pre-commit
            ```
         ````
         ````{group-tab} Windows Anaconda prompt

            ```console
            $ ./pre-commit.bat
            ```
         ````
      `````
8. Move this file under .git/hooks:
      `````{tabs}
         ````{group-tab} Bash, Linux or macOS

            ```console
            $ mv pre-commit .git/hooks
            ```
         ````
         ````{group-tab} Windows Anaconda prompt

            ```console
            $ move pre-commit.bat .git/hooks
            ```
         ````
      `````
9. Break the code and try to commit this change.
   Now the `pre-commit` should reject the commit.
10. Discuss this approach: pros and cons.
````

```{keypoints}
- pytest collects and runs all test functions starting with `test_`.
- Python and C/C++ have better tooling for automated tests than Fortran and you can use those also for Fortran projects (via `iso_c_binding`).
- Git hooks provide a convenient way to *locally* automatize tests.
```
