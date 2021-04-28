@testset "Test factorial function" begin
    @test_throws DomainError factorial(-1)
    @test factorial(3) == 6
end
