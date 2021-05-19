using Test

"""
    fahrenheit_to_celsius(temp_f::Float)

Converts temperature in Fahrenheit to Celsius.
"""
function fahrenheit_to_celsius(temp_f)
    temp_c = (temp_f - 32.0) * (5.0/9.0)
    return temp_c
end


# This is the test section
@testset "Test fahrenheit_to_celsius" begin
    temp_c = fahrenheit_to_celsius(100.0)
    expected_result = 37.777777
    @test abs(temp_c - expected_result) < 1.0e-6
end
