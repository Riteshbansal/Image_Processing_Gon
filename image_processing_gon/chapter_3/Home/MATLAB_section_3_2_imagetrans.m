clc
clear

%% Image Source
im = imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/256/4.1.01.tiff');
% im = imread('/Users/INNOCENTBOY/Desktop/Ritesh.png');

%% Negative concept%%
%IF Range 0 t0 L-1, then subtract whole image from l-1
im2 = imadjust(im, [0 1],[1 0]);
im3 = imadjust(im, [0 0.5],[0 1],0.5);
im4 = imadjust(im, [0.5 1],[0 1]);
% im4 = imadjust(im, [0.5 0.75],[0 1]);


%% Logarithmic Given
% used for expanding dark pixels and 
g = 1*log(1+double(im)); 
gs = im2uint8(mat2gray(g));

%% Power-law transformation
gama =4;
c1 = (double(im).^gama);
c = im2uint8(uint8(c1));

%% Contrast Streching
m = mean2(im);
E=4.0;
gnew2 = 1./(1 + (m./(double(im)+ eps)).^E);
gnew = 1./(1 + (m./double(im)).^E);

%% Display of Images
figure;
subplot(3,3,1),imshow(im),title('Plain image');
subplot(3,3,2),imshow(im2),title('Negative image');
subplot(3,3,3),imshow(im3),title('Expand the gray scale below 0.5 image');
subplot(3,3,4),imshow(im4),title('Expand the gray scale above 0.5 image');
subplot(3,3,5),imshow(gs),title('book Logarithmic image');
subplot(3,3,6),imshow(c),title('Power Law image');
subplot(3,3,7),imshow(im2uint8(gnew)),title('contrast image');
subplot(3,3,8),imshow(im2uint8(gnew2)),title('contrast2 image');
histogram_personal((c));


