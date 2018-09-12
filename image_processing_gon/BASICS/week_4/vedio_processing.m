clc
clear all
vidObj = VideoReader('/Users/INNOCENTBOY/Desktop/1.mp4');
vidObj.CurrentTime = 520;

frame1 = readFrame(vidObj);
frame2 = readFrame(vidObj);
frame2 = readFrame(vidObj);
frame2 = readFrame(vidObj);
frame2 = readFrame(vidObj);




frame1 = double(rgb2gray(frame1));
frame2 = double(rgb2gray(frame2));

%% Difference between frames
frame3 = frame2-frame1;
% image(frame3);
frame4 = uint8(frame3);
frame5 = mat2gray(frame3);


imshow(mat2gray(frame3));



% 
% imshow(mat2gray(frame1));
% imshow(mat2gray(frame2));





% % % 
% % %       % Create an axes
% %       currAxes = axes;
% % %       
% % while hasFrame(vidObj)
% %           vidFrame = readFrame(vidObj);
% %           image(vidFrame, 'Parent', currAxes);
% %           currAxes.Visible = 'off';
% %           pause(1/vidObj.FrameRate); 
% % end