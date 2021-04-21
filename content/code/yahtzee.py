import random
from collections import Counter


def roll_dice(num_dice):
    return [random.choice([1, 2, 3, 4, 5, 6]) for _ in range(num_dice)]


def yahtzee():
    """
    Play yahtzee with 5 6-sided dice and 3 throws.
    Collect as many of the same dice side as possible.
    Returns the number of same sides.
    """

    # first throw
    result = roll_dice(5)
    most_common_side, how_often = Counter(result).most_common(1)[0]

    # we keep the most common side
    target_side = most_common_side
    num_same_sides = how_often
    if num_same_sides == 5:
        return 5

    # second and third throw
    for _ in [2, 3]:
        throw = roll_dice(5 - num_same_sides)
        num_same_sides += Counter(throw)[target_side]
        if num_same_sides == 5:
            return 5

    return num_same_sides


if __name__ == "__main__":
    num_games = 100

    winning_games = list(
        filter(
            lambda x: x == 5,
            [yahtzee() for _ in range(num_games)],
        )
    )

    print(f"out of the {num_games} games, {len(winning_games)} got a yahtzee!")
