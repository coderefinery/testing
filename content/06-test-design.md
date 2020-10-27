# Test design

```{questions}
- How can different types of functions and classes be tested?
```


## Exercise/discussion: pure and impure functions

Discuss how you would design test functions for the following functions.
Some are easier to test than others. Discuss why.

````{tabs}
   ```{code-tab} py

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


   def count_word_occurrence_in_string(text, word):
       """
       Counts how often word appears in text.
       Example: if text is "one two one two three four"
                and word is "one", then this function returns 2
       """
       words = text.split()
       return words.count(word)


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


   class Pet:
       def __init__(self, name):
           self.name = name
           self.hunger = 0
       def go_for_a_walk(self):  # <-- how would you test this function?
           self.hunger += 1
   ```

   ```{tab} R

   To be added ...
   ```
````


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
