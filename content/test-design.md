# Test design

```{questions}
- How can different types of functions and classes be tested?
- How can the integrity of a complete program be monitored over time?
- How can functions that involve random numbers be tested?
```

In this episode we will consider how functions and programs can be tested in programs developed in different programming languages.

```{Objectives}
- Learn how to determine what kind of unit tests can be performed for different type of functions.
- Learn how to perform test-driven development in which tests for a function are designed and implemented before the function is written.
- Learn how to test functions whose output depend on random numbers.
```

```{discussion} Exercise instructions
**For the instructor**
- First motivate and give a quick tour of all exercises below (10 minutes).
- Emphasize that the focus of this episode is *design*. It is OK to only discuss in groups and not write code.

**In breakout rooms (35 minutes)**
- We arrange breakout rooms according to preferred languages.
- Choose the exercise which interests you most. There are many more exercises than we would have time for.
- Discuss what testing framework can be used to implement the test.
- Keep notes, questions, and answers in the collaborative document.
- If time is available, implement the test(s) using the chosen framework.

**Once we return to main room**
- Discussion on experiences learned (10 minutes).
```


## Pure and impure functions

Start by discussing how you would design tests for the
following five functions, and then try to write the tests.
Also discuss why some are easier to test than others.

```````{challenge} 1. Function that receives a number and returns a number
  `````{tabs}
    ````{tab} Python

      ```{literalinclude} code/factorial.py
      :language: python
      ```
    ````

    ````{tab} C++

      ```{literalinclude} code/factorial.cpp
      :language: C++
      ```
    ````

    ````{tab} R

      ```{literalinclude} code/factorial.R
      :language: R
      ```
    ````

    ````{tab} Julia

      ```{literalinclude} code/factorial.jl
      :language: julia
      ```
    ````

    ````{tab} Fortran

      ```{literalinclude} code/factorial.f90
      :language: fortran
      ```
    ````
   `````

``````{solution}
This is a **pure function** so is easy to test: inputs go to
outputs.  For example, start with the below, then think of some
what extreme cases/boundary cases there might be.  This example shows
all of the tests as one function, but you might want to make each test
function more fine-grained and test only one concept.

`````{tabs}
   ````{tab} Python

      ```{literalinclude} code/factorial_sol.py
      :language: python
      ```
   ````

   ````{tab} C++

      ```{literalinclude} code/factorial_sol.cpp
      :language: c++
      ```
   ````

   ````{tab} R

      ```{literalinclude} code/factorial_sol.R
      :language: R
      ```
   ````

   ````{tab} Julia

      ```{literalinclude} code/factorial_sol.jl
      :language: julia
      ```
   ````

   ````{tab} Fortran

      ```{literalinclude} code/factorial_sol.f90
      :language: fortran
      ```
   ````
`````
``````
```````

```````{challenge} 2. Function that receives two strings and returns a number
`````{tabs}
   ````{tab} Python

      ```{literalinclude} code/count_word_occurrence_in_string.py
      :language: Python
      ```
   ````

   ````{tab} C++

      ```{literalinclude} code/count_word_occurrence_in_string.cpp
      :language: c++
      ```
   ````

   ````{tab} R

      ```{literalinclude} code/count_word_occurrence_in_string.R
      :language: R
      ```
   ````

   ````{tab} Julia

      ```{literalinclude} code/count_word_occurrence_in_string.jl
      :language: julia
      ```
   ````

   ````{tab} Fortran

      ```{literalinclude} code/count_word_occurrence_in_string.f90
      :language: fortran
      ```
   ````
  `````

``````{solution}
This is again a **pure function** but uses strings.  Use a similar strategy
to the above.

`````{tabs}
   ````{tab} Python

      ```{literalinclude} code/count_word_occurrence_in_string_sol.py
      :language: Python
      ```
   ````

   ````{tab} C++

      ```{literalinclude} code/count_word_occurrence_in_string_sol.cpp
      :language: c++
      ```
   ````

   ````{tab} R

      ```{literalinclude} code/count_word_occurrence_in_string_sol.R
      :language: R
      ```
   ````

   ````{tab} Julia

      ```{literalinclude} code/count_word_occurrence_in_string_sol.jl
      :language: julia
      ```
   ````

   ````{tab} Fortran

      ```{literalinclude} code/count_word_occurrence_in_string_sol.f90
      :language: fortran
      ```
   ````

``````
```````

```````{challenge} 3. Function which reads a file and returns a number
`````{tabs}

   ````{tab} Python

      ```{literalinclude} code/count_word_occurrence_in_file.py
      :language: Python
      ```
   ````

   ````{tab} C++

      ```{literalinclude} code/count_word_occurrence_in_file.cpp
      :language: c++
      ```
   ````

   ````{tab} R

      ```{literalinclude} code/count_word_occurrence_in_file.R
      :language: R
      ```
   ````

   ````{tab} Julia

      ```{literalinclude} code/count_word_occurrence_in_file.jl
      :language: julia
      ```
   ````

   ````{tab} Fortran

      ```{literalinclude} code/count_word_occurrence_in_file.f90
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

   ````{tab} Python

      ```{literalinclude} code/count_word_occurrence_in_file_sol.py
      :language: Python
      ```
   ````

   ````{tab} C++

      ```{literalinclude} code/count_word_occurrence_in_file_sol.cpp
      :language: c++
      ```
   ````

   ````{tab} R

      ```{literalinclude} code/count_word_occurrence_in_file_sol.R
      :language: R
      ```
   ````

   ````{tab} Julia

      ```{literalinclude} code/count_word_occurrence_in_file_sol.jl
      :language: julia
      ```
   ````

   ````{tab} Fortran

      ```{literalinclude} code/count_word_occurrence_in_file_sol.f90
      :language: fortran
      ```
   ````

