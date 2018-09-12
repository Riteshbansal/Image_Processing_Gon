clc
clear all


i = ones(16,16)*255;
[LL1 ,LH1, HL1, HH1] = dwt2(i,'haar');

% gray(imread('/Users/INNOCENTBOY/Downloads/videos/Imageprocessing/week6/original_cameraman.jpg')));

% Mu=3.999; % Parameter of map
% xlog1= 20;
% ylog1= 22;
% zlog1= 19;
% k_5 = 316;
% k_6 = 160;
% k_7 = 36;
% for k=2:512+2
%     xlog1(1,k)=mod(Mu*k_5*ylog1(1,k-1)*(1-xlog1(1,k-1)+zlog1(1,k-1)),1);
%     ylog1(1,k)=mod(Mu*k_6*ylog1(1,k-1)+zlog1(1,k-1)*1/(1+(xlog1(1,k-1)^2)),1);
%     zlog1(1,k)=mod(Mu*(xlog1(1,k-1)+ylog1(1,k-1)+k_7)*sin(zlog1(1,k-1)),1);
% end
% 
% xlog = xlog1(1,3:end);
% ylog = ylog1(1,3:end);
% zlog = zlog1(1,3:end);
% 
% 

% clearvars -except xlog zlog ylog

% [r,c]=size(im);
% 
% xlog_per_main = 1+floor(mod(xlog*10^6,r));
% ylog_per_main = 1+floor(mod(ylog*10^6,c));
% 
% new_mat = confusion_impl(im,xlog_per_main,ylog_per_main);
% new_mat_2 = confusion_impl_rev(new_mat,xlog_per_main,ylog_per_main);

