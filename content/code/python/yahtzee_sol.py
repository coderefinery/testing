def test_roll_dice():
    random.seed(0)
    assert roll_dice(5) == [4, 4, 1, 3, 5]
    assert roll_dice(5) == [4, 4, 3, 4, 3]
    assert roll_dice(5) == [5, 2, 5, 2, 3]


import pytest
def test_yahtzee():
    random.seed(1)
    n_tests = 1_000_000

    winning_games = list(
        filter(
            lambda x: x == 5,
            [yahtzee() for _ in range(n_tests)],
        )
    )

    assert len(winning_games) / n_tests == pytest.approx(0.046, abs=0.01)
