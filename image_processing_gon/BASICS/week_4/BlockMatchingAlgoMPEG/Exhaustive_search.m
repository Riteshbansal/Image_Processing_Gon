clc
clear all
vidObj = VideoReader('/Users/INNOCENTBOY/Desktop/1.mp4');
vidObj.CurrentTime = 520;

frame1 = readFrame(vidObj);
frame2 = readFrame(vidObj);
frame2 = readFrame(vidObj);
frame2 = readFrame(vidObj);
frame2 = readFrame(vidObj);


p = 7;
mbSize = 16;


frame1 = double(rgb2gray(frame1));
frame2 = double(rgb2gray(frame2));

imgI = frame1;
imgP = frame2;
%     imgI = imgI(:,1:352);
%     imgP = imgP(:,1:352);
%
% Exhaustive Search
[motionVect, computations] = motionEstES(imgP,imgI,mbSize,p);
imgComp = motionComp(imgI, motionVect, mbSize);
ESpsnr = imgPSNR(imgP, imgComp, 255);
EScomputations = computations;


%  Three Step Search
[motionVect,computations ] = motionEstTSS(imgP,imgI,mbSize,p);
imgComp1 = motionComp(imgI, motionVect, mbSize);
TSSpsnr = imgPSNR(imgP, imgComp1, 255);
TSScomputations = computations;
imshow(mat2gray(imgI-imgComp1));
