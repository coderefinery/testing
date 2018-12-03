---
layout: episode
title: "Exercise/discussion: Testing using hooks"
teaching: 0
exercises: 15
objectives:
questions:
  - "How can we use Git hooks to make sure we do not commit broken code?"
---

## Git hooks

Git hooks are scripts that we can define and which can be run when certain Git
events happen.

There are client-side hooks and server-side hooks.

Here we will use a client-side the `pre-commit` hook to run a script before a
commit is recorded.

---

## Exercise: Testing using a `pre-commit` hook

### 1. Create a new directory and step into it

### 2. Initialize an empty Git repository

```shell
$ git init
```

### 3. Create a file called `example.py`

`git add` and `git commit` this file:

```python
def add(a, b):
    return a + b


def test_add():
    assert add(2, 3) == 5
    assert add('space', 'ship') == 'spaceship'
```

### 4. Test it using pytest

```
$ pytest example.py
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
