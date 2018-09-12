%%%-----------MATLAB TUTORIALS--------------%%
clc
clear
%%
%%------------read an image
im = imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/256/4.1.01.tiff');
%%
%%------------Size of image
[M ,N, P] = size(im);
%%
%%------------Show an image
imshow(im);

%%
%%------------Writing an image
imwrite(im, 'filename','tif');

%%
%%------------Vectorization


