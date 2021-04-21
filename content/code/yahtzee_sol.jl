using Test

@testset "test roll_dice" begin
    # fix random seed
    Random.seed!(1234);
    # known sequence for given seed
    exp_first_throw = [1, 3, 5, 1, 6]
    exp_second_throw = [1, 6, 4, 5, 4]
    exp_third_throw = [1, 2, 5, 3, 2]

    n_dice = 5
    sides=(1,2,3,4,5,6)
    throw = roll_dice(n_dice, sides)
    @test throw == exp_first_throw
    throw = roll_dice(n_dice, sides)
    @test throw == exp_second_throw
    throw = roll_dice(n_dice, sides)
    @test throw == exp_third_throw
end

@testset "testing yahtzee" begin
    # try a million throws and see if we get close
    # to the statistical average of 4.6%
    # (https://en.wikipedia.org/wiki/Yahtzee#Probabilities)
    n_yahtzees = 0
    n_tests = 1_000_000
    for i in 1:n_tests
        collected_side, n_collected = yahtzee()
        if n_collected == 5
            n_yahtzees += 1
        end
    end
    @test n_yahtzees/n_tests ≈ 0.046 atol=0.001
end
