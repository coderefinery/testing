cmake_minimum_required(VERSION 3.14)
project(test_example CXX)

cmake_policy(SET CMP0135 OLD)

#Tell CMake to Download Catch2 library
include(FetchContent)
FetchContent_Declare(
    Catch2
    GIT_REPOSITORY https://github.com/catchorg/Catch2.git
    GIT_TAG        v3.4.0 # or a later release
)
FetchContent_MakeAvailable(Catch2)

#Setup testing
enable_testing()
#add test executable
add_executable(example example.cc)
#link Catch2 to example
target_link_libraries(example PRIVATE Catch2::Catch2WithMain)
#Make Catch2 look for tests
include(Catch)
catch_discover_tests(example)
