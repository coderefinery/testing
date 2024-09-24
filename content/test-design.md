# Test design

```{questions}
- How can different types of functions and classes be tested?
- How can the integrity of a complete program be monitored over time?
- How can functions that involve random numbers be tested?
```

In this episode we will consider how functions and programs can be tested in programs developed in different programming languages.

```{discussion} Exercise instructions
**For the instructor**
- First motivate and give a quick tour of all exercises below (10 minutes).
- Emphasize that the focus of this episode is *design*. It is OK to only discuss in groups and not write code.

**During exercise session**
- Choose the exercise which interests you most. There are many more exercises than we would have time for.
- Discuss what testing framework can be used to implement the test.
- Keep notes, questions, and answers in the collaborative document.

**Once we return to stream**
- Discussion about experiences learned.
```

`````{callout} Language-specific instructions
  ````{tabs}
    ```{group-tab} Python

    The suggested solutions below use pytest. Further information can
    be found in the [Quick Reference](pytest-ref).
    ```

    ```{group-tab} C++

    The suggested solutions below use Catch2. Further information can
    be found in the [Quick Reference](catch2).
    ```

   ```{group-tab} R

    The suggested solutions below use testthat. Further information can
    be found in the [Quick Reference](testthat).
    ```

    ```{group-tab} Julia

    The suggested solutions below use Test. Further information can
    be found in the [Quick Reference](test).
    ```

    ```{group-tab} Fortran

    The suggested solutions below use pFUnit. Further information on how to install
    pFUnit and set up tests can
    be found in the [Quick Reference](pfunit).
    ```
  ````
`````

## Pure and impure functions

Start by discussing how you would design tests for the
following five functions, and then try to write the tests.
Also discuss why some are easier to test than others.

```````{exercise} Design-1: Design a test for a function that receives a number and returns a number
  `````{tabs}
    ````{group-tab} Python

      ```{literalinclude} code/python/factorial.py
      :language: python
      ```
    ````

    ````{group-tab} C++

      ```{literalinclude} code/cpp/factorial.cpp
      :language: C++
      ```
    ````

    ````{group-tab} R

      ```{literalinclude} code/R/factorial.R
      :language: R
      ```
    ````

    ````{group-tab} Julia

      ```{literalinclude} code/julia/factorial.jl
      :language: julia
      ```
    ````

    ````{group-tab} Fortran

      ```{literalinclude} code/fortran/factorial.f90
      :language: fortran
      ```

    ````
    Discussion point: The factorial grows very rapidly. What happens if you
    pass a large number as argument to the function?
   `````

``````{solution}
This is a **pure function** so is easy to test: inputs go to
outputs.  For example, start with the below, then think of some
what extreme cases/boundary cases there might be.  This example shows
all of the tests as one function, but you might want to make each test
function more fine-grained and test only one concept.

`````{tabs}
   ````{group-tab} Python

      ```{literalinclude} code/python/factorial_sol.py
      :language: python
      ```
   ````

   ````{group-tab} C++

      ```{literalinclude} code/cpp/factorial_sol.cpp
      :language: c++
      ```
   ````

   ````{group-tab} R

      ```{literalinclude} code/R/factorial_sol.R
      :language: R
      ```
   ````

   ````{group-tab} Julia

      ```{literalinclude} code/julia/factorial_sol.jl
      :language: julia
      ```
   ````

   ````{group-tab} Fortran

      ```{literalinclude} code/fortran/test_factorial.pf
      ```
   ````
`````
   Notes on the discussion point: Programming languages differ in the way they deal with integer
   overflow. Python automatically converts to the necessary `long` type, in Julia you would
   observe a "wrap-around", in C/C++ you get undefined behaviour for signed integers.
   Testing for overflow likewise depends on the language.
``````
```````

