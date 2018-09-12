clc
clear all
close all
t = 0:0.1:2*pi;

x = sin(t);
y = awgn(x,0);
z  = awgn(x,100);

z1  = awgn(x,50);
cor1 = corr2(x,y);
cor2 = corr2(x,z);
% im = (rgb2gray(imread('/Users/INNOCENTBOY/Downloads/videos/Imageprocessing/week6/original_cameraman.jpg')));

% p = imhist(x(:));

% remove zero entries in p 
p(p==0) = [];

% normalize p so that sum(p) is one.
p = p ./ numel(x);

E = -sum(p.*log2(p));

% figure(),plot(t,x);
% figure(),plot(t,y);
% figure(),plot(t,z);
% 
% figure(),plot(t,z1);
randi