---
layout: episode
title: "Exercise: Automatic testing with Travis CI and Coveralls"
teaching: 0
exercises: 40
questions:
  - "How can we implement automatic testing each time we push changes to the repository?"
  - "Why is it good to autoclose issues with commit messages?"
objectives:
  - "Get comfortable with Travis and Coveralls and experience a full-cycle collaborative workflow."
keypoints:
  - "This example was using Python but you can achieve the same automation for Fortran or C or C++."
---

## Exercise a full-cycle collaborative workflow

We will do this exercise in pairs.

Here is an overview of this exercise. Below we detail the steps.

<img src="{{ site.baseurl }}/img/exercise.svg"/>


### Step 1: Create a new repository on GitHub

- Select a **different repository name** than your partner (otherwise forking the same name will be strange)
- **Before** you create the repository, select **"Initialize this repository with a README"** (otherwise you try to clone an empty repo)


### Step 2: Enable this repository on [Travis CI](https://travis-ci.org) and [Coveralls](https://coveralls.io)

On [Travis CI](https://travis-ci.org):

- Use "Sign in with GitHub"
- Click on the little "+" symbol
- Enable the newly created repository for testing (you may need to "Sync account" if you do not see it there)

On [Coveralls](https://coveralls.io):

- Use "GITHUB SIGN IN"
- Select "+" symbol: "ADD REPOS" ("SYNC REPOS" if it is not in the list; syncing can take a minute)
- If syncing takes forever, reload the page
- Enable the new repository


### Step 3: Clone the repository, add sources, commit, and push

Clone the repository.

Add a file `example.py` containing:

```python
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


def get_word_lengths(s):
    """
    Returns a list of integers representing
    the word lengths in string s.
    """
    # uncomment next line in step 9
#   return [len(word) for word in s.split()]
    return None


# uncomment this function in step 6
#def test_get_word_lengths():
#    text = "Three tomatoes are walking down the street"
#    assert get_word_lengths(text) == [5, 8, 3, 7, 4, 3, 6]


def obscure_function():
    """
    Example of a function that is never tested.
    """
    do_something_strange()
```

Add a file `.travis.yml` (mind the "." at the beginning) containing:

```yaml
sudo: false

language:
  - python

python:
  - 2.6
  - 2.7
  - 3.4
  - 3.5

install:
  - pip install pytest pytest-cov python-coveralls

script:
  - if [[ $TRAVIS_PYTHON_VERSION == 2.7 ]];
    then py.test -vv example.py --cov example;
    else py.test -vv example.py;
    fi

after_success:
  - if [[ $TRAVIS_PYTHON_VERSION == 2.7 ]];
    then coveralls;
    fi

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


### Step 5: Verify the test coverage

**After** Travis finished running all tests, check the coverage report on
[https://coveralls.io](https://coveralls.io).
Browse the source code there and check which lines have not been tested.


### Step 6: Add a test which will reveal an unfinished function

For this uncomment the code under "step 6", commit, and push.
Verify on Travis that the test suite now fails.


### Step 7: Open an issue on GitHub

Open a new issue on the broken test on GitHub.
The plan is that your exercise partner will fix the issue.


### Step 8: Fork and clone the repository of your exercise partner

Now you know the drill.


### Step 9: Fix the broken test

For this uncomment the code under "step 9".

Commit the following commit message "restore test_get_word_lengths; fixes #1" (assuming that you try to fix issue number 1).

This will autoclose the issue since GitHub will recognize the "fixes #1" in the commit message, see also
https://help.github.com/articles/closing-issues-using-keywords/.

Then push to your fork.


### Step 10: File a pull request

And wait for your partner to do the same.
Then before accepting the pull request from your partner, observe
how Travis automatically tested the code.


### Step 11: Accept the pull request

Observe how accepting the pull request automatically closes the issue (provided
the commit message contained the correct issue number).

Discuss whether this is a useful feature. And if it is, why do you think is it useful?


### Step 12: Discussion

We discuss together about our experiences with this exercise.

---

## Where to go from here

- On Travis you can also test macOS builds: https://docs.travis-ci.com/user/reference/osx/
- On GitLab use [GitLab CI](https://about.gitlab.com/product/continuous-integration/)
- For Windows builds use https://www.appveyor.com
