clc
clear all
close all

im = (rgb2gray(imread('/Users/INNOCENTBOY/Downloads/videos/Imageprocessing/week6/original_cameraman.jpg')));
im = double(imresize(im,[256,256]));
Mu=3.999; % Parameter of map
xlog1= 20;
ylog1= 22;
zlog1= 19;
k_5 = 34;
k_6 = 40;
k_7 = 36;
for k=2:numel(im) +2  
    xlog1(1,k)=mod(Mu*k_5*ylog1(1,k-1)*(1-xlog1(1,k-1)+zlog1(1,k-1)),1);
    ylog1(1,k)=mod(Mu*k_6*ylog1(1,k-1)+zlog1(1,k-1)*1/(1+(xlog1(1,k-1)^2)),1);
    zlog1(1,k)=mod(Mu*(xlog1(1,k-1)+ylog1(1,k-1)+k_7)*sin(zlog1(1,k-1)),1); 
end
xlog = zeros(1,1);
ylog = zeros(1,1);
zlog = zeros(1,1);
xlog = xlog1(1,3:end);
ylog = ylog1(1,3:end);
zlog = zlog1(1,3:end);
clear xlog1 ylog1 zlog1;
xlog = reshape(xlog,size(im,1),size(im,2));
im_mask = exp(2*pi*((xlog))*1i);
im_with_mask = im.*im_mask;

%% Encryption
fft1 = frft22d(im_with_mask,[0.51,0.53]);

% im_mask = exp(2*pi*((ylog))*1i);
% im_mask_mat = reshape(im_mask,size(im,1),size(im,2));
% fft1 = fft1.*im_mask_mat;

fft2 = frft22d(fft1,[0.52,0.52]);

% im_mask = exp(2*pi*((zlog))*1i);
% im_mask_mat = reshape(im_mask,size(im,1),size(im,2));
% fft2 = fft2.*im_mask_mat;

fft3 = frft22d(fft2,[0.53,0.51]);
ENCY_IMAGE = abs(fft3);
%% Encryption II
im(1,1) = im(1,1)+1;

im_mask = exp(2*pi*((xlog))*1i);
im_mask_mat = reshape(im_mask,size(im,1),size(im,2));
im_with_mask = im.*im_mask_mat;

fft1_2 = frft22d(im_with_mask,[0.53,0.51]);

im_mask = exp(2*pi*((ylog))*1i);
im_mask_mat = reshape(im_mask,size(im,1),size(im,2));
im_with_mask = fft1_2.*im_mask_mat;

fft2_2 = frft22d(im_with_mask,[0.52,0.52]);

im_mask = exp(2*pi*((zlog))*1i);
im_mask_mat = reshape(im_mask,size(im,1),size(im,2));
im_with_mask = fft2_2.*im_mask_mat;

fft3_2 = frft22d(im_with_mask,[0.51,0.53]);

ENCY_IMAGE_2 = abs(fft3_2);


%% decryption

ifft1 = frft22d(fft3,[-0.53,-0.51]);

% im_mask = exp(2*pi*((zlog))*1i);
% im_mask_mat = reshape(im_mask,size(im,1),size(im,2));
% ifft1 = ifft1./im_mask_mat;

ifft2 = frft22d(ifft1,[-0.52,-0.52]);

% im_mask = exp(2*pi*((ylog))*1i);
% im_mask_mat = reshape(im_mask,size(im,1),size(im,2));
% ifft2 = ifft2./im_mask_mat;

ifft3 = frft22d(ifft2,[-0.51,-0.53]);

xlog = reshape(xlog,size(im,1),size(im,2));
im_mask = exp(2*pi*((xlog))*1i);
ifft4 = ifft3./im_mask;


imshow(uint8(abs(ifft4)));

[x,y] = corelation(floor(abs(fft3)),im);


res = NPCR_and_UACI(ENCY_IMAGE,ENCY_IMAGE_2,1,255);


