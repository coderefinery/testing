# Testing locally

```{questions}
- How hard is it to set up a test suite for a first unit test?
```


## Exercise 


In this exercise we will make a simple function and use
one of the language specific test frameworks to test it.

* This is easy to use by almost any project and doesn't rely on any
  other servers or services.  
* The downside is that you have to remember to run it yourself.

`````````{exercise} Local-1: Create a minimal example (15 min)
In this exercise, we will create a minimal example using
the [pytest](http://doc.pytest.org), run the test, and show what
happens when a test breaks.


1. Create a new directory and change into it:
   ```console
   $ mkdir local-testing-example
   $ cd local-testing-example
   ```

2. Create an example file and paste the following code into it
```````{tabs}
  ``````{group-tab} Python
    Create `example.py` with content

    ```{literalinclude} code/python/example.py
    :language: python
    ``` 
    This code contains one genuine function and a test function.
   `pytest` finds any functions beginning with `test_` and treats them
   as tests.
  ``````

  ``````{group-tab} R
    Create `example.R` with content 
    ```{literalinclude} code/R/example.R
    :language: R
    ```
    A test with `testthat` is created by calling 
    `test_that()` with a test name and code as arguments.
  ``````

  ``````{group-tab} Julia
    Create `example.jl` with content 
    ```{literalinclude} code/julia/example.jl
    :language: Julia
    ```
    The package `Test.jl` handles all testing. 
    A test(set) is added with `@testset` 
    and a test itself with `@test`.
  ``````

  ``````{group-tab} C++
    `````{tabs}
      ````{group-tab} Catch2
        Create `example.cc` with content
        ```{literalinclude} code/cpp_catch2/example.cc
          :language: cpp
        ```
        and `CMakeLists.txt` with content
        ```{literalinclude} code/cpp_catch2/CMakeLists.txt
          :language: cmake
        ```

      ````
      ````{group-tab} GoogleTest
        Create `example.cc` with content
        ```{literalinclude} code/cpp_gtest/example.cc
          :language: cpp
        ```
        and `CMakeLists.txt` with content
        ```{literalinclude} code/cpp_gtest/CMakeLists.txt
          :language: cmake
        ```
      ````     
    `````    
  ``````

```````

3. Run the test
```````{tabs}
  ``````{group-tab} Python
   ```console
   $ pytest -v example.py

   ============================================================ test session starts =================================
   platform linux -- Python 3.7.2, pytest-4.3.1, py-1.8.0, pluggy-0.9.0 -- /home/user/pytest-example/venv/bin/python3
   cachedir: .pytest_cache
   rootdir: /home/user/pytest-example, inifile:
   collected 1 item

   example.py::test_add PASSED

   ========================================================= 1 passed in 0.01 seconds ===============================
   ```
   Yay! The test passed!

   Hint for participants trying this inside Spyder or IPython: try `!pytest -v example.py`.
  ``````
  ``````{group-tab} R
    ```console
    $ Rscript example.R 
    
    Loading required package: testthat
    Test passed 🎉 
    ```
    Yay! The test passed! 

    Note that the emoji is random and might be different for you.
  ``````
  ``````{group-tab} Julia
    ```console
    $ julia example.jl 
    
    Test Summary: | Pass  Total  Time
    myadd         |    1      1  0.0s
    ```
    Yay! The test passed! 
  ``````
  ``````{group-tab} C++
    As this is the only compiled language in the examples we have to do a few more steps.
    `````{tabs}
      ````{group-tab} Catch2
        Starting with the configure step of CMake
        (Note that `<path>` will be different for everyone)
        ```{literalinclude} code/cpp_catch2/config_log.txt
          :language: console
        ```
        and the build step which will also download Catch2 on the first run
        ```{literalinclude} code/cpp_catch2/build_log.txt
          :language: console          
        ```
        Finally, we change into the `build` directory 
        and run CTest
        ```{literalinclude} code/cpp_catch2/test_log.txt
          :language: console          
        ```
      ````
      ````{group-tab} GoogleTest
        Starting with the configure step of CMake
        (Note that `<path>` will be different for everyone)
        ```{literalinclude} code/cpp_gtest/config_log.txt
          :language: console
        ```
        and the build step which will also download GoogleTest on the first run
        ```{literalinclude} code/cpp_gtest/build_log.txt
          :language: console
        ```
        Finally, we change into the `build` directory 
        and run CTest
        ```{literalinclude} code/cpp_gtest/test_log.txt
          :language: console
        ```
      ````    
    `````    
  ``````
