# Test design

```{questions}
- How can different types of functions and classes be tested?
```


## Exercises and discussions 

This section has different types of exercises that can be 
solved and discussed in groups.


`````{challenge} Pure and impure functions

Start by discussing how you would design tests for the
following five functions, and then try to write the tests (note however that
function 4 cannot be directly run or tested because it's hypothetical).
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
   ```{code-tab} c++

   // 1
   /* Computes the factorial of n recursively. */
   constexpr unsigned int factorial(unsigned int n) {
      return (n <= 1) ? 1 : (n * factorial(n - 1));
   }

   // 2
   #include <string>
   
   /* Counts how often word appears in text.
    * Example: if text is "one two one two three four"
    *          and word is "one", then this function returns 2
    */
   int count_word_occurrence_in_string(const std::string& text, const std::string& word) {
     auto word_count = 0;
     auto count = 0;
   
     for (const auto ch : text) {
       if (ch == word[word_count]) ++word_count;
       if (word[word_count] == '\0') {
         word_count = 0;
         ++count;
       }
     }
   
     return count;
   }

   // 3
   #include <fstream>
   #include <streambuf>
   #include <string>

   /* Counts how often word appears in file fname.
    * Example: if file contains "one two one two three four"
    *          and word is "one", then this function returns 2
    */
   int count_word_occurrence_in_file(std::string fname, std::string word) {
     std::ifstream fh(fname);
     std::string text((std::istreambuf_iterator<char>(fh)),
                      std::istreambuf_iterator<char>());
   
     auto word_count = 0;
     auto count = 0;
   
     for (const auto ch : text) {
       if (ch == word[word_count]) ++word_count;
       if (word[word_count] == '\0') {
         word_count = 0;
         ++count;
       }
     }
   
     return count;
   }

   // 4 
   #include "constants.hpp"  
  /* ^--- Defines the max_temperature constant as:
   * namespace constants { 
   * constexpr double max_temperature = 100.0; 
   * }
   */
   
   enum class ReactorState : int { FINE, CRITICAL };
   
   /* Checks whether temperature is above max_temperature and returns a status. */
   ReactorState check_reactor_temperature(double temperature_celsius) {
     return temperature_celsius > constants::max_temperature
                ? ReactorState::CRITICAL
                : ReactorState::FINE;
   }
   
   // 5
   #include <string>
   
   class Pet {
    private:
     unsigned int hunger_{0};
     std::string name_{};
   
    public:
     explicit Pet(std::string name) : name_(name) {}
     void go_for_a_walk() { hunger_ += 1; }
     // ^-- how would you test this function?
     unsigned int hunger() const { return hunger_; }
   };
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
   ```{code-tab} fortran
   WRITEME
   ```
````
`````

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
   ```{code-tab} c++
   #include <catch2/catch.hpp>
   
   #include "factorial.hpp"

   TEST_CASE("Compute the factorial", "[factorial]") {
     REQUIRE(factorial(0) == 1);
     REQUIRE(factorial(1) == 1);
     REQUIRE(factorial(2) == 2);
     REQUIRE(factorial(3) == 6);
   }
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
   ```{code-tab} fortran
   WRITEME
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
   ```{code-tab} c++
   #include <catch2/catch.hpp>
   
   #include "word_count.hpp"

   TEST_CASE("Count occurrences of substring in string", "[count_word_occurrence_in_string]") {
     REQUIRE(count_word_occurrence_in_string("AAA BBB", "AAA") == 1);
     REQUIRE(count_word_occurrence_in_string("AAA AAA", "AAA") == 2);
     REQUIRE(count_word_occurrence_in_string("AAAA", "AAA") == 0);
   }
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
   ```{code-tab} fortran
   WRITEME
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
   ```{code-tab} c++
   #include <cstdio>
   #include <fstream>
   
   #include <catch2/catch.hpp>
   
   #include "word_count.hpp"
   
   TEST_CASE("Count occurrences of substring in file", "[count_word_occurrence_in_file]") {
     auto fname = std::tmpnam(nullptr);
     std::ofstream s(fname, std::ios::out | std::ios::trunc); 
     s << "one two one two three four" << std::endl;
     s.close();
     
     REQUIRE(count_word_occurrence_in_file(fname, "one") == 1);
     REQUIRE(count_word_occurrence_in_file(fname, "three") == 2);
     REQUIRE(count_word_occurrence_in_file(fname, "six") == 0);
     
     std::remove(fname);
   }
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
   ```{code-tab} fortran
   WRITEME
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
   ```{code-tab} c++
   // Changing variables included from headers (monkey patching) is not possible in C++.
   #include <catch2/catch.hpp>
   
   #include "reactor.hpp"
   
   TEST_CASE("Check reactor state", "[reactor_state]") {
     REQUIRE(check_reactor_temperature(99) == ReactorState::FINE);
     REQUIRE(check_reactor_temperature(100) == ReactorState::FINE);
     REQUIRE(check_reactor_temperature(101) == ReactorState::CRITICAL);
   }
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
   ```{code-tab} fortran
   WRITEME
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
   ```{code-tab} c++
   // Changing variables included from headers (monkey patching) is not possible in C++.
   #include <catch2/catch.hpp>
   
   #include "pet.hpp"
   
   TEST_CASE("Check my pets", "[pets]") {
     auto fido = Pet("fido");
     REQUIRE(fido.hunger() == 0);
     
     fido.go_for_a_walk();
     REQUIRE(fido.hunger() == 1);
   }
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
   ```{code-tab} fortran
   WRITEME
   ```   
   ````
