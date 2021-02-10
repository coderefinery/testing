# Test design

```{questions}
- How can different types of functions and classes be tested?
```


## Exercise/discussion: pure and impure functions

Discuss how you would design test functions for the following functions.
Also discuss why some are easier to test than others.

````{tabs}
   ```{code-tab} py

   # 1
   def factorial(n):
       """
       Computes the factorial of n.
       """
       if n < 0:
           raise ValueError('received negative input')
       result = 1
       for i in range(1, n + 1):
           result *= i
       return result


   # 2
   def count_word_occurrence_in_string(text, word):
       """
       Counts how often word appears in text.
       Example: if text is "one two one two three four"
                and word is "one", then this function returns 2
       """
       words = text.split()
       return words.count(word)


   # 3
   def count_word_occurrence_in_file(file_name, word):
       """
       Counts how often word appears in file file_name.
       Example: if file contains "one two one two three four"
                and word is "one", then this function returns 2
       """
       count = 0
       with open(file_name, 'r') as f:
           for line in f:
               words = line.split()
               count += words.count(word)
       return count


   # 4
   def check_reactor_temperature(temperature_celsius):
       """
       Checks whether temperature is above max_temperature
       and returns a status.
       """
       from reactor import max_temperature
       if temperature_celsius > max_temperature:
           status = 1
       else:
           status = 0
       return status


   # 5
   class Pet:
       def __init__(self, name):
           self.name = name
           self.hunger = 0
       def go_for_a_walk(self):  # <-- how would you test this function?
           self.hunger += 1
   ```

   ```{code-tab} r R
   # 1
   #' Computes the factorial of n
   #'
   #' @param n The number to compute the factorial of.
   #' @return The factorial of n
   factorial <- function(n) {
     if (n < 0)
       stop('received negative input')
     if (n == 0)
       return(1)

     result <- 1
     for (i in 1:n)
       result <- result * i
     result
   }

   # 2
   #' Counts how often a given word appears in text
   #'
   #' @param text The text to search in.
   #' @param word The word to search for.
   #' @return The number of times the word occurs in the text.
   count_word_occurrence_in_string <- function(text, word) {
     words <- strsplit(text, ' ')[[1]]
     sum(words == word)
   }

   # 3
   #' Counts how often a given word appears in a file.
   #'
   #' @param file_name The name of the file to search in.
   #' @param word The word to search for in the file.
   #' @return The number of times the word appeared in the file.
   count_word_occurrence_in_file <- function(file_name, word) {
     count <- 0
     for (line in readLines(file_name)) {
       words <- strsplit(line, ' ')[[1]]
       count <- count + sum(words == word)
     }
     count
   }

   # 4
   # reactor <- namespace::makeNamespace("reactor")
   # assign("max_temperature", 100, env = reactor)
   # namespaceExport(reactor, "max_temperature")

   #' Checks whether the temperature is above max_temperature
   #' and returns the status.
   #'
   #' @param temperature_celsius The temperature of the core
   #' @return 1 if the temperature is in range, otherwise 0
   check_reactor_temperature <- function(temperature_celsius) {
     if (temperature_celsius > reactor::max_temperature)
       status <- 1
     else
       status <- 0
     status
   }

   # 5
   Pet <- function(name) {
     structure(
       list(name = name, hunger = 0),
       class = "Pet"
     )
   }

   # How would you test this function?
   take_for_a_walk <- function(pet) UseMethod("take_for_a_walk")
   take_for_a_walk.Pet <- function(pet) {
     pet$hunger <- pet$hunger + 1
     pet
   }
   ```

   ```{code-tab} julia

    # 1
    """
        factorial(n::Int)

    Compute the factorial of n.
    """
    function factorial(n::Int)
        if n < 0
            throw(DomainError("n must be non-negative"))
        end
        result = 1
        for i in 1:n
            result *= i
        end
        return result
    end

    # 2
    """
        count_word_occurrence_in_string(text::String, word::String)
    
    Count how often word appears in text.
    Example: if `text` is "one two one two three four"
    and `word` is "one", then this function returns 2
    """
    function count_word_occurrence_in_string(text::String, word::String)
    
        return count(word, text)
    
    end

    # 3
    """
        count_word_occurrence_in_file(file_name::String, word::String)
    
    Counts how often word appears in file file_name.
    Example: if file contains "one two one two three four"
             And word is "one", then this function returns 2
    """
    function count_word_occurrence_in_file(file_name::String, word::String)
        open(file_name, "r") do file
            lines = readlines(file)
            return count(word, join(lines))
        end
    end

    # 4

    # Importing modules inside functions is not allowed in Julia and must be done at top-level:
    using reactor: max_temperature
    
    """
        check_reactor_temperature(temperature_celsius)
    
    Checks whether temperature is above max_temperature
    and returns a status.
    """
    function check_reactor_temperature(temperature_celsius)    
        if temperature_celsius > max_temperature
            status = 1
        else
            status = 0
        end
    end
    
    # 5    
    # the closest thing to a class in Julia is a `mutable struct`
    mutable struct Pet
        name::String
        hunger::Int64 
    end
    
    function go_for_a_walk!(pet::Pet)
        pet.hunger += 1
    end
    
   ```
