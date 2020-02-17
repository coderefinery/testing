---
layout: episode
title: "Exercise: Automatic testing with Travis CI"
teaching: 0
exercises: 40
questions:
  - "How can we implement automatic testing each time we push changes to the repository?"
  - "Why is it good to autoclose issues with commit messages?"
objectives:
  - "Get comfortable with Travis and experience a full-cycle collaborative workflow."
keypoints:
  - "To enable automated testing on Travis, simply enable the repository and 
    add a `.travis.yml` file"
  - "When fixing bugs or other problems reported in issues, use the issue 
    autoclosing mechanism when you send the pull request"
---

## Type-along: a full-cycle collaborative workflow

We will do this exercise in pairs.

In this exercise, both partners make a repository on Github and set up
code and tests within it.  The repository is linked to Travis for
automated testing.  Both partners find a bug in their repository, make
an issue, clone each other's repos, fixes the bug, makes a pull
request, checks the automated tests on Github, and merge their
partner's change.

Here is an overview of this exercise. Below we detail the steps.

<img src="{{ site.baseurl }}/img/exercise.svg"/>


### Step 1: Create a new repository on GitHub

- Select a **different repository name** than your partner (otherwise forking the same name will be strange)
- **Before** you create the repository, select **"Initialize this repository with a README"** (otherwise you try to clone an empty repo)


### Step 2: Enable this repository on [Travis CI](https://travis-ci.org)

On [Travis CI](https://travis-ci.org):

- Use "Sign in with GitHub"
- Enable the newly created repository for testing (you may need to "Sync account" if you do not see it there)


### Step 3: Clone the repository, add sources, commit, and push

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

Add a file `.travis.yml` (mind the "." at the beginning) containing:

```yaml
sudo: false

language:
  - python

python:
  - 2.7
  - 3.6

install:
  - pip install pytest

script:
  - pytest --verbose example.py

notifications:
  email: false
```

Test `example.py` with `pytest`.

Then `git add` the two files, commit, and push the changes to GitHub.


### Step 4: Verify that tests have been automatically run

After you have pushed, go to [https://travis-ci.org](https://travis-ci.org) and
verify that Travis automatically picked up the change to the repository and ran
the tests.  It should take less than 1 minute for the test set to run.  Also
click on one of the python versions on Travis to see the full output.

If you forgot to enable Travis before pushing, you may have to tell
Travis to run the test manually.

### Step 5: Add a test which reveals a problem

For this uncomment the code under "step 5", commit, and push.
Verify on Travis that the test suite now fails.


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

And wait for your partner to do the same.
Then before accepting the pull request from your partner, observe
how Travis automatically tested the code.


### Step 10: Accept the pull request

Observe how accepting the pull request automatically closes the issue (provided
the commit message contained the correct issue number).

Discuss whether this is a useful feature. And if it is, why do you think is it useful?


### Step 11: Discussion

We discuss together about our experiences with this exercise.

---

## Where to go from here

- This example was using Python but you can achieve the same automation for Fortran or C or C++
- On Travis you can also test macOS builds: https://docs.travis-ci.com/user/reference/osx/
- On GitLab use [GitLab CI](https://about.gitlab.com/product/continuous-integration/)
- For Windows builds use [Appveyor](https://www.appveyor.com)
