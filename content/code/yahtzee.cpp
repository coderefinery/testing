#include <cstdlib>
#include <iostream>
#include <random>
#include <tuple>
#include <vector>

/* Roll a fair die n_dice times. The faces of the die can be set (default is 1 to 6).
 * The PRNG engine is moved in the function such that changes in its state are propagated back to the caller.
 */
template <typename PRNGEngine = decltype(std::default_random_engine())>
std::vector<unsigned int> roll_dice(
    unsigned int n_dice = 5,
    std::vector<unsigned int> faces = {1, 2, 3, 4, 5, 6},
    PRNGEngine&& gen = std::default_random_engine(std::random_device()())) {
  // create a fair die
  auto weights = std::vector<double>(faces.size(), 1.0);
  auto fair_dice =
      std::discrete_distribution<unsigned int>(weights.begin(), weights.end());

  auto rolls = std::vector<unsigned int>(n_dice, 0);
  for (auto i = 0u; i < n_dice; ++i) {
    rolls[i] = faces[fair_dice(gen)];
  }

  return rolls;
}

/* count how many times each face comes up */
std::vector<unsigned int> count(const std::vector<unsigned int>& toss,
				const std::vector<unsigned int>& faces = {
				    1, 2, 3, 4, 5, 6}) {
  auto face_counts = std::vector<unsigned int>(faces.size(), 0);
  for (auto i = 0; i < faces.size(); ++i) {
    face_counts[i] = std::count(toss.cbegin(), toss.cend(), faces[i]);
  }
  return face_counts;
}

std::tuple<unsigned int, unsigned int> yahtzee() {
  auto n_dice = 5;
  auto faces = std::vector<unsigned int>{1, 2, 3, 4, 5, 6};
  auto toss = [faces](unsigned int n_dice) { return roll_dice(n_dice, faces); };
  // throw all dice
  auto first_toss = toss(n_dice);
  auto face_counts = count(first_toss);

  auto it_max = std::max_element(face_counts.cbegin(), face_counts.cend());
  // number of faces that showed the most
  auto n_collected = *it_max;
  // corresponding index in the array, will be used to get which face showed up
  // the most
  auto idx_max = std::distance(face_counts.cbegin(), it_max);

  // all 5 dice showed the same face! YAHTZEE!
  if (n_collected == 5) return std::make_tuple(faces[idx_max], n_collected);

  // no yahtzee :(
  // we throw (n_dice - n_collected) dice
  auto second_toss = toss(n_dice - n_collected);
  n_collected += count(second_toss, {faces[idx_max]})[0];
  // YAHTZEE!
  if (n_collected == 5) return std::make_tuple(faces[idx_max], n_collected);

  // final chance
  auto third_toss = toss(n_dice - n_collected);
  n_collected += count(third_toss, {faces[idx_max]})[0];

  return std::make_tuple(faces[idx_max], n_collected);
}

int main() {
  for (auto i = 0; i < 100; ++i) {
    unsigned int value = 0, times = 0;
    std::tie(value, times) = yahtzee();
    std::cout << "We got " << value << " " << times << " times in round " << i
	      << std::endl;
    if (times == 5) {
      std::cout << "YAHTZEE in round " << i << std::endl;
    }
  }

  return EXIT_SUCCESS;
}