````

`````{solution}

1. This is a **pure function** so is easy to test: inputs go to
outputs.  For example, start with the below, then think of some
what extreme cases/boundary cases there might be.  This example shows
all of the tests as one function, but you might want to make each test
function more fine-grained and test only one concept.

   ````{tabs}
   ```{code-tab} py
   import pytest

   def test_factorial():
       assert factorial(0) == 1
       assert factorial(1) == 1
       assert factorial(2) == 2
       assert factorial(3) == 6
       # also try negatives (check that it raises an error), non-integers, etc.

       # Raise an error if factorial does *not* raise an error:
       with pytest.raises(ValueError):
           factorial(-1)  # raises ValueError

   ```
   ```{code-tab} r R
   test_that("Test factorial", {
     expect_equal(factorial(0), 1)
     expect_equal(factorial(1), 1)
     expect_equal(factorial(2), 2)
     expect_equal(factorial(3), 6)
     # also try negatives (check that it raises an error), non-integers, etc.

     # Raise an error if factorial does *not* raise an error:
     expect_error(factorial(-1))
   })
   ```
   ```{code-tab} julia
   @testset "Test factorial function" begin
       @test_throws DomainError factorial(-1)
       @test factorial(3) == 6
   end

   ```
   ````

2. Again a **pure function** but uses strings.  Use a similar strategy
to the above.

   ````{tabs}
   ```{code-tab} py
   def test_count_word_occurrence_in_string():
       assert count_word_occurrence_in_string('AAA BBB', 'AAA') == 1
       assert count_word_occurrence_in_string('AAA AAA', 'AAA') == 2
       # What does this last test tell us?
       assert count_word_occurrence_in_string('AAAAA', 'AAA') == 1
   ```
   ```{code-tab} r R
   test_that("Test count word occurrence in string", {
     expect_equal(count_word_occurrence_in_string("AAA BBB", "AAA"), 1)
     expect_equal(count_word_occurrence_in_string("AAA AAA", "AAA"), 2)
     expect_equal(count_word_occurrence_in_string("AAAAA", "AAA"), 0)
   })
   ```
   ```{code-tab} julia
    @testset "Test count word occurrence in string" begin
        @test count_word_occurrence_in_string("AAA BBB", "AAA") == 1
        @test count_word_occurrence_in_string("AAA AAA", "AAA") == 2
        @test count_word_occurrence_in_string("AAAAA", "AAA") == 1
    end
   ```

   ````

3. Not a pure function, because the output depends on the value of a
   file. We can generate a temporary file for testing and remove it afterwards.
   Even better could be to split file reading from the
   calculation, so that testing the calculation part becomes easy (see
   above).

   ````{tabs}
   ```{code-tab} py
   import tempfile
   import os
   
   def test_count_word_occurrence_in_file():
       _, temporary_file_name = tempfile.mkstemp()
       with open(temporary_file_name, 'w') as f:
           f.write("one two one two three four")
       count = count_word_occurrence_in_file(temporary_file_name, "one")
       assert count == 2
       os.remove(temporary_file_name)
   ```
   ```{code-tab} r R
   test_that("Test count word occurrence in file", {
     fname <- tempfile()
     write("one two one two three four", fname)
     expect_equal(count_word_occurrence_in_file(fname, "one"), 2)
     expect_equal(count_word_occurrence_in_file(fname, "three"), 1)
     expect_equal(count_word_occurrence_in_file(fname, "six"), 0)
     unlink(fname)
   })
   ```
   ```{code-tab} julia
   @testset "Test count word occurrence in file" begin
       msg = "one two one two three four"
       (fname, testio) = mktemp()
       println(testio, msg)
       close(testio)
       @test count_word_occurrence_in_file(fname, "one") == 2
       @test count_word_occurrence_in_file(fname, "three") == 1
       @test count_word_occurrence_in_file(fname, "six") == 0
    end
   ```   
   ````

4. External dependency.  Now, this depends on the value of
`reactor.max_temperature` so the function is not pure, so it gets
harder.  You could use monkey patching to override the value of
`max_temperature`, and test it with different values.  [Monkey
patching](https://en.wikipedia.org/wiki/Monkey_patch) is the concept
of artificially changing some other value.

   ````{tabs}
   ```{code-tab} py
   def test_set_temp(monkeypatch):
       monkeypatch.setattr(reactor, "max_temperature", 100)
       assert check_reactor_temperature(99)  == 0
       assert check_reactor_temperature(100) == 0   # boundary cases easily go wrong
       assert check_reactor_temperature(101) == 1
   ```
   ```{code-tab} r R
   # Changing variables imported from modules (monkey patching) is not possible in R.
   # To be able to test this function properly it needs to be made pure:
   check_reactor_temperature <- function(max_temperature, temperature_celsius) {
     if (temperature_celsius > max_temperature)
       status <- 1
     else
       status <- 0
     status
   }
   test_that("Test reactor temperature", {
     expect_equal(check_reactor_temperature(100, 99), 0)
     expect_equal(check_reactor_temperature(100, 100), 0)  # boundary cases easily go wrong
     expect_equal(check_reactor_temperature(100, 101), 1)
   })
   ```
   ```{code-tab} julia
   # Changing variables imported from modules (monkey patching) is not possible in Julia.
   # To be able to test this function properly it needs to be made pure:

   function check_reactor_temperature(temperature_celsius, max_temperature)   
       if temperature_celsius > max_temperature
           status = 1
       else
           status = 0
       end
   end

   # normal invocation:
   using reactor: max_temperature
   check_reactor_temperature(99, max_temperature)      

   # tests
   @testset "Test check_reactor_temperature function" begin
       @test check_reactor_temperature(99, 100) == 0
       @test check_reactor_temperature(100, 100) == 0   # boundary cases easily go wrong
       @test check_reactor_temperature(101, 100) == 1
   end
   ```   
   ````

5. Mutable class.  You'd make the class and test it out some.

   ````{tabs}
   ```{code-tab} py
   def test_pet():
       p = Pet('asdf')
       assert p.hunger == 0
       p.go_for_a_walk()
       assert p.hunger == 1

	   p.hunger = -1
       p.go_for_a_walk()
       assert p.hunger == 0
   ```
   ```{code-tab} r R
   test_that("Test Pet class", {
     p <- Pet(name = "asdf")
     expect_equal(p$hunger, 0)
     p <- take_for_a_walk(p)
     expect_equal(p$hunger, 1)
   
     p$hunger <- -1
     p <- take_for_a_walk(p)
     expect_equal(p$hunger, 0)
   })
   ```
   ```{code-tab} julia
   # create the mutable struct and test it
   @testset "Test mutable struct" begin
       p = Pet("asdf", 0)
       @test p.hunger == 0
       go_for_a_walk!(p)
       @test p.hunger == 1
       p.hunger = -1
       go_for_a_walk!(p)
       @test p.hunger == 0
   end
   ```   
   ````



`````


## Testing randomness

Discussion: How would you test functions which generate random numbers
according to some distribution/statistics?

```{solution} Hints
- What is a random seed and how can it be useful in tests?
- Testing whether your results follow the expected distribution/statistics.
- When you verify your code "by eye", what are you looking at? Now try to express
  that in a script.
- Other strategies?
```


```{keypoints}
- Pure functions (these are functions without side-effects) are easiest to test.
- Classes can be tested but it's somewhat more elaborate.
```
