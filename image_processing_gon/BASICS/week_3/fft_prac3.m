clc
clear all

% a = [1,0,1,1,1,1,1,1];
% n = length(a);
% b = (fft2(a));
% c= log(1+abs(b));
% plot(c);
% 
% % a2 = ifft2(c);
% a3 = ifft2(b);

im = imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/512/4.2.04.tiff');

im = double(rgb2gray(im));
n = length(im);
z =  fftshift(fft2(im));
z1 = abs(z);
z7 = mat2gray(log(1+z1));
im2 = mat2gray(log(1+im));
x = 1:1:size(im,1);
y = 1:1:size(im,2);
[x,y] = meshgrid(x,y);
z_new = log(1+z1);

mesh(x,y,z_new);

% plot((im2));
% plot((z7));
imhist(z7);

imshow(z7);
