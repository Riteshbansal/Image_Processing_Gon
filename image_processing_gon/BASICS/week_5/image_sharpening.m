%% Image_shrpening
clc
clear all
image = (rgb2gray(imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/512/4.2.04.tiff')));

h=(1/9)*ones(3, 3);
x_low = imfilter(image, h, 'symmetric');
y_mask = image - x_low;
a =2;
y_main = image+ a*y_mask;

figure
subplot(2, 1, 1),imshow(image);
subplot(2, 1, 2),imshow(uint8(y_main));
