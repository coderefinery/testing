function myadd(a,b) 
    return a+b
end

using Test
@testset "myadd" begin
    @test myadd(2,3) == 5
end