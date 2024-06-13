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
