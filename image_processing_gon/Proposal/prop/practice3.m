clc
clear
clc
clear all
close all

im = double(rgb2gray(imread('/Users/INNOCENTBOY/Downloads/videos/Imageprocessing/week6/original_cameraman.jpg')));
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

xlog = xlog1(3:end);
ylog = ylog1(3:end);
zlog = zlog1(3:end);

im_mask = exp(2*pi*((xlog+ylog-zlog))*1i);
xlog_per = 1+floor(mod(ylog(1:end)*10^6,512));
ylog_per = 1+floor(mod(zlog(1:end)*10^6,512));
im_mask_mat = reshape(im_mask,size(im,1),size(im,2));
xlog_per = reshape(xlog_per,size(im,1),size(im,2))';
ylog_per = reshape(ylog_per,size(im,1),size(im,2))';

%% enc 
% out = mat_diffussion2(im,xlog_per,ylog_per);
out = mat_diffussion(im);
[out] = frft22d(out,[1,1]);

out_1 = out.*im_mask_mat;

[enc] = frft22d(out_1,[-1,-1]);

out_2 = out_1./im_mask_mat;


[out1] = frft22d(out_2,[-1,-1]);

[out1] = double(uint8(abs(out1)));
out1 = mat_rev_diffussion(out1);

% out1 = mat_rev_diffussion2(out1,xlog_per,ylog_per);
[x,y] = corelation(abs(enc),im);


PSNR2 = (sum(sum((im-out1).*(im-out1))));
PSNR2 = PSNR2 /(numel(im));
PSNR2 = 20 * log10(255/ sqrt(PSNR2));

PSNR1 = sum(sum(sum((im-abs(enc)).*(im-abs(enc)))));
PSNR1 = PSNR1 /(numel(im));
PSNR1 = 20 * log10(255/ sqrt(PSNR1));
