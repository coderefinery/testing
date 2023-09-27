# create the mutable struct and test it
@testset "Test mutable struct" begin
    p = Pet("fido", 0)
    @test p.hunger == 0
    go_for_a_walk!(p)
    @test p.hunger == 1
    p.hunger = -1
    go_for_a_walk!(p)
    @test p.hunger == 0
end
