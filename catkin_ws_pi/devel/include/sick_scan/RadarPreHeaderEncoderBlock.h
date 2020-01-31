// Generated by gencpp from file sick_scan/RadarPreHeaderEncoderBlock.msg
// DO NOT EDIT!


#ifndef SICK_SCAN_MESSAGE_RADARPREHEADERENCODERBLOCK_H
#define SICK_SCAN_MESSAGE_RADARPREHEADERENCODERBLOCK_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace sick_scan
{
template <class ContainerAllocator>
struct RadarPreHeaderEncoderBlock_
{
  typedef RadarPreHeaderEncoderBlock_<ContainerAllocator> Type;

  RadarPreHeaderEncoderBlock_()
    : udiEncoderPos(0)
    , iEncoderSpeed(0)  {
    }
  RadarPreHeaderEncoderBlock_(const ContainerAllocator& _alloc)
    : udiEncoderPos(0)
    , iEncoderSpeed(0)  {
  (void)_alloc;
    }



   typedef uint32_t _udiEncoderPos_type;
  _udiEncoderPos_type udiEncoderPos;

   typedef int16_t _iEncoderSpeed_type;
  _iEncoderSpeed_type iEncoderSpeed;





  typedef boost::shared_ptr< ::sick_scan::RadarPreHeaderEncoderBlock_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::sick_scan::RadarPreHeaderEncoderBlock_<ContainerAllocator> const> ConstPtr;

}; // struct RadarPreHeaderEncoderBlock_

typedef ::sick_scan::RadarPreHeaderEncoderBlock_<std::allocator<void> > RadarPreHeaderEncoderBlock;

typedef boost::shared_ptr< ::sick_scan::RadarPreHeaderEncoderBlock > RadarPreHeaderEncoderBlockPtr;
typedef boost::shared_ptr< ::sick_scan::RadarPreHeaderEncoderBlock const> RadarPreHeaderEncoderBlockConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::sick_scan::RadarPreHeaderEncoderBlock_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::sick_scan::RadarPreHeaderEncoderBlock_<ContainerAllocator> >::stream(s, "", v);
return s;
}

} // namespace sick_scan

namespace ros
{
namespace message_traits
{



// BOOLTRAITS {'IsFixedSize': True, 'IsMessage': True, 'HasHeader': False}
// {'sensor_msgs': ['/opt/ros/kinetic/share/sensor_msgs/cmake/../msg'], 'geometry_msgs': ['/opt/ros/kinetic/share/geometry_msgs/cmake/../msg'], 'std_msgs': ['/opt/ros/kinetic/share/std_msgs/cmake/../msg'], 'sick_scan': ['/home/ubuntu/catkin_ws/src/sick_scan/msg']}

// !!!!!!!!!!! ['__class__', '__delattr__', '__dict__', '__doc__', '__eq__', '__format__', '__getattribute__', '__hash__', '__init__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_parsed_fields', 'constants', 'fields', 'full_name', 'has_header', 'header_present', 'names', 'package', 'parsed_fields', 'short_name', 'text', 'types']




template <class ContainerAllocator>
struct IsFixedSize< ::sick_scan::RadarPreHeaderEncoderBlock_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::sick_scan::RadarPreHeaderEncoderBlock_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::sick_scan::RadarPreHeaderEncoderBlock_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::sick_scan::RadarPreHeaderEncoderBlock_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::sick_scan::RadarPreHeaderEncoderBlock_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::sick_scan::RadarPreHeaderEncoderBlock_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::sick_scan::RadarPreHeaderEncoderBlock_<ContainerAllocator> >
{
  static const char* value()
  {
    return "5af720e8adc927dc42f34b3cd0d0e8e9";
  }

  static const char* value(const ::sick_scan::RadarPreHeaderEncoderBlock_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x5af720e8adc927dcULL;
  static const uint64_t static_value2 = 0x42f34b3cd0d0e8e9ULL;
};

template<class ContainerAllocator>
struct DataType< ::sick_scan::RadarPreHeaderEncoderBlock_<ContainerAllocator> >
{
  static const char* value()
  {
    return "sick_scan/RadarPreHeaderEncoderBlock";
  }

  static const char* value(const ::sick_scan::RadarPreHeaderEncoderBlock_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::sick_scan::RadarPreHeaderEncoderBlock_<ContainerAllocator> >
{
  static const char* value()
  {
    return "# Array with connected encoder sensors\n\
uint32 udiEncoderPos  # encoder position [inc]\n\
int16 iEncoderSpeed   # encoder speed [inc/mm]\n\
";
  }

  static const char* value(const ::sick_scan::RadarPreHeaderEncoderBlock_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::sick_scan::RadarPreHeaderEncoderBlock_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.udiEncoderPos);
      stream.next(m.iEncoderSpeed);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct RadarPreHeaderEncoderBlock_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::sick_scan::RadarPreHeaderEncoderBlock_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::sick_scan::RadarPreHeaderEncoderBlock_<ContainerAllocator>& v)
  {
    s << indent << "udiEncoderPos: ";
    Printer<uint32_t>::stream(s, indent + "  ", v.udiEncoderPos);
    s << indent << "iEncoderSpeed: ";
    Printer<int16_t>::stream(s, indent + "  ", v.iEncoderSpeed);
  }
};

} // namespace message_operations
} // namespace ros

#endif // SICK_SCAN_MESSAGE_RADARPREHEADERENCODERBLOCK_H
