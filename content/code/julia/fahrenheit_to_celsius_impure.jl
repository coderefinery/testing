f_to_c_offset = 32.0
f_to_c_factor = 0.555555555
temp_c = 0.0

function fahrenheit_to_celsius(temp_f)
    global temp_c
    temp_c = (temp_f - f_to_c_offset) * f_to_c_factor
end

fahrenheit_to_celsius(100.0)
println(temp_c)
