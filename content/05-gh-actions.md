# Automatic testing with GitHub Actions

```{questions}
- How can we implement automatic testing each time we push changes to the repository?
- Why is it good to autoclose issues with commit messages?
```


## Exercise a full-cycle collaborative workflow

```{challenge} Exercise overview
We will do this exercise in a collaborative circle within the exercise group
(breakout room).

The exercise takes 20-30 minutes.

In this exercise, everybody will:
- Create a repository on Github (everybody should use a **different name** for their repository)
- Commit code to the repository and set up tests with GitHub Actions
- Everybody will find a bug in their repository and open an issue in their repository
- Then each one will clone the repo of one of their exercise partners, fix the bug, and open a pull request
- Everybody then merges their co-worker's change
```

```{figure} img/testing_group_work.png
:alt: Graph with exercise steps
:width: 300px

Overview of this exercise. Below we detail the steps.
```


### Step 1: Create a new repository on GitHub

- Select a **different repository name** than your colleagues (otherwise forking the same name will be strange)
- **Before** you create the repository, select **"Initialize this repository with a README"** (otherwise you try to clone an empty repo).
- Share the repository URL with your exercise group via shared document or chat


### Step 2: Clone your own repository, add code, commit, and push

Clone the repository.

Add a file `example.py` containing:

```python
def add(a, b):
    return a + b


def test_add():
    assert add(2, 3) == 5
    assert add('space', 'ship') == 'spaceship'


def subtract(a, b):
    return a + b  # <--- fix this in step 8


# uncomment the following test in step 5
#def test_subtract():
#    assert subtract(2, 3) == -1
```
Test `example.py` with `pytest`.

Then `git add` the file, commit, and push the changes to GitHub.


### Step 3: Enable GitHub Actions

Select "Actions" from your GitHub repository page. You get to a page
"Get started with GitHub Actions". Select the button for "Set up
this workflow" under Python Application:

```{figure} img/python_application.png
:alt: Selecting a Python workflow
```

GitHub creates the following file for you in the subfolder `.github/workflows`.
Add `pytest example.py` to the last line (highlighted):

```{code-block} yaml
---
emphasize-lines: 34-36
---
# This workflow will install Python dependencies, run tests and lint with a single version of Python
# For more information see: https://help.github.com/actions/language-and-framework-guides/using-python-with-github-actions

name: Python application

on:
  push:
    branches: [ master ]
  pull_request:
    branches: [ master ]

jobs:
  build:

    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v2
    - name: Set up Python 3.8
      uses: actions/setup-python@v2
      with:
        python-version: 3.8
    - name: Install dependencies
      run: |
        python -m pip install --upgrade pip
        pip install flake8 pytest
        if [ -f requirements.txt ]; then pip install -r requirements.txt; fi
    - name: Lint with flake8
      run: |
        # stop the build if there are Python syntax errors or undefined names
        flake8 . --count --select=E9,F63,F7,F82 --show-source --statistics
        # exit-zero treats all errors as warnings. The GitHub editor is 127 chars wide
        flake8 . --count --exit-zero --max-complexity=10 --max-line-length=127 --statistics
    - name: Test with pytest
      run: |
        pytest example.py
```

Commit the change by pressing the "Start Commit" button:

```{figure} img/gh_action_commit.png
:alt: Committing the change
:width: 400px
```


### Step 4: Verify that tests have been automatically run

Observe in the repository how the test succeed. While the test is
executed, the repository has yellow marker. This is replaced with a green
check mark, once the test succeeds:

```{figure} img/green_check_mark.png
:alt: Verify that the test passed
```

Also browse the "Actions" tab and look at the steps there and their output.


### Step 5: Add a test which reveals a problem

After you committed the workflow file, your GitHub repository will be ahead of
your local cloned repository.  Update your local cloned repository:

```bash
$ git pull origin master
```

Next uncomment the code in `example.py` under "step 5", commit, and push.
Verify that the test suite now fails on the "Actions" tab.


### Step 6: Open an issue on GitHub

Open a new issue in your repository on the broken test on GitHub.
The plan is that your colleague will fix the issue.


### Step 7: Fork and clone the repository of your colleague

Now you know the drill.


### Step 8: Fix the broken test

After you have fixed the code,
commit the following commit message `"restore function subtract; fixes #1"` (assuming that you try to fix issue number 1).

Once the pull request is accepted/merged, this will autoclose the issue since GitHub will recognize the "fixes #1" in the commit message, see also
[closing issues using keywords](https://help.github.com/articles/closing-issues-using-keywords/).

Then push to your fork.


### Step 9: File a pull request

Then before accepting the pull request from your colleague, observe
how GitHub Actions automatically tested the code.


### Step 10: Accept the pull request

Observe how accepting the pull request automatically closes the issue (provided
the commit message contained the correct issue number).

Discuss whether this is a useful feature. And if it is, why do you think is it useful?


### Discussion

Finally, we discuss together about our experiences with this exercise.

---

## Where to go from here

- This example was using Python but you can achieve the same automation for R or Fortran or C/C++ or other languages
- GitHub Actions has a [Marketpace](https://github.com/marketplace?type=actions) which offer wide range of automatic workflows
- On [Travis](https://travis-ci.org) is an alternative service which offer much of the same
- On GitLab use [GitLab CI](https://about.gitlab.com/product/continuous-integration/)
- For Windows builds you can also use [Appveyor](https://www.appveyor.com)


```{keypoints}
- When fixing bugs or other problems reported in issues, use the issue
  autoclosing mechanism when you send the pull/merge request.
```
