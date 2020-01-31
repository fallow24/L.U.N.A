cmake_minimum_required(VERSION 2.8.3)
project(lms100)

find_package(catkin REQUIRED COMPONENTS
  std_msgs
  message_generation
  roscpp
)


catkin_package(
 CATKIN_DEPENDS std_msgs message_runtime
)

include_directories(
  ${catkin_INCLUDE_DIRS}
  include
)

add_executable(scanlistener src/scanlistener.cc)
target_link_libraries(scanlistener ${catkin_LIBRARIES})

add_executable(sicksensor src/sicksensor.cc src/lms100_cola.cc)
target_link_libraries(sicksensor ${catkin_LIBRARIES})

