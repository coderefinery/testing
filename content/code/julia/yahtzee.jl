using Random

"""
    roll_dice(n_dice::Int=5, sides=(1,2,3,4,5,6))

Returns array of n_dice random integers corresponding to the sides of dice
"""
function roll_dice(n_dice::Int=5, sides=(1,2,3,4,5,6))
    return [rand(sides) for i in 1:n_dice]
end

"""
    yahtzee()

Play Yahtzee with 5 6-sided dice and 3 throws.
Collect as many of the same dice side as possible.
Returns a tuple with the collected side (e.g. 4's) and
how many of that side (between 1 and 5).
"""
function yahtzee()
    sides = (1,2,3,4,5,6)
    n_dice = 5
    # we first throw all dice
    first_throw = roll_dice(n_dice, sides)
    # count how many times each side comes up
    side_counts = [count(x->x==i,first_throw) for i in sides]
    # collected_side is the dice side we will start collecting
    n_collected, collected_side = findmax(side_counts)
    if n_collected == 5
        return collected_side, n_collected
    end

    # now we throw n_dice-n_collected dice and hope to get more collected_side
    second_throw = roll_dice(n_dice-n_collected, sides)
    n_new_matches = count(x->x==collected_side,second_throw)
    n_collected += n_new_matches
    if n_collected == 5
        return collected_side, n_collected
    end

    # final throw...
    third_throw = roll_dice(n_dice-n_collected, sides)
    n_new_matches = count(x->x==collected_side,third_throw)
    n_collected += n_new_matches

    return collected_side, n_collected
end


for i in 1:10
    collected_side, n_collected = yahtzee()
    println("We got $n_collected $collected_side's in this round")
    if n_collected == 5
        println("Yay, it's a Yahtzee!")
    end
end