`````



```{challenge} Test-driven development

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


```

`````{solution}
   ````{tabs}
      ```{code-tab} py

      def fizzbuzz(number):
          if not isinstance(number, int):
             raise TypeError
          if number < 1:
      	     raise ValueError
          elif number % 15 == 0:
             return "FizzBuzz"
          elif number % 3 == 0:
              return "Fizz"
          elif number % 5 == 0:
              return "Buzz"
          else:
              return number


      def test_fizzbuzz():
          import pytest

          expected_result = [1, 2, "Fizz", 4, "Buzz", "Fizz",
                             7, 8, "Fizz", "Buzz", 11, "Fizz",
                             13, 14, "FizzBuzz", 16, 17, "Fizz", 19, "Buzz"]
          obtained_result = [fizzbuzz(i) for i in range(1,21)]
          
          assert obtained_result == expected_result
          
          with pytest.raises(ValueError):
              fizzbuzz(-5)
          with pytest.raises(ValueError): 
              fizzbuzz(0)
      
          with pytest.raises(TypeError):
              fizzbuzz(1.5)
          with pytest.raises(TypeError):
              fizzbuzz("rabbit")
      
      
      def main():
          for i in range(1,100):
              print(fizzbuzz(i))
      
      if __name__=="__main__":
          main()
      ```
      ```{code-tab} c++
      // in the fizzbuzz.hpp header file
      #include <string>
      
      std::string fizzbuzz(unsigned int n) {
        if (n % 15 == 0) {
          return "FizzBuzz";
        } else if (n % 3 == 0) {
          return "Fizz";
        } else if (n % 5 == 0) {
          return "Buzz";
        } else {
          return std::to_string(n);
        }
      }
      
      // in the source file for the main executable
      #include <cstdlib>
      #include <iostream>
      
      int main() {
        for (auto i = 0; i < 100; ++i) {
          std::cout << fizzbuzz(i) << std::endl;
        }
      }
      
      // in the source file for the test
      #include <string>

      #include <catch2/catch.hpp>
      
      #include "fizzbuzz.hpp"
      
      TEST_CASE("FizzBuzz", "[fizzbuzz]") {
        auto expected = std::vector<std::string>{
              "1",        "2",    "Fizz", "4",    "Buzz", "Fizz", "7",
              "8",        "Fizz", "Buzz", "11",   "Fizz", "13",   "14",
              "FizzBuzz", "16",   "17",   "Fizz", "19",   "Buzz"};
        
        for (auto i = 1; i <= 21; ++i) {
          REQUIRE(fizzbuzz(i) == expected[i]); 
        }
      }
   
      ```
      ```{code-tab} r R
      WRITEME
      ```
      ```{code-tab} julia

      using Test

      function fizzbuzz(number::Int)
          if number < 1
              throw(DomainError(number, "number needs to be 1 or higher"))
          elseif number % 15 == 0
              return "FizzBuzz"
          elseif number % 3 == 0
              return "Fizz"        
          elseif number % 5 == 0
              return "Buzz"
          else
              return number
          end
      end

      @testset begin
          expected_result = [1, 2, "Fizz", 4, "Buzz", "Fizz",
                             7, 8, "Fizz", "Buzz", 11, "Fizz",
                             13, 14, "FizzBuzz", 16, 17, "Fizz", 19, "Buzz"]
          obtained_result = [fizzbuzz(i) for i in 1:20]

          @test obtained_result == expected_result

          @test_throws MethodError fizzbuzz(1.5)
          @test_throws DomainError fizzbuzz(0)
          @test_throws DomainError fizzbuzz(-5)

      end

      for i in 1:20
          println(fizzbuzz(i))
      end
      ```
      ```{code-tab} c++
      WRITEME
      ```
      ```{code-tab} fortran
      WRITEME      
      ```
   ````