```````
4. Let us break the test!

Introduce a code change which breaks the code (e.g. `-` instead of `+`) and check
whether our test detects the change:
```````{tabs}
  ``````{group-tab} Python
   ```console
   $ pytest -v example.py

   ============================================================ test session starts =================================
   platform linux -- Python 3.7.2, pytest-4.3.1, py-1.8.0, pluggy-0.9.0 -- /home/user/pytest-example/venv/bin/python3
   cachedir: .pytest_cache
   rootdir: /home/user/pytest-example, inifile:
   collected 1 item

   example.py::test_add FAILED

   ================================================================= FAILURES =======================================
   _________________________________________________________________ test_add _______________________________________

       def test_add():
   >       assert add(2, 3) == 5
   E       assert -1 == 5
   E         --1
   E         +5

   example.py:6: AssertionError
   ========================================================= 1 failed in 0.05 seconds ==============
   ```
   Notice how pytest is smart and includes context: lines that failed,
   values of the relevant variables.
  ``````
  ``````{group-tab} R
    ```console
    $ Rscript example.R 

    ── Failure: Adding integers works ──────────────────────────────
    `res` not identical to 5.
    1/1 mismatches
    [1] -1 - 5 == -6

    Error: Test failed
    Execution halted
    ```
    `testthat` tells us exactly which test failed and how
    but does not include more context.
  ``````
  ``````{group-tab} Julia
    ```console
    $ julia example.jl

    myadd: Test Failed at /home/user/local-testing-example/example.jl:7
    Expression: myadd(2, 3) == 5
    Evaluated: -1 == 5

    Stacktrace:
    [1] macro expansion
    @ ~/opt/julia-1.10.0/share/julia/stdlib/v1.10/Test/src/Test.jl:672 [inlined]
    [2] macro expansion
    @ ~/local-testing-example/example.jl:7 [inlined]
    [3] macro expansion
    @ ~/opt/julia-1.10.0/share/julia/stdlib/v1.10/Test/src/Test.jl:1577 [inlined]
    [4] top-level scope
    @ ~/local-testing-example/example.jl:7
    Test Summary: | Fail  Total  Time
    myadd         |    1      1  0.6s
    ERROR: LoadError: Some tests did not pass: 0 passed, 1 failed, 0 errored, 0 broken.
    in expression starting at /home/user/local-testing-example/example.jl:6
    ```
    Notice how `Test.jl` is smart and includes context: 
    Lines that failed, evaluated and expected results.
  ``````
  ``````{group-tab} C++
    Since we introduced a change we have to call `cmake --build build` again
    (from the top directory)
    `````{tabs}
      ````{group-tab} Catch2
        ```{literalinclude} code/cpp_catch2/fail_log.txt
          :language: console
        ```
        following the recommendation, we run
        ```{literalinclude} code/cpp_catch2/fail_verbose_log.txt
          :language: console
        ```
        This output is very verbose, but notice how it includes context: lines that failed, values of the relevant variables
      ````
      ````{group-tab} GoogleTest
        ```{literalinclude} code/cpp_gtest/fail_log.txt
          :language: console
        ```
        following the recommendation, we run
        ```{literalinclude} code/cpp_gtest/fail_verbose_log.txt
          :language: console
        ```
        This output is very verbose, but notice how it includes context: lines that failed, values of the relevant variables
      ````    
    `````
  ``````
```````
`````````

`````````{challenge} (optional) Local-2: Create a test that considers numerical tolerance (10 min)
Let's see an example where the test has to be more clever in order to
avoid false negative.

In the above exercise we have compared integers.  In this optional exercise we
want to learn how to compare floating point numbers since they are more tricky
(see also ["What Every Programmer Should Know About Floating-Point Arithmetic"](https://floating-point-gui.de/)).

The following test will fail and this might be surprising. Try it out:
```````{tabs}
  ``````{group-tab} Python
   ```python
   def add(a, b):
       return a + b

   def test_add():
       assert add(0.1, 0.2) == 0.3
   ```
  ``````
  ``````{group-tab} R
   ```R
   add <- function(a, b){
       return a + b
   }

   test_that("Adding floats works", { 
       expect_identical(add(0.1, 0.2),0.3)
   })
   ```
  ``````
  ``````{group-tab} Julia
   ```Julia
   function myadd(a,b)
       return a + b
    end

   using Test
   @testset "myadd" begin
       @test myadd(0.1, 0.2) == 0.3
   end
   ```
  ``````
  ``````{group-tab} C++
    `````{tabs}
      ````{group-tab} Catch2
        ```cpp
          #include <catch2/catch_test_macros.hpp>
        
          template<typename Number>
          Number
          add(Number a, Number b)
          {
            return a + b;
          }    
          
          TEST_CASE("AddTests", "DoubleTest")
          {
              REQUIRE(add(0.1,0.2)==0.3);
          }
        ```
      ````
      ````{group-tab} GoogleTest
        ```cpp
          #include <gtest/gtest.h>
        
          template<typename Number>
          Number
          add(Number a, Number b)
          {
            return a + b;
          }    
          
          TEST(AddTests, DoubleTest)
          {
              ASSERT_EQ(add(0.1,0.2),0.3);
          }
        ```
      ````    
    `````
  ``````
