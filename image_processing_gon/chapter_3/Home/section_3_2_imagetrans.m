clc
clear

%% Image Source
im = imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/256/4.1.01.tiff');
% im = imread('/Users/INNOCENTBOY/Desktop/Ritesh.png');


im3 (:,:,:)= im(:,:,:);
%% Negative concept%%
%IF Range 0 t0 L-1, then subtract whole image from l-1
im2 = 255-im;

%% Logarithmic
% used for repressing dark pixels
im3 = double(im3);
im3(im3==0) = 1; 
B = log(im3);
im3 = mod(floor(5*B),256);
im4 = mod(floor(46.1*B),256);
im3 = uint8(im3);
im4 = uint8(im4);

%% Logarithmic Given
% used for repressing dark pixels
g = 100*log(1+double(im)); 
gs = im2uint8(mat2gray(g));

%% Power-law transformation
gama = 1.2;
c = floor(double(im).^gama);
c = uint8(c);


%% Display of Images
figure;
subplot(2,3,1),imshow(im),title('Plain image');
subplot(2,3,2),imshow(im2),title('Negative image');
subplot(2,3,3),imshow(im3),title('Logarithmic image');
subplot(2,3,4),imshow(im4),title('Inverse Logarithmic image');
subplot(2,3,5),imshow(gs),title('book Logarithmic image');
subplot(2,3,6),imshow(c),title('Power Law image');