`````

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


`````{challenge} Different ways of testing randomness

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


   ````{tabs}
      ```{code-tab} py
      WRITEME
      ```
      ```{code-tab} c++
      #include <cstdlib>
      #include <iostream>
      #include <random>
      #include <tuple>
      #include <vector>
      
      /* Roll a fair die n_dice times. The faces of the die can be set (default is 1 to 6). 
       * The PRNG engine is moved in the function such that changes in its state are propagated back to the caller.
       */
      template <typename PRNGEngine = decltype(std::default_random_engine())>
      std::vector<unsigned int> roll_dice(
          unsigned int n_dice = 5,
          std::vector<unsigned int> faces = {1, 2, 3, 4, 5, 6},
          PRNGEngine&& gen = std::default_random_engine(std::random_device()())) {
        // create a fair die
        auto weights = std::vector<double>(faces.size(), 1.0);
        auto fair_dice =
            std::discrete_distribution<unsigned int>(weights.begin(), weights.end());
      
        auto rolls = std::vector<unsigned int>(n_dice, 0);
        for (auto i = 0u; i < n_dice; ++i) {
          rolls[i] = faces[fair_dice(gen)];
        }
      
        return rolls;
      }
      
      /* count how many times each face comes up */
      std::vector<unsigned int> count(const std::vector<unsigned int>& toss,
                                      const std::vector<unsigned int>& faces = {
                                          1, 2, 3, 4, 5, 6}) {
        auto face_counts = std::vector<unsigned int>(faces.size(), 0);
        for (auto i = 0; i < faces.size(); ++i) {
          face_counts[i] = std::count(toss.cbegin(), toss.cend(), faces[i]);
        }
        return face_counts;
      }

      std::tuple<unsigned int, unsigned int> yahtzee() {
        auto n_dice = 5;
        auto faces = std::vector<unsigned int>{1, 2, 3, 4, 5, 6};
        auto toss = [faces](unsigned int n_dice) { return roll_dice(n_dice, faces); };
        // throw all dice
        auto first_toss = toss(n_dice);
        auto face_counts = count(first_toss);
      
        auto it_max = std::max_element(face_counts.cbegin(), face_counts.cend());
        // number of faces that showed the most
        auto n_collected = *it_max;
        // corresponding index in the array, will be used to get which face showed up
        // the most
        auto idx_max = std::distance(face_counts.cbegin(), it_max);
      
        // all 5 dice showed the same face! YAHTZEE!
        if (n_collected == 5) return std::make_tuple(faces[idx_max], n_collected);
      
        // no yahtzee :(
        // we throw (n_dice - n_collected) dice
        auto second_toss = toss(n_dice - n_collected);
        n_collected += count(second_toss, {faces[idx_max]})[0];
        // YAHTZEE!
        if (n_collected == 5) return std::make_tuple(faces[idx_max], n_collected);
      
        // final chance
        auto third_toss = toss(n_dice - n_collected);
        n_collected += count(third_toss, {faces[idx_max]})[0];
      
        return std::make_tuple(faces[idx_max], n_collected);
      }
      
      int main() {
        for (auto i = 0; i < 100; ++i) {
          unsigned int value = 0, times = 0;
          std::tie(value, times) = yahtzee();
          std::cout << "We got " << value << " " << times << " times in round " << i
                    << std::endl;
          if (times == 5) {
            std::cout << "YAHTZEE in round " << i << std::endl;
          }
        }     
        
        return EXIT_SUCCESS;
      }
      ```
      ```{code-tab} r R
      WRITEME
      ```      
      ```{code-tab} r R
      WRITEME
      ```      
      ```{code-tab} julia      
      using Random

      """
          roll_dice(n_dice::Int=5, sides=(1,2,3,4,5,6))

      Returns array of n_dice random integers corresponding to the sides of dice
      """
      function roll_dice(n_dice::Int=5, sides=(1,2,3,4,5,6))
          return [rand(sides) for i in 1:n_dice]    
      end

      """
          yahtzee()

      Play Yahtzee with 5 6-sided dice and 3 throws.
      Collect as many of the same dice side as possible. 
      Returns a tuple with the collected side (e.g. 4's) and 
      how many of that side (between 1 and 5).
      """
      function yahtzee()
          sides = (1,2,3,4,5,6)
          n_dice = 5
          # we first throw all dice
          first_throw = roll_dice(n_dice, sides)
          # count how many times each side comes up
          side_counts = [count(x->x==i,first_throw) for i in sides]
          # collected_side is the dice side we will start collecting
          n_collected, collected_side = findmax(side_counts)
          if n_collected == 5
              return collected_side, n_collected
          end
    
          # now we throw n_dice-n_collected dice and hope to get more collected_side
          second_throw = roll_dice(n_dice-n_collected, sides)
          n_new_matches = count(x->x==collected_side,second_throw)
          n_collected += n_new_matches
          if n_collected == 5
              return collected_side, n_collected
          end    
      
          # final throw...
          third_throw = roll_dice(n_dice-n_collected, sides)
          n_new_matches = count(x->x==collected_side,third_throw)
          n_collected += n_new_matches
      
          return collected_side, n_collected
      end
            
      
      for i in 1:10
          collected_side, n_collected = yahtzee()
          println("We got $n_collected $collected_side's in this round")
          if n_collected == 5
              println("Yay, it's a Yahtzee!")
          end
      end
      ```
   ````
