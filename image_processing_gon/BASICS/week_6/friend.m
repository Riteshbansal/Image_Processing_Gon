clear ; close all;
clc
img = rgb2gray(imread('/Users/INNOCENTBOY/Downloads/videos/Imageprocessing/week6/original_cameraman.jpg'));

img = im2double(img);

figure; imshow(img);

%1D motion blur

h = zeros(size(img));

s = size(h);

for i = (s(2)/2 - 8) : (s(2)/2 + 8)

h(s(1)/2, i) = 1/16;

end

blurImg = imfilter(img, h, 'replicate');

figure; imshow(blurImg);

% to frequency domain

fImg = fft2(blurImg);

H = fft2(h);

% inverse filter
T = 0.1;
% 
% fImg( abs(H) < T) = 0;
% 
% % fImg = (fImg .* conj(H)) ./ abs(H).^2;	%same as directly fImg = fImg ./ H; why?
% fImg = 1 ./ H(abs(H) >= T);

fImg(abs(H) < T) = 0;
fImg(abs(H) >= T) = 1 ./ H(abs(H) >= T);

% back to spatial domain

ifImg = ifft2((fImg));

ifImg = mat2gray(fftshift(ifImg));

figure; imshow(mat2gray(ifImg));