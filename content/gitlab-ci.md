# Automatic testing with GitLab CI

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
- Create a repository on Gitlab (everybody should use a **different repository name** for their repository)
- Commit code to the repository and set up tests with Gitlab Ci
- Everybody will find a bug in their repository and open an issue in their repository
- Then each one will clone the repo of one of their exercise partners, fix the bug, and open a merge request
- Everybody then merges their co-worker's change
```

```{figure} img/testing_group_work.png
:alt: Graph with exercise steps
:width: 300px

Overview of this exercise. Below we detail the steps.
```


### Step 1: Create a new repository on GitLab

- Select a **different repository name** than your colleagues (otherwise forking the same name will be strange)
- **Before** you create the repository, select **"Initialize this repository
  with a README"** (otherwise you try to clone an empty repo).
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

Then `git add` the file, commit, and push the changes to Gitlab.


### Step 3: Enable Gitlab-Ci

Select "CI/CD" from your Gitlab repository page. You get to a page
"Editor". 

Copy the following code snippet into the file. Gitlab will save it as `.gitlab-ci.yml`.
Add `pytest example.py` to the last line (highlighted):

```{code-block} yaml
---
emphasize-lines: 22
---
# This workflow will install Python dependencies, run tests and lint with a single version of Python
# For more information see: https://gitlab.com/gitlab-org/gitlab/-/blob/master/lib/gitlab/ci/templates/Python.gitlab-ci.yml

image: python:latest
stages:
  - linting
  - test
before_script:
  - cat /proc/version #print out operations system
  - python -V  # Print out python version for debugging
  - pip install pytest flake8
  - if [ -f requirements.txt ]; then pip install -r requirements.txt;fi

linting:
  stage: linting
  script:
    - flake8 . --count --select=E9,F63,F7,F82 --show-source --statistics
    - flake8 . --count --exit-zero --max-complexity=10 --max-line-length=127 --statistics

test:
  stage: test
  script: 
    - pytest example.py

```

Commit the change by pressing the "Commit changes" button:

```{figure} img/gl_action_commit.png
:alt: Committing the change
:width: 400px

Committing the file via the Gitlab web interface: follow the flow, give it some commit name.  You can commit directly to master.
```


### Step 4: Verify that tests have been automatically run

Observe in the repository how the test succeeds. While the test is
executing, the repository has a blue marker. This is replaced with a green
check mark, once the test succeeds:

```{figure} img/gl_green_check_mark.png
:alt: Verify that the test passed

Green check means passed.
```

Also browse the "Pipelines" tab and look at the steps there and their output.


### Step 5: Add a test which reveals a problem

After you committed the workflow file, your Gitlab repository will be ahead of
your local cloned repository.  Update your local cloned repository:

```bash
$ git pull origin main
```

Next uncomment the code in `example.py` under "step 5", commit, and push.
Verify that the test suite now fails on the "Actions" tab.


### Step 6: Open an issue on Gitlab

Open a new issue in your repository on the broken test on Gitlab.
The plan is that your colleague will fix the issue.


### Step 7: Fork and clone the repository of your colleague

Fork the repository using the Gitlab web interface. Make sure you clone the
fork after you have forked it. Do not clone your colleague's repository
directly.

```bash
$ git clone https://gitlab.com/your-username/the-repository.git
```


### Step 8: Fix the broken test

After you have fixed the code,
commit the following commit message `"restore function subtract; fixes #1"` (assuming that you try to fix issue number 1).

Then push to your fork.


### Step 9: Open a merge request

Then before accepting the merge request from your colleague, observe
how Gitlab-CI automatically tested the code. Add a description to the merge request with a 
"Closes #NUMBEROFYOURISSUE".


### Step 10: Accept the merge request

Observe how accepting the merge request automatically closes the issue (provided
the merge request message contained the correct issue number).

See also
[closing issues using keywords](https://docs.gitlab.com/ee/user/project/issues/managing_issues.html#closing-issues).

Discuss whether this is a useful feature. And if it is, why do you think is it useful?


### Discussion

Finally, we discuss together about our experiences with this exercise.


```{challenge} Optional exercise
In the [Social coding and open software](https://cicero.xyz/v3/remark/0.14.0/github.com/coderefinery/social-coding/master/talk.md/)
lesson we learn how important it is to add a LICENSE file.

Your goal:
- You discover that your coworker's repository does not have a LICENSE file.
- Open an issue and suggest a LICENSE.
- Then add a LICENSE via a pull/merge request, referencing the issue number.
```

---

## Where to go from here

- This example was using Python but you can achieve the same automation for R or Fortran or C/C++ or other languages
- GitHub Actions has a [Marketpace](https://github.com/marketplace?type=actions) which offer wide range of automatic workflows
- Check out the [tutorial](https://coderefinery.github.io/testing/gh-actions/) about GitHub Actions
- For Windows builds you can also use [Appveyor](https://www.appveyor.com)


```{keypoints}
- When fixing bugs or other problems reported in issues, use the issue
  autoclosing mechanism when you send the pull/merge request.
```
