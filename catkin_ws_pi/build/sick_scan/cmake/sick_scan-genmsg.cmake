# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "sick_scan: 8 messages, 0 services")

set(MSG_I_FLAGS "-Isick_scan:/home/ubuntu/catkin_ws/src/sick_scan/msg;-Istd_msgs:/opt/ros/kinetic/share/std_msgs/cmake/../msg;-Igeometry_msgs:/opt/ros/kinetic/share/geometry_msgs/cmake/../msg;-Isensor_msgs:/opt/ros/kinetic/share/sensor_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(sick_scan_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderEncoderBlock.msg" NAME_WE)
add_custom_target(_sick_scan_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sick_scan" "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderEncoderBlock.msg" ""
)

get_filename_component(_filename "/home/ubuntu/catkin_ws/src/sick_scan/msg/SickImu.msg" NAME_WE)
add_custom_target(_sick_scan_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sick_scan" "/home/ubuntu/catkin_ws/src/sick_scan/msg/SickImu.msg" "geometry_msgs/Quaternion:geometry_msgs/Vector3:std_msgs/Header:sensor_msgs/Imu"
)

get_filename_component(_filename "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderMeasurementParam1Block.msg" NAME_WE)
add_custom_target(_sick_scan_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sick_scan" "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderMeasurementParam1Block.msg" ""
)

get_filename_component(_filename "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeader.msg" NAME_WE)
add_custom_target(_sick_scan_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sick_scan" "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeader.msg" "sick_scan/RadarPreHeaderEncoderBlock:sick_scan/RadarPreHeaderStatusBlock:sick_scan/RadarPreHeaderDeviceBlock:sick_scan/RadarPreHeaderMeasurementParam1Block"
)

get_filename_component(_filename "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarObject.msg" NAME_WE)
add_custom_target(_sick_scan_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sick_scan" "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarObject.msg" "geometry_msgs/Pose:geometry_msgs/Quaternion:geometry_msgs/Point:geometry_msgs/Vector3:geometry_msgs/PoseWithCovariance:geometry_msgs/Twist:geometry_msgs/TwistWithCovariance"
)

get_filename_component(_filename "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarScan.msg" NAME_WE)
add_custom_target(_sick_scan_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sick_scan" "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarScan.msg" "sick_scan/RadarObject:geometry_msgs/Twist:std_msgs/Header:sick_scan/RadarPreHeaderMeasurementParam1Block:sick_scan/RadarPreHeader:sick_scan/RadarPreHeaderStatusBlock:geometry_msgs/Vector3:geometry_msgs/Point:sensor_msgs/PointField:geometry_msgs/Pose:sick_scan/RadarPreHeaderEncoderBlock:geometry_msgs/PoseWithCovariance:sick_scan/RadarPreHeaderDeviceBlock:geometry_msgs/Quaternion:geometry_msgs/TwistWithCovariance:sensor_msgs/PointCloud2"
)

get_filename_component(_filename "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderDeviceBlock.msg" NAME_WE)
add_custom_target(_sick_scan_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sick_scan" "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderDeviceBlock.msg" ""
)

get_filename_component(_filename "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderStatusBlock.msg" NAME_WE)
add_custom_target(_sick_scan_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sick_scan" "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderStatusBlock.msg" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(sick_scan
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderEncoderBlock.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sick_scan
)
_generate_msg_cpp(sick_scan
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/SickImu.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/Imu.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sick_scan
)
_generate_msg_cpp(sick_scan
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderMeasurementParam1Block.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sick_scan
)
_generate_msg_cpp(sick_scan
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeader.msg"
  "${MSG_I_FLAGS}"
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderEncoderBlock.msg;/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderStatusBlock.msg;/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderDeviceBlock.msg;/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderMeasurementParam1Block.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sick_scan
)
_generate_msg_cpp(sick_scan
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarObject.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/TwistWithCovariance.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sick_scan
)
_generate_msg_cpp(sick_scan
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarScan.msg"
  "${MSG_I_FLAGS}"
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarObject.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderMeasurementParam1Block.msg;/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeader.msg;/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderStatusBlock.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/PointField.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose.msg;/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderEncoderBlock.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderDeviceBlock.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/TwistWithCovariance.msg;/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/PointCloud2.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sick_scan
)
_generate_msg_cpp(sick_scan
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderDeviceBlock.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sick_scan
)
_generate_msg_cpp(sick_scan
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderStatusBlock.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sick_scan
)

### Generating Services

