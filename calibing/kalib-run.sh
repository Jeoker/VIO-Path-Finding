# Setting up some Macros
HOME_DIR="/home/jia/group"
BAG_FILES_DIR="seperatesensors"

BAG_NAME_CAM="calib_nv100_cam"
BAG_NAME_IMUCAM="calib_nv100_imucam"

GRID_FILES_DIR="calibing"
GRID_CONFIG_NAME="aprilgrid_config"

OUTPUT_PERFIX="homejiagroup"
OUTPUT_NAME_CAM="$OUTPUT_PERFIX$BAG_FILES_DIR$BAG_NAME_CAM"
OUTPUT_NAME_IMUCAM="$OUTPUT_PERFIX$BAG_FILES_DIR$BAG_NAME_IMUCAM"


###---------------------Step.01 ncamera calibration---------------------###

kalibr_calibrate_cameras \
  --bag $HOME_DIR/$BAG_FILES_DIR/$BAG_NAME_CAM.bag \
  --topics /image_raw \
  --models pinhole-radtan \
  --target $HOME_DIR/$GRID_FILES_DIR/$GRID_CONFIG_NAME.yaml

# remove irrelevant files & rename useful one;get camchain.yaml
rm report-cam-$OUTPUT_NAME_CAM.pdf results-cam-$OUTPUT_NAME_CAM.txt
mv camchain-$OUTPUT_NAME_CAM.yaml camchain.yaml


###-------------------Step.02 imu_camera calibration-------------------###
kalibr_calibrate_imu_camera \
  --bag $HOME_DIR/$BAG_FILES_DIR/$BAG_NAME_IMUCAM.bag \
  --cam camchain.yaml \
  --imu input_imu.yaml \
  --target $HOME_DIR/$GRID_FILES_DIR/$GRID_CONFIG_NAME.yaml

# remove irrelevant files & rename useful one;get camchain_camimu.yaml and imuoutput.yaml
rm report-imucam-$OUTPUT_NAME_IMUCAM.pdf results-imucam-$OUTPUT_NAME_IMUCAM.txt 
mv camchain-imucam-$OUTPUT_NAME_IMUCAM.yaml camchain_imucam.yaml
mv imu-$OUTPUT_NAME_IMUCAM.yaml output_imu.yaml

###---------Step.03 transfer camchain to ncamera format---------###
rosrun kalibr kalibr_maplab_config --to-ncamera \
    --label lifeisgood \
    --cam camchain_imucam.yaml
mv sensors.yaml self_ncamera_maplab.yaml

#generate imu_rovio.yaml;needs editing!!
cp output_imu.yaml self_imucam_rovio.yaml

###------------------step.04 transfer imu yaml file to maplab format--------###
kalibr_maplab_config --cam camchain_imucam.yaml --imu output_imu.yaml --imu-out test.yaml

rm camchain_imucam.yaml output_imu.yaml camchain.yaml
mv sensors.yaml self_imu_maplab.yaml