```````{exercise} Design-2: Design a test for a function that receives two strings and returns a number
`````{tabs}
   ````{group-tab} Python

      ```{literalinclude} code/python/count_word_occurrence_in_string.py
      :language: Python
      ```
   ````

   ````{group-tab} C++

      ```{literalinclude} code/cpp/count_word_occurrence_in_string.cpp
      :language: c++
      ```
   ````

   ````{group-tab} R

      ```{literalinclude} code/R/count_word_occurrence_in_string.R
      :language: R
      ```
   ````

   ````{group-tab} Julia

      ```{literalinclude} code/julia/count_word_occurrence_in_string.jl
      :language: julia
      ```
   ````

   ````{group-tab} Fortran

      ```{literalinclude} code/fortran/count_word_occurrence_in_string.f90
      :language: fortran
      ```
   ````
  `````

``````{solution}
This is again a **pure function** but uses strings.  Use a similar strategy
to the above.

`````{tabs}
   ````{group-tab} Python

      ```{literalinclude} code/python/count_word_occurrence_in_string_sol.py
      :language: Python
      ```
   ````

   ````{group-tab} C++

      ```{literalinclude} code/cpp/count_word_occurrence_in_string_sol.cpp
      :language: c++
      ```
   ````

   ````{group-tab} R

      ```{literalinclude} code/R/count_word_occurrence_in_string_sol.R
      :language: R
      ```
   ````

   ````{group-tab} Julia

      ```{literalinclude} code/julia/count_word_occurrence_in_string_sol.jl
      :language: julia
      ```
   ````

   ````{group-tab} Fortran

      ```{literalinclude} code/fortran/count_word_occurrence_in_string_sol.f90
      :language: fortran
      ```
   ````

``````
```````

```````{exercise} Design-3: Design a test for a function which reads a file and returns a number
`````{tabs}

   ````{group-tab} Python

      ```{literalinclude} code/python/count_word_occurrence_in_file.py
      :language: Python
      ```
   ````

   ````{group-tab} C++

      ```{literalinclude} code/cpp/count_word_occurrence_in_file.cpp
      :language: c++
      ```
   ````

   ````{group-tab} R

      ```{literalinclude} code/R/count_word_occurrence_in_file.R
      :language: R
      ```
   ````

   ````{group-tab} Julia

      ```{literalinclude} code/julia/count_word_occurrence_in_file.jl
      :language: julia
      ```
   ````

   ````{group-tab} Fortran

      ```{literalinclude} code/fortran/count_word_occurrence_in_file.f90
      :language: fortran
      ```
   ````
  `````

``````{solution}
In this example we test a function which is not pure, because the output
depends on the value of a file. We can generate a temporary file for testing
and remove it afterwards.  Even better could be to split file reading from the
calculation, so that testing the calculation part becomes easy (see above).

`````{tabs}

   ````{group-tab} Python

      ```{literalinclude} code/python/count_word_occurrence_in_file_sol.py
      :language: Python
      ```
   ````

   ````{group-tab} C++

      ```{literalinclude} code/cpp/count_word_occurrence_in_file_sol.cpp
      :language: c++
      ```
   ````

   ````{group-tab} R

      ```{literalinclude} code/R/count_word_occurrence_in_file_sol.R
      :language: R
      ```
   ````

   ````{group-tab} Julia

      ```{literalinclude} code/julia/count_word_occurrence_in_file_sol.jl
      :language: julia
      ```
   ````

   ````{group-tab} Fortran

      ```{literalinclude} code/fortran/count_word_occurrence_in_file_sol.f90
      :language: fortran
      ```
   ````

`````
``````
```````

```````{exercise} Design-4: Design a test for a function with an external dependency
This one is not easy to test because the function has an external dependency.

`````{tabs}

   ````{group-tab} Python

      ```{literalinclude} code/python/even_time_difference.py
      :language: Python
      ```
   ````

   ````{group-tab} C++

      ```{literalinclude} code/cpp/even_time_difference.cpp
      :language: c++
      ```
   ````

   ````{group-tab} R

      ```{literalinclude} code/R/even_time_difference.R
      :language: R
      ```
   ````

   ````{group-tab} Julia

      ```{literalinclude} code/julia/even_time_difference.jl
      :language: julia
      ```
   ````

   ````{group-tab} Fortran

      ```{literalinclude} code/fortran/even_time_difference.f90
      :language: fortran
      ```
   ````
`````

