clc
clear all


% % im = rgb2gray(imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/4.2.04.tiff'));
% % % im = imread('/Users/INNOCENTBOY/Desktop/Ritesh.png');
% % % % im = imresize(im,[512,512]);
% % im = double((im));
% % % % im2 = im(:,:);
% % % % im2(1:2,1:30) = im2(1:2,1:30)+1;
% % % % % im2(512,512) = im2(512,512)+60;
% % % % 
% % % % psnr = PSNR_CAL(im,((im2)));
% % [C,S] = wavedec2(im,3,'haar');

a = [51,52,53];
b = de2bi(a',8,'left-msb');
b = b';
c = b(:);
d = reshape(c,[8,numel(c)/8]);
y = bi2de(d','left-msb');
y = y';
