clc;
clear;
close all;

% Read images
Img_RAW = imread('HW_toyobjects_Gray/HW_toyobjects_Gray.bmp');
Img_JPG = imread('HW_toyobjects_Gray/HW_toyobjects_index.jpg');
[Img_BMP, map] = imread('HW_toyobjects_Gray/HW_toyobjects_index.bmp');

figure;

subplot(1,3,1);
imshow(Img_RAW);
axis on
title('Raw Grayscale');

subplot(1,3,2);
imshow(Img_JPG);
axis on
title('JPEG Image');

subplot(1,3,3);
imshow(Img_BMP, map);
axis on
title('BMP Image');

% Enable interactive tools
zoom on;
