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

   To be added ...
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
   Nothing here yet...
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
   Nothing here yet...
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
   Nothing here yet...
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
   Nothing here yet...
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
   Nothing here yet...
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
