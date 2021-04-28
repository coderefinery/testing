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
