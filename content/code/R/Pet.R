Pet <- function(name) {
  structure(
    list(name = name, hunger = 0),
    class = "Pet"
  )
}

# How would you test this function?
take_for_a_walk <- function(pet) UseMethod("take_for_a_walk")
take_for_a_walk.Pet <- function(pet) {
  pet$hunger <- pet$hunger + 1
  pet
}