``````{solution}
This function depends on the current time, so the function is not pure, so testing gets
harder. You could use monkey patching to replace the time function with another function
, and test it with different values.  [Monkey
patching](https://en.wikipedia.org/wiki/Monkey_patch) is the concept
of artificially changing some other value.

A better solution would probably be to rewrite the function.

`````{tabs}

   ````{group-tab} Python

      ```{literalinclude} code/python/even_time_difference_sol.py
      :language: Python
      ```
   ````

   ````{group-tab} C++

      ```{literalinclude} code/cpp/even_time_difference_sol.cpp
      :language: c++
      ```
   ````

   ````{group-tab} R

      ```{literalinclude} code/R/even_time_difference_sol.R
      :language: R
      ```
   ````

   ````{group-tab} Julia

      ```{literalinclude} code/julia/even_time_difference_sol.jl
      :language: julia
      ```
   ````

   ````{group-tab} Fortran

      ```{literalinclude} code/fortran/even_time_difference_sol.f90
      :language: fortran
      ```
   ````
`````
``````
```````

```````{exercise} Design-5: Design a test for a method of a mutable class

`````{tabs}

   ````{group-tab} Python

      ```{literalinclude} code/python/Pet.py
      :language: Python
      ```
   ````

   ````{group-tab} C++

      ```{literalinclude} code/cpp/Pet.cpp
      :language: c++
      ```
   ````

   ````{group-tab} R

      ```{literalinclude} code/R/Pet.R
      :language: R
      ```
   ````

   ````{group-tab} Julia

      ```{literalinclude} code/julia/Pet.jl
      :language: julia
      ```
   ````

   ````{group-tab} Fortran

      ```{literalinclude} code/fortran/Pet.f90
      :language: fortran
      ```
   ````
`````

``````{solution}
`````{tabs}

   ````{group-tab} Python

      ```{literalinclude} code/python/Pet_sol.py
      :language: Python
      ```
   ````

   ````{group-tab} C++

      ```{literalinclude} code/cpp/Pet_sol.cpp
      :language: c++
      ```
   ````

   ````{group-tab} R

      ```{literalinclude} code/R/Pet_sol.R
      :language: R
      ```
   ````

   ````{group-tab} Julia

      ```{literalinclude} code/julia/Pet_sol.jl
      :language: julia
      ```
   ````

   ````{group-tab} Fortran

      ```{literalinclude} code/fortran/Pet_sol.f90
      :language: fortran
      ```
   ````
`````
``````
```````


## Test-driven development

```````{exercise} Design-6: Experience test-driven development

Write a test before writing the function! You can decide yourself
what your unwritten function should do, but as a suggestion it can
be based on [FizzBuzz](https://en.wikipedia.org/wiki/Fizz_buzz) - i.e.
a function that:
- takes an integer argument
- for arguments that are multiples of three, returns "Fizz"
- for arguments that are multiples of five, returns "Buzz"
- for arguments that are multiples of both three and five, returns "FizzBuzz"
- fails in case of non-integer arguments or integer arguments 0 or negative
- otherwise returns the integer itself

When writing the tests, consider the different ways that the function could
and should fail.

After you have written the tests, implement the function and run the tests
until they pass.

``````{solution}

`````{tabs}

   ````{group-tab} Python

      ```{literalinclude} code/python/fizzbuzz.py
      :language: Python
      ```
   ````

   ````{group-tab} C++

      ```{literalinclude} code/cpp/fizzbuzz.cpp
      :language: c++
      ```
   ````

   ````{group-tab} R

      ```{literalinclude} code/R/fizzbuzz.R
      :language: R
      ```
   ````

   ````{group-tab} Julia

      ```{literalinclude} code/julia/fizzbuzz.jl
      :language: julia
      ```
   ````

   ````{group-tab} Fortran

      ```{literalinclude} code/fortran/fizzbuzz.f90
      :language: fortran
      ```
      ```{literalinclude} code/fortran/test_fizzbuzz.pf
      ```
   ````
   `````
``````
```````


## Testing randomness

How would you test functions which generate random numbers
according to some distribution/statistics?

Functions and modules which contain randomness are
more difficult to test than pure deterministic functions, but
many strategies exist:
- For unit tests we can use fixed random seeds.
- Try to test whether your results follow the expected
  distribution/statistics.
- When you verify your code "by eye", what are you looking at? Now try
  to express that in a script.


```````{exercise} Design-7: Write two different types of tests for randomness
   Consider the code below which simulates playing
   [Yahtzee](https://en.wikipedia.org/wiki/Yahtzee) by using
   random numbers. How would you go about testing it?

   Try to write two types of tests:
   - a *unit test* for the `roll_dice` function. Since it uses
     random numbers, you will need to **set the random seed**,
     pre-calculate what sequence of dice throws you get with that seed,
     and use that in your test.
   - a test of the `yahtzee` function which considers the statistical
     probability of obtaining a "Yahtzee" (5 dice with the same value
     after three throws), which is around 4.6%. This test will be
     an *integration test* since it tests multiple functions including the
     random number generator itself.


   `````{tabs}

   ````{group-tab} Python

      ```{literalinclude} code/python/yahtzee.py
      :language: Python
      ```
   ````

   ````{group-tab} C++

      ```{literalinclude} code/cpp/yahtzee.cpp
      :language: c++
      ```
   ````

   ````{group-tab} R

      ```{literalinclude} code/R/yahtzee.R
      :language: R
      ```
   ````

   ````{group-tab} Julia

      ```{literalinclude} code/julia/yahtzee.jl
      :language: julia
      ```
   ````

   `````

``````{solution}
   `````{tabs}

   ````{group-tab} Python

      ```{literalinclude} code/python/yahtzee_sol.py
      :language: Python
      ```
   ````

   ````{group-tab} C++

      ```{literalinclude} code/cpp/yahtzee_sol.cpp
      :language: c++
      ```
   ````

   ````{group-tab} R

      ```{literalinclude} code/R/yahtzee_sol.R
      :language: R
      ```
   ````

   ````{group-tab} Julia

      ```{literalinclude} code/julia/yahtzee_sol.jl
      :language: julia
      ```
   ````
   `````
``````
```````


## Designing an end-to-end test

In this exercise we will practice designing an end-to-end test.
In an end-to-end test (or integration test), the unit is the entire program.
We typically feed the program with some well defined input and verify
that it still produces the expected output by comparing it to some reference.

````{exercise} Design-8: Design (but not write) an end-to-end test for the uniq program
To have a tangible example, let us consider the `uniq` command. This command
can read a file or an input stream and remove consecutive repetition.
The program behind `uniq` has been written by somebody else, it probably contains
some functions, but we will not look into it but regard it as "black box".

If we have a file called `repetitive-text.txt` containing:
```
(all together now) all together now
(all together now) all together now
(all together now) all together now
(all together now) all together now
(all together now) all together now
another line
another line
another line
another line
intermission
more repetition
more repetition
more repetition
more repetition
more repetition
(all together now) all together now
(all together now) all together now
```

... then feeding this input file to `uniq` like this:
```
$ uniq < repetitive-text.txt
```

... will produce the following output with repetitions removed:
```
(all together now) all together now
another line
intermission
more repetition
(all together now) all together now
```

How would you write an end-to-end test for `uniq`?
````

````{exercise} Design-9: More end-to-end testing
- Now imagine a code which reads numbers and produces some (floating
  point) numbers. How would you test that?
- How would you test a code end-to-end which produces images?
````

`````{exercise} Design-10: Create an actual end-to-end test
Often, you can include tests that run your whole workflow or program.
For example, you might include sample data and check the output
against what you expect.  (including sample data is a great idea
anyway, so this helps a lot!)

We'll use the word-count example repository
<https://github.com/coderefinery/word-count>.

As a reminder, you can run the script like this to get some output,
which prints to standard output (the terminal):

```console
$ python3 code/count.py data/abyss.txt
```

Your goal is to make a test that can run this and let you know if it's
successful or not.  You could use Python, or you could use shell
scripting.  You can test if these two lines are in the output: `the
4044` and `and 2807`.

Python hint:
[subprocess.check_output](https://docs.python.org/3/library/subprocess.html#subprocess.check_output)
will run a command and return its output as a string.

Bash hint: `COMMAND | grep "PATTERN"` ("pipe to grep") will be true if
the pattern is in the command.

````{solution}
There are two solutions in the repository already, in the `tests/`
dierectory <https://github.com/coderefinery/word-count>, one in Python
and one in bash shell.  Neither of these are a very advanced or
perfect solution, and you could integrate them with pytest or whatever
other test framework you use.

The shell one works with shell and prints a bit more output:

```console
$ sh tests/end-to-end-shell.sh
the 4044
Success: 'the' found correct number of times
and 2807
Success: 'and' found correct number of times
Success
```

The Python one:
```console
$ python3 tests/end-to-end-python.py
Success
```
````
`````

```{keypoints}
- Pure functions (these are functions without side-effects) are easiest to test.
  And also easiest to reuse in another code project since they don't depend on
  any side-effects.
- Classes can be tested but it's somewhat more elaborate.
```
