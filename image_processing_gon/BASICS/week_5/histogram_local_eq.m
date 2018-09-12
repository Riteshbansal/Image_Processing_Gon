
clc
clear all
im = imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/256/4.1.01.tiff');
A = rgb2gray(im);

[row,col] = size(A);
block = 256;
fz = zeros(row,col);
for i = 1:block:row-block+1
    for j = 1:block:col-block+1
        block_main = A(i:i+block-1,j:j+block-1);
        block_main = normalized_his(block_main);
        fz(i:i+block-1,j:j+block-1) = block_main(:,:);
        
    end
end

%% PLoting hist
figure;
subplot(2,2,1),imshow((A));
subplot(2,2,2),imshow(mat2gray(fz));
subplot(2,2,3),imhist((A));
subplot(2,2,4),imhist(uint8(fz));