`````
``````
```````

```````{challenge} 4. Function with an external dependency
This one is not easy to test because the function has an external dependency.

`````{tabs}

   ````{tab} Python

      ```{literalinclude} code/reactor_temperature.py
      :language: Python
      ```
   ````

   ````{tab} C++

      ```{literalinclude} code/reactor_temperature.cpp
      :language: c++
      ```
   ````

   ````{tab} R

      ```{literalinclude} code/reactor_temperature.R
      :language: R
      ```
   ````

   ````{tab} Julia

      ```{literalinclude} code/reactor_temperature.jl
      :language: julia
      ```
   ````

   ````{tab} Fortran

      ```{literalinclude} code/reactor_temperature.f90
      :language: fortran
      ```
   ````
`````

``````{solution}
This function depends on the value of
`reactor.max_temperature` so the function is not pure, so testing gets
harder. You could use monkey patching to override the value of
`max_temperature`, and test it with different values.  [Monkey
patching](https://en.wikipedia.org/wiki/Monkey_patch) is the concept
of artificially changing some other value.

A better solution would probably be to rewrite the function.

`````{tabs}

   ````{tab} Python

      ```{literalinclude} code/reactor_temperature_sol.py
      :language: Python
      ```
   ````

   ````{tab} C++

      ```{literalinclude} code/reactor_temperature_sol.cpp
      :language: c++
      ```
   ````

   ````{tab} R

      ```{literalinclude} code/reactor_temperature_sol.R
      :language: R
      ```
   ````

   ````{tab} Julia

      ```{literalinclude} code/reactor_temperature_sol.jl
      :language: julia
      ```
   ````

   ````{tab} Fortran

      ```{literalinclude} code/reactor_temperature_sol.f90
      :language: fortran
      ```
   ````
`````   
``````
```````

```````{challenge} 5. Testing a method of a mutable class

`````{tabs}

   ````{tab} Python

      ```{literalinclude} code/Pet.py
      :language: Python
      ```
   ````

   ````{tab} C++

      ```{literalinclude} code/Pet.cpp
      :language: c++
      ```
   ````

   ````{tab} R

      ```{literalinclude} code/Pet.R
      :language: R
      ```
   ````

   ````{tab} Julia

      ```{literalinclude} code/Pet.jl
      :language: julia
      ```
   ````

   ````{tab} Fortran

      ```{literalinclude} code/Pet.f90
      :language: fortran
      ```
   ````
`````

``````{solution}
`````{tabs}

   ````{tab} Python

      ```{literalinclude} code/Pet_sol.py
      :language: Python
      ```
   ````

   ````{tab} C++

      ```{literalinclude} code/Pet_sol.cpp
      :language: c++
      ```
   ````

   ````{tab} R

      ```{literalinclude} code/Pet_sol.R
      :language: R
      ```
   ````

   ````{tab} Julia

      ```{literalinclude} code/Pet_sol.jl
      :language: julia
      ```
   ````

   ````{tab} Fortran

      ```{literalinclude} code/Pet_sol.f90
      :language: fortran
      ```
   ````
`````
``````
```````


## Test-driven development

```````{challenge} Test-driven development

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

   ````{tab} Python

      ```{literalinclude} code/tdd_sol.py
      :language: Python
      ```
   ````

   ````{tab} C++

      ```{literalinclude} code/tdd_sol.cpp
      :language: c++
      ```
   ````

   ````{tab} R

      ```{literalinclude} code/tdd_sol.R
      :language: R
      ```
   ````

   ````{tab} Julia

      ```{literalinclude} code/tdd_sol.jl
      :language: julia
      ```
   ````

   ````{tab} Fortran

      ```{literalinclude} code/tdd_sol.f90
      :language: fortran
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


```````{challenge} Different ways of testing randomness
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

   ````{tab} Python

      ```{literalinclude} code/yahtzee.py
      :language: Python
      ```
   ````

   ````{tab} C++

      ```{literalinclude} code/yahtzee.cpp
      :language: c++
      ```
   ````

   ````{tab} Julia

      ```{literalinclude} code/yahtzee.jl
      :language: julia
      ```
   ````

   `````

``````{solution}
   `````{tabs}

   ````{tab} Python

      ```{literalinclude} code/yahtzee_sol.py
      :language: Python
      ```
   ````

   ````{tab} C++

      ```{literalinclude} code/yahtzee_sol.cpp
      :language: c++
      ```
   ````

   ````{tab} Julia

      ```{literalinclude} code/yahtzee_sol.jl
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

````{challenge} Integration test for the uniq program
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

- How would you write an end-to-end test?
- Now imagine the code reads numbers and produces some (floating point) numbers.
  How would you test that?
- How would you test a code end-to-end which produces images?
````

```{keypoints}
- Pure functions (these are functions without side-effects) are easiest to test.
- Classes can be tested but it's somewhat more elaborate.
```
