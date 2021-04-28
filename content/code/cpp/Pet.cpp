#include <string>

class Pet {
 private:
  unsigned int hunger_{0};
  std::string name_{};

 public:
  explicit Pet(std::string name) : name_(name) {}
  void go_for_a_walk() { hunger_ += 1; }
  // ^-- how would you test this function?
  unsigned int hunger() const { return hunger_; }
};
