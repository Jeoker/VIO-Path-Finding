#include <ros/ros.h>
#include <image_transport/image_transport.h>
#include <opencv2/highgui/highgui.hpp>
#include <cv_bridge/cv_bridge.h>

int main(int argc, char** argv)
{
    ros::init(argc, argv, "image_feeder");
    ros::NodeHandle nh;
    image_transport::ImageTransport it(nh);
    image_transport::Publisher pub = it.advertise("image_raw", 1);
    cv::Mat image;
    cv::Mat image_gray;
    cv::VideoCapture cap(0);
    ros::Rate loop_rate(25);
    while (nh.ok()) {
        long long count = 0;

        cap >> image;

        cv::cvtColor(image, image_gray, cv::COLOR_BGR2GRAY);

        std_msgs::Header camera_header;
        camera_header.seq = count;
        camera_header.frame_id = "camera_frame";
        camera_header.stamp = ros::Time:: now();

        sensor_msgs::ImagePtr img_msg =
          cv_bridge::CvImage(camera_header, "mono8", image_gray).toImageMsg();

        pub.publish(img_msg);
        
        ros::spinOnce();
        loop_rate.sleep();
    }
}