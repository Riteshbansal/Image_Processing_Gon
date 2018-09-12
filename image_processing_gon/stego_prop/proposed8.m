% function enco = huffman_encoder(sig, dict)
clc
clear all
close all

% im = imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/256/4.1.01.tiff');
% im = rgb2gray(im);
%% Data
data = 'ABCDEFABCDEFABCD';
% data = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()_+';
A = double(int16(data));
% im = rgb2gray(imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/4.2.03.tiff'));
% siz = [256,256];
% A = double(imresize(im,siz));
%% Diffusion

A = mat_rev_diffussion4(A);

%% Cover Image
% im = (imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/4.2.04.tiff'));
im = imread('128_p.jpg');
% im = imresize(im,[1024,1024]);
im = double((im));

Mu = 3.99;
xlog1= 20.1;
ylog1= 22;
zlog1= 19;
k_5 = 34;
k_6 = 40;
k_7 = 36;
pix = 0.1;

[comp1, comp, prob1] = huff_enc(A);

xsini(1,1)=pix;
for i = 2:1:(numel(comp1))+2
    xsini(1,i) = mod(sin(pi * xsini(1,i-1)),1);
end
xsin = 1+floor(mod(xsini(3:end)*10^10,numel(comp1)));
comp1 = confusion_impl2(comp1,xsin,1);

% comp1 = bitxor(comp1,1);
% [comp1, comp_1,prob2] = huff_enc2(comp1);


tic
%% Stego
l = (size(im));
l = (l(1)/2)*(l(2)/2)*3;
if(numel(comp1)<=l)
[im2,k] = stego_im(im,comp1,Mu,xlog1,ylog1,zlog1,k_5,k_6,k_7);
else
[im2,k] = stego_im2(im,comp1,Mu,xlog1,ylog1,zlog1,k_5,k_6,k_7);
end
toc

clearvars -except im2 k l comp im comp1 data A pix comp_1 comp1_1 siz
%% Invstego

Mu = 3.99;
xlog1= 20.1;
ylog1= 22;
zlog1= 19;
k_5 = 34;
k_6 = 40;
k_7 = 36;

if(numel(comp1)<=l)
dhsig = inv_stego_im(im2,Mu,xlog1,ylog1,zlog1,k_5,k_6,k_7,k);
else
dhsig = inv_stego_im2(im2,Mu,xlog1,ylog1,zlog1,k_5,k_6,k_7,k);
end



% dhsig = huffmandeco(dhsig,comp_1);


y = de2bi(dhsig,8,'left-msb');
y = y';
y = y(:);

kkk=y(end-7:end);
kkk= 8+(bi2de(kkk','left-msb'));
dhsig = y(1:numel(y)-kkk,1);

xsini(1,1)=pix;
for i = 2:1:(numel(dhsig))+2
    xsini(1,i) = mod(sin(pi * xsini(1,i-1)),1);
end
xsin = 1+floor(mod(xsini(3:end)*10^10,numel(dhsig)));
dhsig = confusion_impl_rev2(dhsig,xsin,1);


dhsig = huffmandeco(dhsig,comp);

dhsig=(dhsig');

dhsig = mat_diffussion4(dhsig);
dhsig = char(dhsig);
% dhsig = reshape(dhsig,siz)';
% figure(),imshow(uint8(dhsig));
clearvars -except im2 k l comp im comp1 data A pix comp_1 comp1_1 siz dhsig

psnr = PSNR_CAL(im,((im2)))
figure();
subplot(1,2,1), imshow(mat2gray(im));
subplot(1,2,2), imshow(mat2gray(im2));

[qs, qm, qmaps] = imageQualityIndex (im, im2);
qs
qm
[rmn,rpq] =corelation (im,im2)
