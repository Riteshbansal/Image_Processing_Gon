clc
clear all
close all
cam = im2double(imread('cameraman.tif'));
house = im2double(imread('/Users/INNOCENTBOY/Downloads/videos/Imageprocessing/week7/house.tif'));

subplot(1,2,1)
imshow(cam)
colormap(gray(256))
title('cameraman')
subplot(1,2,2)
imshow(house)
title('house')
cf = abs(fft2(cam)).^2;
hf = abs(fft2(house)).^2;
subplot(1,2,1)
surf([-127:128]/128,[-127:128]/128,log(fftshift(cf)+1e-6))
shading interp, colormap gray
title('cameraman power spectrum')
subplot(1,2,2)
surf([-127:128]/128,[-127:128]/128,log(fftshift(hf)+1e-6))
shading interp, colormap gray
title('house power spectrum')


h = fspecial('disk',4);
cam_blur = imfilter(cam,h,'circular');
% 40 dB PSNR
sigma_u = 10^(-40/20)*abs(1-0);
kk=randn(size(cam_blur));
cam_blur_noise = cam_blur + sigma_u*randn(size(cam_blur));
k1= numel(cam)*sigma_u^2./cf;
cam_wnr = deconvwnr(cam_blur_noise,h,numel(cam)*sigma_u^2./cf);
subplot(1,1,1)
imshow(cam_wnr)
colormap(gray(256))
title('restored image with exact spectrum')