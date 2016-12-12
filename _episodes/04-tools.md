---
layout: episode
title: "Tools"
teaching: 15
exercises: 0
questions:
  - "What tools are out there?"
objectives:
  - "Write me"
keypoints:
  - "Write me"
---

## Unit test frameworks

- Python
    - py.test
    - nose
    - doctest
    - unittest

- C(++)
    - Google Test
    - CppUnit
    - Boost.Test
    - UnitTest++
    - https://github.com/philsquared/Catch

- Fortran
    - pFUnit
    - Fruit

---

## py.test

- Very easy to set up

```shell
$ pip install pytest  # ideally into a virtualenv
```

- Very easy to use

```python
def get_word_lengths(s):
    """
    Returns a list of integers representing
    the word lengths in string s.
    """
    return [len(w) for w in s.split()]

def test_get_word_lengths():
    text = "Three tomatoes are walking down the street"
    assert get_word_lengths(text) == [5, 8, 3, 7, 4, 3, 6]
```

- Example output: https://travis-ci.org/bast/pytest-demo/builds/104182942
- Example project: https://github.com/bast/pytest-demo

---

## Google Test

- Widely used
- Very rich in functionality
- Source: https://github.com/google/googletest

```cpp
#include "gtest/gtest.h"
#include "example.h"

TEST(example, add)
{
    double res;
    res = add_numbers(1.0, 2.0);
    ASSERT_NEAR(res, 3.0, 1.0e-11);
}
```

- Example output: https://travis-ci.org/bast/gtest-demo/builds/104190982
- Example project: https://github.com/bast/gtest-demo

---

## pFUnit

- Very rich in functionality
- Source: http://pfunit.sourceforge.net
- Requires modern Fortran compilers (uses F2003 standard)

```fortran
@test
subroutine test_add_numbers()

   use hello
   use pfunit_mod

   implicit none

   real(8) :: res

   call add_numbers(1.0d0, 2.0d0, res)
   @assertEqual(res, 3.0d0)

end subroutine
```

- Example output: https://travis-ci.org/bast/pfunit-demo/builds/104193675
- Example project: https://github.com/bast/pfunit-demo

---

## CTest and CDash

- CTest runs a set of tests through bash/perl/python scripts and reports to CDash which aggregates results
- The test scripts can be anything you like

```shell
add_test(my_test_name ${PROJECT_BINARY_DIR}/my_test_script --flags)

include(CTest)
enable_testing()
```

- CTest looks for the return codes: 0/non-0 (success/failure)
- CTest is a powerful test runner, no need to implement one
- Reporting to CDash is easy

```shell
$ make Nightly
```

- CDash example: https://testboard.org

---

## Fun: Jenkins Chuck Norris plugin

https://wiki.jenkins-ci.org/display/JENKINS/ChuckNorris+Plugin

<img src="{{ site.baseurl }}/img/chucknorris_badass.jpg" style="width: 350px;"/>
<img src="{{ site.baseurl }}/img/chucknorris_thumbup.jpg" style="width: 350px;"/>

---

## Fun: Jenkins "Extreme Feedback" Contraption

https://github.com/codedance/Retaliation

"Retaliation is a Jenkins CI build monitor that automatically coordinates a foam missile counter-attack against the developer who breaks the build. It does
this by playing a pre-programmed control sequence to a USB Foam Missile Launcher to target the offending code monkey."

<img src="{{ site.baseurl }}/img/launcher.jpg" style="width: 400px;"/>

---

## Travis and Coveralls

- GitHub plus Travis plus Coveralls is a killer combination - use it!
- Free for public repositories

### Travis CI

- https://travis-ci.org

### Coveralls: code coverage history and stats

- https://coveralls.io
