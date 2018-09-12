clc
clear all
close all

im1 = (rgb2gray(imread('/Users/INNOCENTBOY/Downloads/videos/Imageprocessing/week6/original_cameraman.jpg')));
im = double(imresize(im1,[256,256]));

% im2 = zeros(256+2,256+2);

% im2(2:257,2:257) = im(:,:);
a = frft22d(im,[0.5,0.5]);
a = frft22d(a,[0.55,0.5]);
a1 = mat_diffussion((fftshift(a)));
a1 = fftshift(a1);
m = noise_matrix(abs(a1(1,1)), a1,[1,1]);
% im_mask = exp(2*pi*((m))*1i);
% a1 = a1 *im_mask;
% 
% a2 = a1 /im_mask;
b1 = mat_rev_diffussion(fftshift(a1));
b = frft22d(fftshift(b1),[-0.55,-0.5]);
b = frft22d(b,[-0.5,-0.5]);
b = floor(abs(b));
% c = zeros(256,256);
% c(:,:) = b (2:257,2:257) ;

mat_afterdiff = mat_rev_diffussion(b);

z = corr2(im,b);
% a = 5* exp(1i*0.6);
% b = 6* exp(1i*0.61);
% c = a*b;
% d = c/b;
im(1,1) = im(1,1)+1;
a11 = frft22d(im,[0.5,0.5]);
a11 = frft22d(a11,[0.55,0.5]);
a11 = fftshift(mat_diffussion((fftshift(a11))));
m1 = noise_matrix(abs(a11(1,1)), a11,[1,1]);
% im_mask = exp(2*pi*((m1))*1i);
% a11 = a11 *im_mask;

l1 = floor(abs(a11));
l2 = floor(abs(a1));

z1 = corr2(l1,l2);


