@testset "Test count word occurrence in string" begin
    @test count_word_occurrence_in_string("AAA BBB", "AAA") == 1
    @test count_word_occurrence_in_string("AAA AAA", "AAA") == 2
    @test count_word_occurrence_in_string("AAAAA", "AAA") == 1
end
