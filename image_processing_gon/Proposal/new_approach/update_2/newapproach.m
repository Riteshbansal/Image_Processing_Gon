clc
clear all
close all

im = (rgb2gray(imread('/Users/INNOCENTBOY/Downloads/videos/Imageprocessing/week6/original_cameraman.jpg')));

Mu=3.999; % Parameter of map
xlog1= 20;
ylog1= 22;
zlog1= 19;
k_5 = 34;
k_6 = 40;
k_7 = 36;
for k=2:128+2  
    xlog1(1,k)=mod(Mu*k_5*ylog1(1,k-1)*(1-xlog1(1,k-1)+zlog1(1,k-1)),1);
    ylog1(1,k)=mod(Mu*k_6*ylog1(1,k-1)+zlog1(1,k-1)*1/(1+(xlog1(1,k-1)^2)),1);
    zlog1(1,k)=mod(Mu*(xlog1(1,k-1)+ylog1(1,k-1)+k_7)*sin(zlog1(1,k-1)),1); 
end

xlog = xlog1(1,3:end);
ylog = xlog1(1,3:end);
zlog = xlog1(1,3:end);



clearvars -except xlog zlog ylog

xlog = 1+floor(mod(xlog*10^4,128));
ylog = 1+floor(mod(ylog*10^4,128));


im1 = (rgb2gray(imread('/Users/INNOCENTBOY/Downloads/videos/Imageprocessing/week6/original_cameraman.jpg')));
im = double(imresize(im1,[256,256]));
%% ENC
[LL ,LH, HL, HH] = dwt2(im,'haar');
ll = floor(LL);
im1 = mat_diffussion(ll);
im1 = confusion_impl(im1,xlog,ylog);
Y = idwt2(im1,LH,HL,HH,'haar');

%% enc2
im(1,1) = 1+im(1,1);
[LL_2 ,LH_2, HL_2, HH_2] = dwt2(im,'haar');
ll_2 = floor(LL_2);
im1_2 = mat_diffussion(ll_2);
im1_2 = confusion_impl(im1_2,xlog,ylog);
Y2 = idwt2(im1_2,LH,HL,HH,'haar');

%% DEC

[LL1 ,LH1, HL1, HH1] = dwt2(Y,'haar');
ll1 = floor(LL1);
ll1(ll1<0) = 0;
ll1 = confusion_impl_rev(ll1,xlog,ylog);
im11 = mat_rev_diffussion(ll1);
Y1 = idwt2(im11,LH1,HL1,HH1,'haar');

% 

[x,y] = corelation(im,Y);


