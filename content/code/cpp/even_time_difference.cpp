#include <chrono>
#include <stdexcept>

/* Checks whether temperature is above max_temperature and returns a status. */
bool check_time_to_now_even(int seconds) {
	if(seconds<0){
		throw std::runtime_error('received negative input');
	}
  auto now = std::chrono::system_clock::now().time_since_epoch();
    return std::chrono::duration_cast<std::chrono::seconds>(now).count()%seconds ==0;
}
