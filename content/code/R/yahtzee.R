#' Roll a fair die num_dice times.
#' Collect as many of the same dice side as possible.
#'
#' @return A vector of die throw results
roll_dice <- function(num_dice) {
  ceiling(runif(num_dice, 0, 6))
}

#' Play yahtzee with 5 6-sided dice and 3 throws.
#' Collect as many of the same dice side as possible.
#'
#' @return The number of same sides
yahtzee <- function() {
  res <- roll_dice(5)
  most_common_side <- as.numeric(names(table(res)[which.max(table(res))]))[1]
  how_often <- as.vector(table(res)[which.max(table(res))])[1]

  # we keep the most common side
  target_side <- most_common_side
  num_same_sides <- how_often
  if (num_same_sides == 5) {
    return(5)
  }

  # second and third throw
  for (i in 2:3) {
    throw <- roll_dice(5 - num_same_sides)
    num_same_sides <- num_same_sides + sum(throw == target_side)

    if (num_same_sides == 5) {
      return(5)
    }
  }
  return(num_same_sides)
}
