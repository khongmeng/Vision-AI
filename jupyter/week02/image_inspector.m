clc;
clear;
close all;

% Read images
Img_RAW = imread('HW_toyobjects_Gray/HW_toyobjects_Gray.bmp');
Img_JPG = imread('HW_toyobjects_Gray/HW_toyobjects_index.jpg');
Img_BMP = imread(['HW_toyobjects_Gray/HW_toyobjects_index.bmp']);

% Display side-by-side
figure;

subplot(1,3,1);
imshow(Img_RAW);
title('Raw Grayscale');

subplot(1,3,2);
imshow(Img_JPG);
title('JPEG Image');

subplot(1,3,3);
imshow(Img_BMP);
title('BMP Image');

% Enable interactive tools
zoom on;
