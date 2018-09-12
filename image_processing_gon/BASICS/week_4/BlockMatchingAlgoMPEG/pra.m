clc
clear all

mbSize = 2;
p = 2;    
imgP = 1:16;
imgP = reshape(imgP,4,4);
imgP = imgP';
imgI(:,:) = imgP(:,:);

imgI(2:3,2:3) = 11; 
[motionVect, computations] = motionEstES(imgP,imgI,mbSize,p);
% imgComp = motionComp(imgI, motionVect, mbSize);
% ESpsnr(i+1) = imgPSNR(imgP, imgComp, 255);
% EScomputations(i+1) = computations;