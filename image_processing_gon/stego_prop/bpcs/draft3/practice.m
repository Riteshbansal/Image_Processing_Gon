clc
clear

im = double(rgb2gray(imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/4.1.01.tiff')));
% im = [255,0;55,66];
mat_o = pbc_to_cgc(im);
mat_o1 = cgc_to_pbc(mat_o);
