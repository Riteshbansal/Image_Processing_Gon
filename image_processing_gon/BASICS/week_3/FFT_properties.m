clc
clear all;
x = [0,1,2,3,4,5];
l = numel(x);
x1 = fft2(x);
x2 = fft2((1/l)*x1);

x3 = fft2((1/l)*x2);
x4 = fft2(x3);


