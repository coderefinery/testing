# Motivation

```{questions}
- Why automated tests
- Can there be situations where automated tests are too much?
```


## Untested software can be compared to uncalibrated detectors

*"Before relying on a new experimental device, an experimental scientist always
establishes its accuracy. A new detector is calibrated when the scientist
observes its responses to known input signals. The results of this
calibration are compared against the expected response."*

> [From [Testing and Continuous Integration with Python](https://carpentries-incubator.github.io/python-testing/), created by K. Huff]

Simulations and analysis using software *should* be held to the same standards as experimental measurement devices!

Further motivation for testing:

- [A Scientist's Nightmare: Software Problem Leads to Five Retractions](https://science.sciencemag.org/content/314/5807/1856.summary)
- [Researchers find bug in Python script may have affected hundreds of studies](https://arstechnica.com/information-technology/2019/10/chemists-discover-cross-platform-python-scripts-not-so-cross-platform/)

---

## Testing in a nutshell

In software tests, expected results are compared with observed results in order
to establish accuracy:

````{tabs}
   ```{code-tab} py

   def fahrenheit_to_celsius(temp_f):
       """Converts temperature in Fahrenheit
       to Celsius.
       """
       temp_c = (temp_f - 32.0) * (5.0/9.0)
       return temp_c

   # This is the test function: `assert` raises an error if something
   # is wrong.
   def test_fahrenheit_to_celsius():
       temp_c = fahrenheit_to_celsius(temp_f=100.0)
       expected_result = 37.777777
       assert abs(temp_c - expected_result) < 1.0e-6
   ```

   ```{code-tab} c++

   #include <cmath>  // std::abs
   #include <cstdlib>
   #include <iostream>

   using namespace std;

   /* Converts temperature in Fahrenheit to Celsius. */
   double fahrenheit_to_celsius(double temp_f) {
     auto temp_c = (temp_f - 32.0) * (5.0 / 9.0);
     return temp_c;
   }

   /* This is the test function: `throws` raises an error if something is wrong. */
   void test_fahrenheit_to_celsius() {
     auto temp_c = fahrenheit_to_celsius(100.0);
     auto expected_result = 37.777777;
     try {
       if (abs(temp_c - expected_result) > 1.0e-6) throw "Error";
     } catch (char const* err) {
       cout << err;
     }
   }
   
   int main() {
     cout << fahrenheit_to_celsius(20);
     test_fahrenheit_to_celsius();
     return EXIT_SUCCESS;
   }
   ```
   
   ```{code-tab} r R

   # Converts temperature in Fahrenheit to Celsius.
   fahrenheit_to_celsius <- function(temp_f)
   {
     temp_c <- (temp_f - 32.0) * (5.0/9.0)
     temp_c
   }

   # This is the test function: `assertive::is_true` raises an error if something
   # is wrong.
   test_fahrenheit_to_celsius <- function()
   {
     temp_c <- fahrenheit_to_celsius(temp_f = 100.0)
     expected_result <- 37.777777
     assertive::is_true(abs(temp_c - expected_result) < 1.0e-6)
   }
   ```
   ```{code-tab} fortran
   program temperature_conversion

   implicit none
   call test_fahrenheit_to_celsius()

   contains

   function fahrenheit_to_celsius(temp_f) result(temp_c)
      implicit none
      real temp_f
      real temp_c
      temp_c = (temp_f - 32.0) * (5.0/9.0)
   end function fahrenheit_to_celsius

   subroutine test_fahrenheit_to_celsius()
      implicit none
      real temp_c
      real expected_result
      temp_c = fahrenheit_to_celsius(100.0)
      expected_result = 37.777777
      if( abs(temp_c - expected_result) > 1.0e-6) then
         write(*,*) 'Error'
      else
         write(*,*) 'Pass'
      end if
   end subroutine test_fahrenheit_to_celsius

   end program temperature_conversion
   ```
````

Why are we not comparing directly all digits with the expected result?

---

## Tests help preserving expected functionality

- As projects grow, it becomes easier to break things without noticing immediately
- Software defects can be caused by both human errors and non-controllable events (i.e. environmental conditions)
- Testing helps **detecting new errors early**
- Interpreted dynamically typed imperative languages often need to be tested
- So do compiled languages but the compiler catches at least some errors
- Testing is essential for research software because we care about
  reproducibility of scientific results and because derivative research and
  programs depend on research software
- "Program testing can be used to show the presence of bugs, but never to show their absence!" (Edsger W. Dijkstra)

---

## Tests help users of your code

- Make it easier for others to verify whether the code has been correctly installed
- Provide basis to judge the quality of the code
- Users of your code publish papers based on results produced by your code
- Your peers need to be able to reproduce your (to be) published computational results

---

## Tests help other developers

- Tests make it easier to **refactor the code** (rewrite code while keeping functionality)
- Code can become unsustainable without runnable tests and becomes legacy software (i.e. software outdated and not usable anymore)
- Documentation which is up to date by definition
- Easier for external developers to contribute to the project without breaking your code
  (**you may immediately see problems in your code but others may not**)
  - You are confident accepting contributions
  - *You* can confidently improve your code

```{figure} img/suit.jpg
:alt: Old-fashioned diving suit
:width: 300px

Suiting up to modify untested code.
```

---

## Tests help managing complexity


### Good code: pure and easy to test

"Pure": no side effects.
We already know how to test this code (see above):

````{tabs}
   ```{code-tab} py

   def fahrenheit_to_celsius(temp_f):
       temp_c = (temp_f - 32.0) * (5.0/9.0)
       return temp_c

   temp_c = fahrenheit_to_celsius(temp_f=100.0)
   print(temp_c)
   ```

   ```{code-tab} c++

   #include <cstdlib>
   #include <iostream>

   /* Converts temperature in Fahrenheit to Celsius. */
   double fahrenheit_to_celsius(double temp_f) {
     auto temp_c = (temp_f - 32.0) * (5.0 / 9.0);
     return temp_c;
   }

   int main() {
     auto temp_c = fahrenheit_to_celsius(20);
     std::cout << temp_c << std::endl;
     return EXIT_SUCCESS;
   }
   ```

   ```{code-tab} r R

   fahrenheit_to_celsius <- function(temp_f)
   {
     temp_c <- (temp_f - 32.0) * (5.0/9.0)
     temp_c
   }

   temp_c <- fahrenheit_to_celsius(temp_f = 100.0)
   print(temp_c)
   ```
   ```{code-tab} fortran
   function fahrenheit_to_celsius(temp_f) result(temp_c)
   implicit none
   real temp_f
   real temp_c
   temp_c = (temp_f - 32.0) * (5.0/9.0)
   end function fahrenheit_to_celsius

   temp_c = fahrenheit_to_celsius(100.0)
   write(*,*) temp_c
   ```
````


### Less good code: has side effects and is difficult to test

How would you test this code:

````{tabs}
   ```{code-tab} py

   f_to_c_offset = 32.0
   f_to_c_factor = 0.555555555
   temp_c = 0.0

   def fahrenheit_to_celsius_bad(temp_f):
       global temp_c
       temp_c = (temp_f - f_to_c_offset) * f_to_c_factor

   fahrenheit_to_celsius_bad(temp_f=100.0)
   print(temp_c)
   ```

   ```{code-tab} c++

   #include <cstdlib>
   #include <iostream>

   constexpr double f_to_c_offset = 32.0;
   constexpr double f_to_c_factor = 0.555555555;
   double temp_c = 0.0;

   /* Converts temperature in Fahrenheit to Celsius. */
   void fahrenheit_to_celsius(double temp_f) {
     temp_c = (temp_f - f_to_c_offset) * f_to_c_factor;
   }

   int main() {
     fahrenheit_to_celsius(20);
     std::cout << temp_c << std::endl;
     return EXIT_SUCCESS;
   }
   ```

   ```{code-tab} r R

   f_to_c_offset <- 32.0
   f_to_c_factor <- 0.555555555
   temp_c <- 0.0

   fahrenheit_to_celsius_bad <- function(temp_f)
   {
     temp_c <<- (temp_f - f_to_c_offset) * f_to_c_factor
   }

   fahrenheit_to_celsius_bad(temp_f = 100.0)
   print(temp_c)
   ```
   ```{code-tab} fortran
   real f_to_c_offset = 32.0
   real f_to_c_factor = 0.555555555

   function fahrenheit_to_celsius_bad(temp_f) result(temp_c)
      implicit none
      real temp_f
      real temp_c
      temp_c = (temp_f - f_to_c_offset) * f_to_c_factor
   end function fahrenheit_to_celsius_bad

   temp_c = fahrenheit_to_celsius_bad(100.0)
   write(*,*) temp_c
   ```
````

> ## Tests guide towards modular code structure
>
> - Well structured code (modular code) is easy to test
> - "Badly" structured code is difficult to test automatically
> - If you make it easier to test, it becomes more modular
> - To make code more modular, maybe start by thinking about how to make it testable if you need inspiration?
{: .discussion}

---

> ## Discussion: When is it OK not to add tests?
>
> **It is always a balance: there is no "always"/"never"**.
> - Jupyter or R Markdown notebook which produces a plot and you know by
>   looking at the plot whether it worked?
> - A short, "obviously correct" Python or R script which you never intend to reuse?
> - A simple short, "obviously correct" shell script?
> - Can you give other examples?
{: .discussion}
