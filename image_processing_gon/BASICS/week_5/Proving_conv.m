clc
clear
% x = [1,2,3;4,5,6;];
x = double(rgb2gray(imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/256/4.1.01.tiff')));

h = ones(5,5);
% h = h/25;
M= size(x,1);
N= size(x,2);
m= size(h,1);
n= size(h,2);
h2 = fft2(h,M+m-1,N+n-1);
x2 = fft2(x,M+m-1,N+n-1);
h1 = fft2(h,M,N);
x1 = fft2(x,M,N);
out = x1.*h1;
out = ifft2(out);
out1 = x2.*h2;
out1 = ifft2(out1);
figure
subplot(2,2,1),imshow(mat2gray(x));
subplot(2,2,2),imshow(mat2gray(out));
subplot(2,2,3),imshow(mat2gray(out1));
