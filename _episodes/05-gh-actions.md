---
layout: episode
title: "Exercise: Automatic testing with GitHub Actions"
teaching: 10
exercises: 30
questions:
  - "How can we implement automatic testing each time we push changes to the repository?"
  - "Why is it good to autoclose issues with commit messages?"
objectives:
  - "Get comfortable with GitHub Actions and experience a full-cycle collaborative workflow."
keypoints:
  - "When fixing bugs or other problems reported in issues, use the issue 
    autoclosing mechanism when you send the pull request"
---

##  Exercise a full-cycle collaborative workflow

We will do this exercise in collaborative circle within the group
(breakout room).

In this exercise, all make a repository on Github and set up
code and tests through GitHub actions within it.  Everybody find a bug in their repository, make
an issue in their own repository. The each one  clone one of the other's repos, fixes the bug, makes a pull
request, checks the automated tests on Github, and everybody merge their co-workers's change.

Here is an overview of this exercise. Below we detail the steps.

<img src="{{ site.baseurl }}/img/exercise.svg"/>


### Step 1: Create a new repository on GitHub

- Select a **different repository name** than your partner (otherwise forking the same name will be strange)
- **Before** you create the repository, select **"Initialize this repository with a README"** (otherwise you try to clone an empty repo)


### Step 2: Clone the repository, add sources, commit, and push

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

Then `git add` the two files, commit, and push the changes to GitHub.

### Step 3: Enable GitHub Actions
Select "Actions" from your GitHub repository page. You get at paged with
title "Get started with GitHub Actions". Select the button for "Set up
this workflow" under Python Application:
<img src="{{ site.baseurl }}/img/python_application.png"/>

GitHub creates a subdirectory `.github/workflows` with at YAML. Add
`example.py` to the last line with the `pytest` command:
```YAML
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

Do the commit by pressing  the "Start Commit" button.
<img src="{{ site.baseurl}}/img/gh_action_commit.png"/>

### Step 4: Verify that tests have been automatically run

Observe in the repository how the test succeed. While it the test is
done, the repository has yellow marker. This is replaced with a green
check mark, once the test succeeds:
<img src="{{ site.baseurl}}/img/green_check_mark.png"/>

### Step 5: Add a test which reveals a problem

Update your local cloned repository by doing a `git pull` or `git fetch`
followed by a `git merge orgin/master`. Nexy uncomment the code under "step 5", commit, and push.
Verify that the test suite now fails, by selecting the yellow mark at
"Latest commit".
<img src="{{ site.baseurl}}/img/test_failed.png"/>



### Step 6: Open an issue on GitHub

Open a new issue on the broken test on GitHub.
The plan is that your exercise partner will fix the issue.


### Step 7: Fork and clone the repository of your exercise partner

Now you know the drill.


### Step 8: Fix the broken test

After you have fixed the code,
commit the following commit message `"restore function subtract; fixes #1"` (assuming that you try to fix issue number 1).

Once the pull request is accepted/merged, this will autoclose the issue since GitHub will recognize the "fixes #1" in the commit message, see also
[closing issues using keywords](https://help.github.com/articles/closing-issues-using-keywords/).

Then push to your fork.


### Step 9: File a pull request

Then before accepting the pull request from your partner, observe
how GitHub Actions automatically tested the code.


### Step 10: Accept the pull request

Observe how accepting the pull request automatically closes the issue (provided
the commit message contained the correct issue number).

Discuss whether this is a useful feature. And if it is, why do you think is it useful?


### Step 11: Discussion

We discuss together about our experiences with this exercise.

---
{: .challenge}

## Where to go from here

- This example was using Python but you can achieve the same automation for Fortran or C or C++
- GitHub Actions has a [Marketpace](https://github.com/marketplace?type=actions) which offer wide range of automatic workflows
- On [Travis](https://travis-ci.org) is an alternative service which offer much of the same
- On GitLab use [GitLab CI](https://about.gitlab.com/product/continuous-integration/)
- For Windows builds use [Appveyor](https://www.appveyor.com)
