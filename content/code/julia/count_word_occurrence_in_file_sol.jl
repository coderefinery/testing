@testset "Test count word occurrence in file" begin
    msg = "one two one two three four"
    (fname, testio) = mktemp()
    println(testio, msg)
    close(testio)
    @test count_word_occurrence_in_file(fname, "one") == 2
    @test count_word_occurrence_in_file(fname, "three") == 1
    @test count_word_occurrence_in_file(fname, "six") == 0
end
