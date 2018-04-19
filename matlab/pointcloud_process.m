clc;
close all;

pc = imread('pointcloud1.png');

pc_gray = rgb2gray(pc);
pc_bw = ones(size(pc_gray, 1), size(pc_gray, 2));

%imshow(pc_gray);

for i = 1:size(pc_gray, 1)
    for j = 1:size(pc_gray, 2)
        if pc_gray(i,j) < 255
            pc_bw(i,j) = 0;
        end
    end
end

%figure;
%imshow(pc_bw);

pc_processed = pc_bw;

for i = 1:size(pc_bw, 1)
    for j = 1:size(pc_bw, 2)
        if (pc_bw(i,j) == 0)
            if (size(find(pc_bw(i-2:i+2, j-2:j+2) == 1)) ~= [0, 0])
                pc_processed(i, j) = 1;
            end
        end
    end
end

%figure;
%imshow(pc_processed);

%%

pixel1 = [787, 515];
pixel2 = [955, 412];
count = 1;


slope_end = (pixel2(2) - pixel1(2))/(pixel2(1) - pixel1(1));
pixel_st = struct;


for i = pixel1(1)-1:pixel2(1)-1
    for j = pixel2(2)-1:pixel1(2)-1
        slope_int = (j - pixel1(2))/(i - pixel1(1));
        if (abs(slope_end - slope_int) < 0.02)
            pixel_st.x{count} = i;
            pixel_st.y{count} = j;             
            pixel_array(count, 1) = i;
            pixel_array(count, 2) = j;

            count = count + 1;
        end

    end
end

%%
pc_rgb_trim = pc;


for i = 1:size(pc_processed, 1)
    for j = 1:size(pc_processed, 2)
        if pc_processed(i,j) == 1
            pc_rgb_trim(i, j, :) = [255, 255, 255];
        end
    end
end

%figure;
%imshow(pc_rgb_trim);

pc_rgb_track = pc_rgb_trim;

for i = 1:count-1
        pc_rgb_track(pixel_st.y{i}, pixel_st.x{i}, :) = [255, 0, 0];
end

% figure;
% imshow(pc);
% 
% figure;
% imshow(pc_rgb_track);

%%

figure;
subplot(2,1,1)
imshow(pc);
title('Original Point Cloud Data');
subplot(2,1,2)
imshow(pc_rgb_trim);
title('Filtered Point Cloud Data');

%%

figure;
subplot(2,1,1)
imshow(pc_rgb_trim);
title('Filtered Point Cloud Data');
subplot(2,1,2)
imshow(pc_rgb_track);
title('Tracking the shortest path');



