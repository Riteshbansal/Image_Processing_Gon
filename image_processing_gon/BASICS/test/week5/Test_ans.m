clc
clear all
im = double(imread('/Users/INNOCENTBOY/Downloads/videos/Imageprocessing/week5/noisy.jpg'));
im2 = double(imread('/Users/INNOCENTBOY/Downloads/videos/Imageprocessing/week5/stan.jpg'));

im_med1 = medfilt2(im);
im_med2 = medfilt2(im_med1);

figure
subplot(2,2,1),imshow(uint8(im));
subplot(2,2,2),imshow(uint8(im2))
subplot(2,2,3),imshow(uint8(im_med1))
subplot(2,2,4),imshow(uint8(im_med2))


size_matrix = size(im);

PSNR = (sum(sum(((im2-im).*(im2- im)))));
PSNR = PSNR/(size_matrix(1)*size_matrix(2));
PSNR = 20 * log10(255/ sqrt(PSNR));

PSNR1 = (sum(sum(((im2-im_med1).*(im2- im_med1)))));
PSNR1 = PSNR1/(size_matrix(1)*size_matrix(2));
PSNR1 = 20 * log10(255/ sqrt(PSNR1));

PSNR2 = (sum(sum(((im2-im_med2).*(im2- im_med2)))));
PSNR2 = PSNR2/(size_matrix(1)*size_matrix(2));
PSNR2 = 20 * log10(255/ sqrt(PSNR2));
