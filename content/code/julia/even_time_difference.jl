# Importing modules inside functions is not allowed in Julia and must be done at top-level
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