### Generating Module File
_generate_module_cpp(sick_scan
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sick_scan
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(sick_scan_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(sick_scan_generate_messages sick_scan_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderEncoderBlock.msg" NAME_WE)
add_dependencies(sick_scan_generate_messages_cpp _sick_scan_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ubuntu/catkin_ws/src/sick_scan/msg/SickImu.msg" NAME_WE)
add_dependencies(sick_scan_generate_messages_cpp _sick_scan_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderMeasurementParam1Block.msg" NAME_WE)
add_dependencies(sick_scan_generate_messages_cpp _sick_scan_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeader.msg" NAME_WE)
add_dependencies(sick_scan_generate_messages_cpp _sick_scan_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarObject.msg" NAME_WE)
add_dependencies(sick_scan_generate_messages_cpp _sick_scan_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarScan.msg" NAME_WE)
add_dependencies(sick_scan_generate_messages_cpp _sick_scan_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderDeviceBlock.msg" NAME_WE)
add_dependencies(sick_scan_generate_messages_cpp _sick_scan_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderStatusBlock.msg" NAME_WE)
add_dependencies(sick_scan_generate_messages_cpp _sick_scan_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(sick_scan_gencpp)
add_dependencies(sick_scan_gencpp sick_scan_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS sick_scan_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(sick_scan
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderEncoderBlock.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sick_scan
)
_generate_msg_eus(sick_scan
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/SickImu.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/Imu.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sick_scan
)
_generate_msg_eus(sick_scan
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderMeasurementParam1Block.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sick_scan
)
_generate_msg_eus(sick_scan
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeader.msg"
  "${MSG_I_FLAGS}"
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderEncoderBlock.msg;/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderStatusBlock.msg;/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderDeviceBlock.msg;/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderMeasurementParam1Block.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sick_scan
)
_generate_msg_eus(sick_scan
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarObject.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/TwistWithCovariance.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sick_scan
)
_generate_msg_eus(sick_scan
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarScan.msg"
  "${MSG_I_FLAGS}"
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarObject.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderMeasurementParam1Block.msg;/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeader.msg;/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderStatusBlock.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/PointField.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose.msg;/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderEncoderBlock.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderDeviceBlock.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/TwistWithCovariance.msg;/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/PointCloud2.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sick_scan
)
_generate_msg_eus(sick_scan
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderDeviceBlock.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sick_scan
)
_generate_msg_eus(sick_scan
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderStatusBlock.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sick_scan
)

### Generating Services

### Generating Module File
_generate_module_eus(sick_scan
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sick_scan
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(sick_scan_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(sick_scan_generate_messages sick_scan_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderEncoderBlock.msg" NAME_WE)
add_dependencies(sick_scan_generate_messages_eus _sick_scan_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ubuntu/catkin_ws/src/sick_scan/msg/SickImu.msg" NAME_WE)
add_dependencies(sick_scan_generate_messages_eus _sick_scan_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderMeasurementParam1Block.msg" NAME_WE)
add_dependencies(sick_scan_generate_messages_eus _sick_scan_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeader.msg" NAME_WE)
add_dependencies(sick_scan_generate_messages_eus _sick_scan_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarObject.msg" NAME_WE)
add_dependencies(sick_scan_generate_messages_eus _sick_scan_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarScan.msg" NAME_WE)
add_dependencies(sick_scan_generate_messages_eus _sick_scan_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderDeviceBlock.msg" NAME_WE)
add_dependencies(sick_scan_generate_messages_eus _sick_scan_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderStatusBlock.msg" NAME_WE)
add_dependencies(sick_scan_generate_messages_eus _sick_scan_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(sick_scan_geneus)
add_dependencies(sick_scan_geneus sick_scan_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS sick_scan_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(sick_scan
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderEncoderBlock.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sick_scan
)
_generate_msg_lisp(sick_scan
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/SickImu.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/Imu.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sick_scan
)
_generate_msg_lisp(sick_scan
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderMeasurementParam1Block.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sick_scan
)
_generate_msg_lisp(sick_scan
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeader.msg"
  "${MSG_I_FLAGS}"
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderEncoderBlock.msg;/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderStatusBlock.msg;/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderDeviceBlock.msg;/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderMeasurementParam1Block.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sick_scan
)
_generate_msg_lisp(sick_scan
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarObject.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/TwistWithCovariance.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sick_scan
)
_generate_msg_lisp(sick_scan
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarScan.msg"
  "${MSG_I_FLAGS}"
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarObject.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderMeasurementParam1Block.msg;/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeader.msg;/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderStatusBlock.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/PointField.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose.msg;/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderEncoderBlock.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderDeviceBlock.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/TwistWithCovariance.msg;/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/PointCloud2.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sick_scan
)
_generate_msg_lisp(sick_scan
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderDeviceBlock.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sick_scan
)
_generate_msg_lisp(sick_scan
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderStatusBlock.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sick_scan
)

### Generating Services

### Generating Module File
_generate_module_lisp(sick_scan
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sick_scan
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(sick_scan_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(sick_scan_generate_messages sick_scan_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderEncoderBlock.msg" NAME_WE)
add_dependencies(sick_scan_generate_messages_lisp _sick_scan_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ubuntu/catkin_ws/src/sick_scan/msg/SickImu.msg" NAME_WE)
add_dependencies(sick_scan_generate_messages_lisp _sick_scan_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderMeasurementParam1Block.msg" NAME_WE)
add_dependencies(sick_scan_generate_messages_lisp _sick_scan_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeader.msg" NAME_WE)
add_dependencies(sick_scan_generate_messages_lisp _sick_scan_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarObject.msg" NAME_WE)
add_dependencies(sick_scan_generate_messages_lisp _sick_scan_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarScan.msg" NAME_WE)
add_dependencies(sick_scan_generate_messages_lisp _sick_scan_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderDeviceBlock.msg" NAME_WE)
add_dependencies(sick_scan_generate_messages_lisp _sick_scan_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderStatusBlock.msg" NAME_WE)
add_dependencies(sick_scan_generate_messages_lisp _sick_scan_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(sick_scan_genlisp)
add_dependencies(sick_scan_genlisp sick_scan_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS sick_scan_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(sick_scan
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderEncoderBlock.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sick_scan
)
_generate_msg_nodejs(sick_scan
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/SickImu.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/Imu.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sick_scan
)
_generate_msg_nodejs(sick_scan
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderMeasurementParam1Block.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sick_scan
)
_generate_msg_nodejs(sick_scan
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeader.msg"
  "${MSG_I_FLAGS}"
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderEncoderBlock.msg;/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderStatusBlock.msg;/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderDeviceBlock.msg;/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderMeasurementParam1Block.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sick_scan
)
_generate_msg_nodejs(sick_scan
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarObject.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/TwistWithCovariance.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sick_scan
)
_generate_msg_nodejs(sick_scan
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarScan.msg"
  "${MSG_I_FLAGS}"
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarObject.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderMeasurementParam1Block.msg;/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeader.msg;/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderStatusBlock.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/PointField.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose.msg;/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderEncoderBlock.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderDeviceBlock.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/TwistWithCovariance.msg;/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/PointCloud2.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sick_scan
)
_generate_msg_nodejs(sick_scan
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderDeviceBlock.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sick_scan
)
_generate_msg_nodejs(sick_scan
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderStatusBlock.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sick_scan
)

### Generating Services

### Generating Module File
_generate_module_nodejs(sick_scan
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sick_scan
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(sick_scan_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(sick_scan_generate_messages sick_scan_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderEncoderBlock.msg" NAME_WE)
add_dependencies(sick_scan_generate_messages_nodejs _sick_scan_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ubuntu/catkin_ws/src/sick_scan/msg/SickImu.msg" NAME_WE)
add_dependencies(sick_scan_generate_messages_nodejs _sick_scan_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderMeasurementParam1Block.msg" NAME_WE)
add_dependencies(sick_scan_generate_messages_nodejs _sick_scan_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeader.msg" NAME_WE)
add_dependencies(sick_scan_generate_messages_nodejs _sick_scan_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarObject.msg" NAME_WE)
add_dependencies(sick_scan_generate_messages_nodejs _sick_scan_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarScan.msg" NAME_WE)
add_dependencies(sick_scan_generate_messages_nodejs _sick_scan_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderDeviceBlock.msg" NAME_WE)
add_dependencies(sick_scan_generate_messages_nodejs _sick_scan_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderStatusBlock.msg" NAME_WE)
add_dependencies(sick_scan_generate_messages_nodejs _sick_scan_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(sick_scan_gennodejs)
add_dependencies(sick_scan_gennodejs sick_scan_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS sick_scan_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(sick_scan
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderEncoderBlock.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sick_scan
)
_generate_msg_py(sick_scan
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/SickImu.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/Imu.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sick_scan
)
_generate_msg_py(sick_scan
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderMeasurementParam1Block.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sick_scan
)
_generate_msg_py(sick_scan
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeader.msg"
  "${MSG_I_FLAGS}"
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderEncoderBlock.msg;/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderStatusBlock.msg;/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderDeviceBlock.msg;/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderMeasurementParam1Block.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sick_scan
)
_generate_msg_py(sick_scan
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarObject.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/TwistWithCovariance.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sick_scan
)
_generate_msg_py(sick_scan
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarScan.msg"
  "${MSG_I_FLAGS}"
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarObject.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderMeasurementParam1Block.msg;/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeader.msg;/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderStatusBlock.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/PointField.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Pose.msg;/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderEncoderBlock.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/PoseWithCovariance.msg;/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderDeviceBlock.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/kinetic/share/geometry_msgs/cmake/../msg/TwistWithCovariance.msg;/opt/ros/kinetic/share/sensor_msgs/cmake/../msg/PointCloud2.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sick_scan
)
_generate_msg_py(sick_scan
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderDeviceBlock.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sick_scan
)
_generate_msg_py(sick_scan
  "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderStatusBlock.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sick_scan
)

### Generating Services

### Generating Module File
_generate_module_py(sick_scan
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sick_scan
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(sick_scan_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(sick_scan_generate_messages sick_scan_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderEncoderBlock.msg" NAME_WE)
add_dependencies(sick_scan_generate_messages_py _sick_scan_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ubuntu/catkin_ws/src/sick_scan/msg/SickImu.msg" NAME_WE)
add_dependencies(sick_scan_generate_messages_py _sick_scan_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderMeasurementParam1Block.msg" NAME_WE)
add_dependencies(sick_scan_generate_messages_py _sick_scan_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeader.msg" NAME_WE)
add_dependencies(sick_scan_generate_messages_py _sick_scan_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarObject.msg" NAME_WE)
add_dependencies(sick_scan_generate_messages_py _sick_scan_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarScan.msg" NAME_WE)
add_dependencies(sick_scan_generate_messages_py _sick_scan_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderDeviceBlock.msg" NAME_WE)
add_dependencies(sick_scan_generate_messages_py _sick_scan_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/ubuntu/catkin_ws/src/sick_scan/msg/RadarPreHeaderStatusBlock.msg" NAME_WE)
add_dependencies(sick_scan_generate_messages_py _sick_scan_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(sick_scan_genpy)
add_dependencies(sick_scan_genpy sick_scan_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS sick_scan_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sick_scan)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sick_scan
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(sick_scan_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()
if(TARGET geometry_msgs_generate_messages_cpp)
  add_dependencies(sick_scan_generate_messages_cpp geometry_msgs_generate_messages_cpp)
endif()
if(TARGET sensor_msgs_generate_messages_cpp)
  add_dependencies(sick_scan_generate_messages_cpp sensor_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sick_scan)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sick_scan
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(sick_scan_generate_messages_eus std_msgs_generate_messages_eus)
endif()
if(TARGET geometry_msgs_generate_messages_eus)
  add_dependencies(sick_scan_generate_messages_eus geometry_msgs_generate_messages_eus)
endif()
if(TARGET sensor_msgs_generate_messages_eus)
  add_dependencies(sick_scan_generate_messages_eus sensor_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sick_scan)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sick_scan
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(sick_scan_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()
if(TARGET geometry_msgs_generate_messages_lisp)
  add_dependencies(sick_scan_generate_messages_lisp geometry_msgs_generate_messages_lisp)
endif()
if(TARGET sensor_msgs_generate_messages_lisp)
  add_dependencies(sick_scan_generate_messages_lisp sensor_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sick_scan)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sick_scan
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(sick_scan_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()
if(TARGET geometry_msgs_generate_messages_nodejs)
  add_dependencies(sick_scan_generate_messages_nodejs geometry_msgs_generate_messages_nodejs)
endif()
if(TARGET sensor_msgs_generate_messages_nodejs)
  add_dependencies(sick_scan_generate_messages_nodejs sensor_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sick_scan)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sick_scan\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sick_scan
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(sick_scan_generate_messages_py std_msgs_generate_messages_py)
endif()
if(TARGET geometry_msgs_generate_messages_py)
  add_dependencies(sick_scan_generate_messages_py geometry_msgs_generate_messages_py)
endif()
if(TARGET sensor_msgs_generate_messages_py)
  add_dependencies(sick_scan_generate_messages_py sensor_msgs_generate_messages_py)
endif()
