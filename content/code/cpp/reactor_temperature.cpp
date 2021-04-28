#include "constants.hpp"
/* ^--- Defines the max_temperature constant as:
* namespace constants {
* constexpr double max_temperature = 100.0;
* }
*/

enum class ReactorState : int { FINE, CRITICAL };

/* Checks whether temperature is above max_temperature and returns a status. */
ReactorState check_reactor_temperature(double temperature_celsius) {
  return temperature_celsius > constants::max_temperature
	     ? ReactorState::CRITICAL
	     : ReactorState::FINE;
}
