function fahrenheit_to_celsius(temp_f)
    temp_c = (temp_f - 32.0) * (5.0/9.0)
    return temp_c
end

temp_c = fahrenheit_to_celsius(100.0)
println(temp_c)