```````

Your goal: find a more robust way to test this addition.
`````````

`````````{solution} Solution: Local-2

```````{tabs}
  ``````{group-tab} Python
    One solution is to use
    [pytest.approx](https://docs.pytest.org/en/4.6.x/reference.html#pytest-approx):
    ```python
    from pytest import approx

    def add(a, b):
        return a + b

    def test_add():
        assert add(0.1, 0.2) == approx(0.3)
    ```

    But maybe you didn't know about
    [pytest.approx](https://docs.pytest.org/en/4.6.x/reference.html#pytest-approx):
    and did this instead:
    ```python
    def test_add():
        result = add(0.1, 0.2)
        assert abs(result - 0.3) < 1.0e-7
    ```
    This is OK but the `1.0e-7` can be a bit arbitrary.
  ``````
  ``````{group-tab} R
    One solution is to use
    [expect_equal](https://testthat.r-lib.org/reference/equality-expectations.html) which allows for roundoff errors:
    ```R
    test_that("Adding floats works with equal", {
        res <- add(0.1, 0.2)
        expect_equal(res,0.3)
        expect_true(is.numeric(res))
    })
    ```

    But maybe you didn't know about it and used the 'less than' comparison of [expect_lt](https://testthat.r-lib.org/reference/comparison-expectations.html) instead:
    ```R
    test_that("Adding floats works with lt", {
        res <- add(0.1, 0.2)
        expect_lt(abs(res-0.3),1.0e-7)
        expect_true(is.numeric(res))
    })
    ```
    This is OK but the `1.0e-7` can be a bit arbitrary.
  ``````
  ``````{group-tab} Julia
    One solution is to use `\approx`:
    ```Julia
    @testset "Add floats with approx" begin
        @test myadd(0.1,0.2) ≈ 0.3
        #Variant with specifying a tolerance
        @test myadd(0.1,0.2) ≈ 0.3 atol=1.0e-7
    end
    ```

    But maybe you didn't know about `\approx`
    and did this instead:
    ```python
        @test abs(myadd(0.1,0.2)-0.3) < 1.0e-7
    ```
    This is OK but the `1.0e-7` can be a bit arbitrary.
  ``````
  ``````{group-tab} C++
    `````{tabs}
      ````{group-tab} Catch2
        Catch2 offers a very sophisticated way to test equality of two floating point numbers based on 'units in the last place (ULP)'.
        Matching the settings of GoogleTest we consider decimals equals to within `4` ULP.
        ```cpp
          #include <catch2/matchers/catch_matchers_floating_point.hpp>
          using Catch::Matchers::WithinULP;
          TEST_CASE("DoubleTest", "[add]")
          {
            REQUIRE_THAT(add(0.1,0.2),WithinULP(0.3,4));
          }
        ```
        But maybe you didn't know about 
        [Catch2 floating point matchers](https://github.com/catchorg/Catch2/blob/devel/docs/comparing-floating-point-numbers.md#top)
        and did this instead:
        ```cpp
          #include <cmath>
          TEST_CASE("DoubleTest", "[add]")
          {
            REQUIRE(std::abs(add(0.1,0.2)-0.3) < 1.0e-7);
          }
        ```
        This is OK but the `1.0e-7` can be a bit arbitrary. The first option is certainly more robust and recommended in the C++ case.
      ````
      ````{group-tab} GoogleTest
        GoogleTest offers a very sophisticated way to test equality of two double numbers based on 'units in the last place (ULP)',
        see [the documentation](http://google.github.io/googletest/reference/assertions.html#floating-point) for more details.
        ```cpp 
          TEST(AddTests, DoubleTest)
          {
            ASSERT_DOUBLE_EQ(add(0.1,0.2),0.3);
          }
        ```
        But maybe you found the 'less than' assertion first and did this instead:
        ```cpp
          #include<cmath>
          TEST(AddTests, DoubleTest)
          {
            //assert that add(0.1,0.2)-0.3 < 1.0e-7 holds
            ASSERT_LT(std::abs(add(0.1,0.2)-0.3),1.0e-7);
          }
        ```
        This is OK but the `1.0e-7` can be a bit arbitrary. The first option is certainly more robust and recommended in the C++ case.
      ````
    `````
  ``````
``````` 
``````````

---

```{keypoints}
- Each test framework has its way of collecting and running all test functions, e.g. functions beginning with `test_` for `pytest`.
- Python, Julia and C/C++ have better tooling for automated tests than Fortran and you can use those also for Fortran projects (via `iso_c_binding`).
```
