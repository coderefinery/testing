import pytest

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
    expected_result = [1, 2, "Fizz", 4, "Buzz", "Fizz",
                       7, 8, "Fizz", "Buzz", 11, "Fizz",
                       13, 14, "FizzBuzz", 16, 17, "Fizz", 19, "Buzz"]
    obtained_result = [fizzbuzz(i) for i in range(1, 21)]

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
    for i in range(1, 100):
        print(fizzbuzz(i))

if __name__ == "__main__":
    main()
