clc
clear
im = imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/256/4.1.01.tiff');
im3 (:,:,:)= im(:,:,:);
%% Negative concept%%
%IF Range 0 t0 L-1, then subtract whole image from l-1
im2 = 255-im;

%% Logarithmic
im3 = double(im3);
im3(im3==0) = 1; 
B = log(im3);
im3 = mod(ceil(100*B),256);
im3 = uint8(im3);

 figure;
subplot(2,2,1),imshow(im),title('Plain image');
subplot(2,2,2),imshow(im2),title('Negative image');
subplot(2,2,3),imshow(im3),title('Logarithmic image');

