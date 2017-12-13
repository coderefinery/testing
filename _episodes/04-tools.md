---
layout: episode
title: "Tools"
teaching: 10
exercises: 0
questions:
  - "What tools are out there?"
objectives:
  - "Discover the tool that fits your needs."
keypoints:
  - "Python and C/C++ have better tooling for automated tests and you can use those also for Fortran projects (via `iso_c_binding`)."
---

## Unit test frameworks

- Python
    - [pytest](http://doc.pytest.org)
    - [nose](http://nose.readthedocs.io)
    - [doctest](https://docs.python.org/2/library/doctest.html)
    - [unittest](https://docs.python.org/2/library/unittest.html)

- R
    - [testthat](https://github.com/hadley/testthat)

- C(++)
    - [Google Test](https://github.com/google/googletest)
    - [Catch2](http://catch-lib.net)
    - [cppunit](https://freedesktop.org/wiki/Software/cppunit/)
    - [Boost.Test](http://www.boost.org/doc/libs/1_62_0/libs/test/doc/html/index.html)
    - [UnitTest++](http://unittest-cpp.github.io)

- Fortran
    - [pFUnit](https://sourceforge.net/projects/pfunit/)
    - [FRUIT](https://sourceforge.net/projects/fortranxunit/)
    - [Ftunit](http://flibs.sourceforge.net/ftnunit.html)

---

## [pytest](http://doc.pytest.org)

Very easy to set up: Anaconda, Miniconda, or virtualenv.

Very easy to use: Prefix a function with "test\_" and the test runner will execute it.
No need to subclass anything.

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

- [Example output](https://travis-ci.org/bast/pytest-demo/builds/104182942)
- [Example project](https://github.com/bast/pytest-demo)

---

## [Google Test](https://github.com/google/googletest)

- Widely used
- Very rich in functionality

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

- [Example output](https://travis-ci.org/bast/gtest-demo/builds/104190982)
- [Example project](https://github.com/bast/gtest-demo)

---

## [pFUnit](https://sourceforge.net/projects/pfunit/)

- Very rich in functionality
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

- [Example output](https://travis-ci.org/bast/pfunit-demo/builds/104193675)
- [Example project](https://github.com/bast/pfunit-demo)

---

## CTest and CDash

- Components of the [CMake](https://cmake.org) suite (more about it later in this workshop)
- CTest runs a set of tests through bash/perl/python scripts and reports to CDash which aggregates results
- The test scripts can be anything you like

```cmake
include(CTest)
enable_testing()

add_test(my_test_name ${PROJECT_BINARY_DIR}/my_test_script --flags)
```

- CTest looks for the return codes: 0/non-0 (success/failure)
- CTest is a powerful test runner, no need to implement one
- Reporting to CDash is easy

```shell
$ make Nightly
```

- [CDash example](https://testboard.org)

---

## Travis and Coveralls

- GitHub plus [Travis CI](https://travis-ci.org)
  plus [Coveralls](https://coveralls.io) is a killer combination - use it!
- Free for public repositories
- We will exercise with both tools in the following interactive exercise

---

## Testing can also be fun

[Jenkins Chuck Norris plugin](https://wiki.jenkins-ci.org/display/JENKINS/ChuckNorris+Plugin):

<img src="{{ site.baseurl }}/img/chucknorris_badass.jpg" style="width: 350px;"/>
<img src="{{ site.baseurl }}/img/chucknorris_thumbup.jpg" style="width: 350px;"/>

Another Jenkins plugin:

"[Retaliation](https://github.com/codedance/Retaliation) is a Jenkins CI build
monitor that automatically coordinates a foam missile counter-attack against
the developer who breaks the build. It does this by playing a pre-programmed
control sequence to a USB Foam Missile Launcher to target the offending code
monkey."

<img src="{{ site.baseurl }}/img/launcher.jpg" style="width: 400px;"/>
