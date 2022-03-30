# Automated testing 

```{questions}
- How can we implement automatic testing each time we push changes to the repository?
- Why is it good to autoclose issues with commit messages?
```

## Type-along exercise: Continuous integration

We will now learn to set up automatic tests using either GitHub Actions or
GitLab CI - you can choose which one to use and instructions are provided for both.

This exercise can be run in "collaborative mode" by following instead the instructions
in [Full-cycle collaborative workflow](./full-cycle-ci). In the collaborative version steps
C-D below are performed by a collaborator.


```{challenge} Exercise CI-1: Create and use a continuous integration workflow on GitHub or GitLab

In this exercise, we will:

**A.** Create a repository on GitHub/GitLab   
**B.** Commit code to the repository and set up tests with GitHub Actions/ GitLab CI  
**C.** Find a bug in our repository and open an issue to report it  
**D.** Fix the bug on a bugfix branch and open a pull request (GitHub)/ merge request (GitLab)  
**E.** Merge the pull/merge request and see how the issue is automatically closed.
```

### Prerequisites

If you are new to Git, you can find a step-by-step guide to
setting up repositories and making commits in
[this git-refresher material](https://coderefinery.github.io/git-refresher/).
If you are new to pull requests / merge requests, you can learn all about them
in the [Collaborative Git lesson](https://coderefinery.github.io/git-collaborative/).

### Step 1: Create a new repository on GitHub/GitLab

- Begin by creating a repository called (for example) *example-ci*.
- **Before** you create the repository, select **"Initialize this repository
  with a README"** (otherwise you try to clone an empty repo).

### Step 2: Clone your repository, add code, commit, and push

Clone the repository.

Add a file `example.py` containing:

```python
def add(a, b):
    return a + b


def test_add():
    assert add(2, 3) == 5
    assert add('space', 'ship') == 'spaceship'


def subtract(a, b):
    return a + b  # <--- fix this in step 7


# uncomment the following test in step 5
#def test_subtract():
#    assert subtract(2, 3) == -1
```
Test `example.py` with `pytest`.

Then stage the file (`git add <filename>`), commit (`git commit -m "some commit message"`),
and push the changes (`git push origin main`).


### Step 3: Enable automated testing

`````{tabs}
   ````{group-tab} GitHub

   In this step we will enable GitHub Actions.
   Select "Actions" from your GitHub repository page. You get to a page
   "Get started with GitHub Actions". Select the button for "Configure"
   under Python Application:

   ```{figure} img/python_application.png
   :alt: Selecting a Python workflow

   Select "Python application" as the starter workflow.
   ```

   GitHub creates the following file for you in the subfolder `.github/workflows`.
   Add `pytest example.py` to the last line (highlighted):

   ```{code-block} yaml
   ---
   emphasize-lines: 37-39
   ---
   # This workflow will install Python dependencies, run tests and lint with a single version of Python
   # For more information see: https://help.github.com/actions/language-and-framework-guides/using-python-with-github-actions

   name: Python application

   on:
     push:
       branches: [ main ]
     pull_request:
       branches: [ main ]

   permissions:
     contents: read

   jobs:
     build:

       runs-on: ubuntu-latest

       steps:
       - uses: actions/checkout@v3
       - name: Set up Python 3.10
         uses: actions/setup-python@v3
         with:
           python-version: "3.10"
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

   Committing the file via the GitHub web interface: follow the flow, give it some commit name. You can commit directly to master.
   ```
   ````

   ````{group-tab} GitLab

   In this step we will enable GitLab CI.
   Select "CI/CD" from your Gitlab sidebar of the project. You get to a page
   "Editor". (Instead you can also click on "Add CI/CD" on the main page or just add a `.gitlab-ci.yml` file the result is identical.

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

   Committing the file via the GitLab web interface: follow the flow, give it some commit name. You can commit directly to master.
   ```
   ````
`````


### Step 4: Verify that tests have been automatically run

`````{tabs}
   ````{group-tab} GitHub

   Observe in the repository how the test succeeds. While the test is
   executing, the repository has a yellow marker. This is replaced with a green
   check mark, once the test succeeds:

   ```{figure} img/green_check_mark.png
   :alt: Verify that the test passed

   Green check means passed.
   ```

   Also browse the "Actions" tab and look at the steps there and their output.
   ````

   ````{group-tab} GitLab

   Observe in the repository how the test succeeds. While the test is
   executing, the repository has a blue marker. This is replaced with a green
   check mark, once the test succeeds:

   ```{figure} img/gl_green_check_mark.png
   :alt: Verify that the test passed

   Green check means passed.
   ```

   Also browse the "Pipelines" tab and look at the steps there and their output.
   ````
`````


### Step 5: Add a test which reveals a problem

After you committed the workflow file, your GitHub/GitLab repository will be ahead of
your local cloned repository.  Update your local cloned repository:

```bash
$ git pull origin main
```

Hint: if the above command fails, check whether the branch name on the GitHub/GitLab
repository is called `main` and not perhaps `master`.

Next uncomment the code in `example.py` under "step 5", commit, and push.
Verify that the test suite now fails on the "Actions" tab (GitHub)
or the "CI/CD->Pipelines" tab (GitLab).


### Step 6: Open an issue on GitHub/GitLab

Open a new issue in your repository about the broken test (click the
"Issues" button on GitHub or GitLab and write a title for the issue).
The plan is that we will fix the issue through a pull/merge request.


### Step 7: Fix the broken test

Now fix the code **on a new branch**, you can call it `yourname/bugfix`.
After you have fixed the code on the new branch, commit the following
commit message `"restore function subtract; fixes #1"` (assuming that
you try to fix issue number 1).

```{callout} Shortcut

   Here it's perfectly possible to take a shortcut and commit and push
   directly to the main branch. If you do this, steps 8-9 below are skipped.  
   - When would you push directly to the main branch, and when would you send a
   pull/merge request?
```   
   

Then push to your repository.


### Step 8: Open a pull request (GitHub)/ merge request (GitLab)

Go back to the repository on GitHub or GitLab and open a pull/merge
request. **In a collaborative setting, you could request a code
review from collaborators at this stage.** Before accepting the
pull/merge request, observe how GitHub Actions/ Gitlab CI
automatically tested the code.

If you forgot to reference the issue number in the commit message, you
can still add it to the pull/merge request: `my pull/merge request
title, closes #1`.


### Step 9: Accept the pull/merge request

Observe how accepting the pull/merge request automatically closes the issue (provided
the commit message or the pull/merge request contained the correct issue number).

See also:
- GitHub: [closing issues using keywords](https://help.github.com/articles/closing-issues-using-keywords/)
- GitLab: [closing issues using keywords](https://docs.gitlab.com/ee/user/project/issues/managing_issues.html#closing-issues)

Discuss whether this is a useful feature. And if it is, why do you think is it useful?


### Discussion

Finally, we discuss together about our experiences with this exercise.

---

## Where to go from here

- This example was using Python but you can achieve the same automation for R or Fortran or C/C++ or other languages
- This workflow is very useful for collaborators who work on the same code and it works both for
  [centralized](https://coderefinery.github.io/git-collaborative/02-centralized/) and
  [forking](https://coderefinery.github.io/git-collaborative/03-distributed/) workflows - have a look at this
  [alternative exercise](./full-cycle-ci) to see how that works.
- GitHub Actions has a [Marketpace](https://github.com/marketplace?type=actions) which offer wide range of automatic workflows
- On GitLab use [GitLab CI](https://about.gitlab.com/product/continuous-integration/)
- For Windows builds you can also use [Appveyor](https://www.appveyor.com)


```{keypoints}
- When fixing bugs or other problems reported in issues, use the issue
  autoclosing mechanism when you send the pull/merge request.
```
