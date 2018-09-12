clc
clear all
close all

im = (rgb2gray(imread('/Users/INNOCENTBOY/Downloads/videos/Imageprocessing/week6/original_cameraman.jpg')));
im = double(imresize(im,[256,256]));
Mu=3.999; % Parameter of map
xlog= 20;
ylog= 22;
zlog= 19;
k_5 = 34;
k_6 = 40;
k_7 = 36;
for k=2:numel(im)   
    xlog(1,k)=mod(Mu*k_5*ylog(1,k-1)*(1-xlog(1,k-1)+zlog(1,k-1)),1);
    ylog(1,k)=mod(Mu*k_6*ylog(1,k-1)+zlog(1,k-1)*1/(1+(xlog(1,k-1)^2)),1);
    zlog(1,k)=mod(Mu*(xlog(1,k-1)+ylog(1,k-1)+k_7)*sin(zlog(1,k-1)),1); 
end

im_mask = exp(2*pi*((xlog+ylog-zlog))*1i);

im_mask_mat = reshape(im_mask,size(im,1),size(im,2));
im_mask_mat = 1;

im_with_mask = im.*im_mask_mat;



%% Encryption
fft1 = fft(im_with_mask);
% fft2 = fft(fft1);
% fft3 = fft(fft2);
ENCY_IMAGE = abs(fft1);
%% Encryption II
im(1,1) = im(1,1)+1;
im_with_maskII = im.*im_mask_mat;

fft1II = fft(im_with_maskII);
fft2II = fft(fft1II);
fft3II = fft(fft2II);
ENCY_IMAGE_2 = abs(fft3II);
%% decryption

% ifft1 = ifft(fft3);
% ifft2 = ifft(ifft1);
ifft3 = ifft(fft1);
ifft4 = ifft3./im_mask_mat;
imshow(uint8(abs(ifft4)));

[x,y] = corelation(abs(fft1),im);

img_dec = (double(uint8(abs(ifft4))));
res = NPCR_and_UACI(ENCY_IMAGE,ENCY_IMAGE_2,1,255);
PSNR1 = sum(sum(sum((im-img_dec).*(im-img_dec))));
PSNR1 = PSNR1 /(numel(im));
PSNR1 = 20 * log10(255/ sqrt(PSNR1));


