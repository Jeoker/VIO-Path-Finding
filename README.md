# VIO-Path-Finding

This Repo is for the group project of EECE-5698 Robotics class.
This repos use maplab to generate vio feature point cloud and path.
Then we use the point cloud to implement path finding algorithm on it.

## About VIO
VIO is the abbreviation of Visual Inertial Odometry. We are using MapLab, a mature repository focusing on VIO 3D recunstruction and mapping, to draw a map of the ISCE building and try to find a path that tell you how to go from a certain location to another.
Link to MapLab can be found here: https://github.com/ethz-asl/maplab

## About Calibration
We use Kalibr which is recommended by Maplab team to generate the calibration yaml files.
Link to Kalibr can be found here: https://github.com/ethz-asl/kalibr