`````
            
`````{solution}
   ````{tabs}
      ```{code-tab} py
      WRITEME
      ```
      ```{code-tab} c++
      #include <random>
      
      #include <catch2/catch.hpp>
      
      #include "yahtzee.hpp"
      
      using namespace Catch::literals;
      
      TEST_CASE("Tossing 5 dice", "[toss]") {
        auto n_dice = 5;
        auto faces = std::vector<unsigned int>{1, 2, 3, 4, 5, 6};

        // we fix both the random device and the random engine.
        // the latter is necessary since the default random engine is implementation-dependent 
        std::mt19937 prng;
        prng.seed(1234);
        
        auto expected_1 = std::vector<unsigned int>{3, 5, 4, 5, 6};
        auto toss_1  = roll_dice(n_dice, faces, prng);
        REQUIRE(toss_1 == expected_1);
        
        auto expected_2 = std::vector<unsigned int>{1, 2, 5, 1, 1};
        auto toss_2  = roll_dice(n_dice, faces, prng);
        REQUIRE(toss_2 == expected_2);
        
        auto expected_3 = std::vector<unsigned int>{1, 3, 2, 5, 1};
        auto toss_3  = roll_dice(n_dice, faces, prng);
        REQUIRE(toss_3 == expected_3);
      }
      
      TEST_CASE("Distribution of Yahtzee", "[yahtzee]") {
        // try a million throws and see if we get close
        // to the statistical average of 4.6%
        // (https://en.wikipedia.org/wiki/Yahtzee#Probabilities)
        auto n_yahtzees = 0;
        auto n_trials = 1e6;

        for (auto i = 0; i < n_trials; ++i) {
          unsigned int value = 0, times = 0;
          std::tie(value, times) = yahtzee();
          if (times == 5) {
            ++n_yahtzees;
          } 
        }
        
        REQUIRE( n_yahtzees / n_tests == 0.046_a)
      }
      ```
      ```{code-tab} r R
      WRITEME
      ```
      ```{code-tab} julia
      using Test      

      @testset "test roll_dice" begin
          # fix random seed
          Random.seed!(1234);
          # known sequence for given seed
          exp_first_throw = [1, 3, 5, 1, 6]
          exp_second_throw = [1, 6, 4, 5, 4]
          exp_third_throw = [1, 2, 5, 3, 2]
      
          n_dice = 5
          sides=(1,2,3,4,5,6)
          throw = roll_dice(n_dice, sides)
          @test throw == exp_first_throw
          throw = roll_dice(n_dice, sides)
          @test throw == exp_second_throw
          throw = roll_dice(n_dice, sides)
          @test throw == exp_third_throw
      end
      
      @testset "testing yahtzee" begin
          # try a million throws and see if we get close
          # to the statistical average of 4.6%
          # (https://en.wikipedia.org/wiki/Yahtzee#Probabilities)
          n_yahtzees = 0
          n_tests = 1_000_000
          for i in 1:n_tests
              collected_side, n_collected = yahtzee()    
              if n_collected == 5
                  n_yahtzees += 1
              end
          end
          @test n_yahtzees/n_tests ≈ 0.046 atol=0.001
      end
      

      ```      
   ````
`````


```{keypoints}
- Pure functions (these are functions without side-effects) are easiest to test.
- Classes can be tested but it's somewhat more elaborate.
```
