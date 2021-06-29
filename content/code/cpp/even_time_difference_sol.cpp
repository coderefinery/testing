// Changing variables included from headers (monkey patching) is not possible in C++. Instead we refactor the function to make it pure.
//Another way would be to use templates for dependency injection
#include <catch2/catch.hpp>

//Making it pure
bool check_time_to_now_even(int seconds, int current_time) {
	if(seconds<0){
		throw std::runtime_error('received negative input');
	}
    return (current_time-seconds)%2 ==0;
}

// Normal invocation
auto now = std::chrono::system_clock::now().time_since_epoch();
int current_time_seconds=std::chrono::duration_cast<std::chrono::seconds>(now).count();
check_time_to_now_even(4,current_time_seconds);


TEST_CASE("Check time difference", "[reactor_state]") {
  REQUIRE(check_time_to_now_even(1,3) == true);
  REQUIRE(check_time_to_now_even(4,5) == false);
}


//using templates

template< class CLOCK>
bool check_time_to_now_even(int seconds){
  	if(seconds<0){
		throw std::runtime_error('received negative input');
	}
  int current_time=CLOCK.getNowSeconds();
  return (current_time-seconds)%2 ==0;
}

//Normal invocation
class ChronoClock{

int getNowSeconds(){
  auto now = std::chrono::system_clock::now().time_since_epoch();
 return std::chrono::duration_cast<std::chrono::seconds>(now).count();
}

};

check_time_to_now_even<ChronoClock>(3);

class TestClock{

int getNowSeconds(){
 return 3;
}

};

TEST_CASE("Check time difference", "[reactor_state]") {
  REQUIRE(check_time_to_now_even<TestClock>(3) == true);
  REQUIRE(check_time_to_now_even<TestClock>(4) == false);
}