---
layout: episode
title: "Exercise/discussion: Testing using hooks"
teaching: 0
exercises: 15
objectives:
  - "Learn to write a Git hook to automatize testing."
questions:
  - "How can we use Git hooks to make sure we do not commit broken code?"
keypoints:
  - "Git hooks provide a convenient way to *locally* automatize tests."
---

## Git hooks

**Git hooks** are scripts that we can define and which can be run when certain Git
events happen.  They can, for example, run tests before a commit and
reject if it fails.

There are **client-side hooks** (run on your own computer when
committing) and **server-side hooks** (run on server after pushing,
usually used to test if merging is okay).

---

## Type-along: Testing using a `pre-commit` hook

Here we will use our previous `example.py` and add a git client-side hook the `pre-commit` hook to run a script before a
commit is recorded.


### 1. The starting point is our `example.py` file

We are still in the directory `pytest-example` which
contains `example.py`:

```python
def add(a, b):
    return a + b


def test_add():
    assert add(2, 3) == 5
    assert add('space', 'ship') == 'spaceship'
```


### 2. Make sure the test passes

```shell
$ pytest example.py
```


### 3. Initialize a Git repository

```shell
$ git init
```


### 4. Git add and commit the file

```shell
$ git add example.py
$ git commit
```

### 5. Create the following shell script

Save this file as `pre-commit`:

```shell
#!/bin/bash

pytest example.py
```

### 6. Make `pre-commit` executable

```shell
$ chmod +x pre-commit
```

### 7. Move this file under .git/hooks

```shell
$ mv pre-commit .git/hooks
```

### 8. Break the code and try to commit this change

Now the `pre-commit` should reject the commit.


### 9. Discuss

Discuss this approach: pros and cons.
