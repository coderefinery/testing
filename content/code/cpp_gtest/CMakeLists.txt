cmake_minimum_required(VERSION 3.14)
project(test_example CXX)

cmake_policy(SET CMP0135 OLD)

#Tell CMake to Download Googletest library
include(FetchContent)
FetchContent_Declare(
    googletest
    URL https://github.com/google/googletest/archive/03597a01ee50ed33e9dfd640b249b4be3799d395.zip
)
# For Windows: Prevent overriding the parent project's compiler/linker settings
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(googletest)

#Setup testing
enable_testing()
#add test executable
add_executable(example example.cc)
#link Googletest to example
target_link_libraries(example GTest::gtest_main)
#Make googletest look for tests
include(GoogleTest)
gtest_discover_tests(example)
