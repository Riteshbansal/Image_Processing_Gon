clc
clear all
close all


x = [158,151,157;151,153,150;158,151,157];
x1 = [158,21,157;151,22,150;158,23,157];

var = (sum(sum((x-mean2(x)).^2)));
var1 = (sum(sum((x1-mean2(x1)).^2)));

v1 = 1/var;
v2 = 1/var1;


% 
% a =2;
% b = 2;
% c = conv2(a,b);
% d = a*b;
% h = (1/8 )*ones(3,3);
% h(3,3)=0;
% h = h*c;
% e = fft2(h,1,1);
% f = ifft2(e);


% % % im = rgb2gray(imread('/Users/INNOCENTBOY/Downloads/videos/Imageprocessing/week6/original_cameraman.jpg'));
% % im = rgb2gray(imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/512/4.2.04.tiff'));
% % 
% % h = (1/8 )*ones(3,3);
% % h(3,3)=0;
% % l1 = h.';
% % vector_h = l1(:);
% % vector_h = vector_h';
% % c = [0.00,0.25,0.00;0.25,-1.00,0.25;0.00,0.25,0.00];
% % im1 = imfilter(im,vector_h,'symmetric');
% % k1 = 1:1:size(im,1);
% % k2 = 1:1:size(im,2);
% % [k1,k2] = meshgrid(k1,k2);
% % im2 = imfilter(im1,c);
% % im2_fre = fftshift(fft2(im2));
% % 
% % 
% % 
% % d = conv2(2,c);
% % im3 = imfilter(im1,d,'symmetric'  );
% % im3_fre = fftshift(fft2(im3));
% % 
% % figure();
% % subplot(2,2,1),imshow(mat2gray(im2));
% % subplot(2,2,2),mesh(k1,k2,mat2gray(abs(im2_fre)));
% % subplot(2,2,3),imshow(mat2gray(im3));
% % subplot(2,2,4),mesh(k1,k2,mat2gray(abs(im3_fre)));
% % 
% % 
% % 
% % 
% % 
% % 
% % 
% % 
