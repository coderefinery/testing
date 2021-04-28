# the closest thing to a class in Julia is a `mutable struct`
mutable struct Pet
    name::String
    hunger::Int64
end

function go_for_a_walk!(pet::Pet)
    pet.hunger += 1
end
