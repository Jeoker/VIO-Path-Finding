clc;
clear;
close all;

str1 = '/home/vasu536/gitlab/EECE-5698/final_project/matlab/sample_csv_1/';
descriptor_s = 'descriptor.csv';
imu_s = 'imu.csv';
landmarks_s = 'landmarks.csv';
tracks_s = 'tracks.csv';
vertices_s = 'vertices.csv';

descriptor = csvread(strcat(str1, descriptor_s));
imu = csvread(strcat(str1, imu_s));
landmarks = csvread(strcat(str1, landmarks_s));
tracks = csvread(strcat(str1, tracks_s));
vertices = csvread(strcat(str1, vertices_s));

%%

position_camera = vertices(:,3:5);
landmark_position = landmarks(:,2:4);

position_x = position_camera(:,1);
position_y = position_camera(:,2);
position_z = position_camera(:,3);
%position_z = zeros(length(position_x), 1);

figure;
scatter3(position_x, position_y, position_z, '.');

landmark_x = landmark_position(:,1);
landmark_y = landmark_position(:,2);
landmark_z = landmark_position(:,3);
%landmark_z = zeros(length(landmark_x), 1);

figure;
scatter3(landmark_x, landmark_y, landmark_z, '.');
grid off;

%landmark_position(:,3) = landmark_z;
figure;
surf(landmark_position);

figure;
plot3(landmark_x, landmark_y, landmark_z);


%%

lm1 = 100;
lm2 = 536;

path_x = position_x(lm1:lm2);
path_y = position_y(lm1:lm2);
path_z = position_z(lm1:lm2);


figure;
scatter3(position_x, position_y, position_z, '.r');
hold on;
scatter3(path_x, path_y, path_z, '.b');


%%

