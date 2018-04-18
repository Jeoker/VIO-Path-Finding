#! /usr/local/bin/python

# This script is used to refine image topic given by Tango
# The sequence number of images logged in bag files doesn't increase,
# so we use this file to replay the bag and log it again to make 
# the header.seq increase

import rospy
from sensor_msgs.msg import Imu

#start script in terminal 1
#start 'rosbag record /imu_republish /tango/camera/fisheye_1/image_rect /tango/camera/camera_info' in terminal 2
#start 'rosbag play bag.bag' in terminal 3
def republish(data):
    test = Imu()
    test = data

    #publish to utm_fix
    pub = rospy.Publisher("imu_republish", Imu, queue_size=10)
    pub.publish(test)


def listener():
    #subscribe to rtk_fix
    rospy.init_node('sequence', anonymous=True)
    rospy.Subscriber("android/imu", Imu, republish)
    rospy.spin()

if __name__ == '__main__':
    try:
        listener()
    except KeyboardInterrupt:
        print
        print 'Ending program...'
    finally:
        print
        print 'Program ended'
