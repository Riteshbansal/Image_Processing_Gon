clc
clear all
vidObj = VideoReader('/Users/INNOCENTBOY/Desktop/1.mp4');
vidObj.CurrentTime = 520;

% frame1 = readFrame(vidObj);
% frame2 = readFrame(vidObj);
% frame2 = readFrame(vidObj);
% frame2 = readFrame(vidObj);
% frame2 = readFrame(vidObj);
psnr = zeros(5,1);
count = 1;


    
while hasFrame(vidObj)
    frame1 = readFrame(vidObj);
    frame2 = readFrame(vidObj);
    frame2 = readFrame(vidObj);
    frame2 = double(rgb2gray(frame2));
    frame1 = double(rgb2gray(frame1));

    %% Exhaustive search
    p=7;
    blocksize=16;
    tic
    exh_img = Exhaustive_search(frame1,frame2,p,blocksize);
    toc
%     imshow(mat2gray(exh_img));
    psnr(1,count) = imgPSNR(frame1,exh_img,255);
    %% 2d_logrithmic Search
    p = 7;
    blocksize = 16;
    tic
    log_img = block_2d_log_search(frame1,frame2,p,blocksize);
    toc
    psnr(2,count) = imgPSNR(frame1,log_img,255);
    
    %% Herarichal_block_match
    p=7;
    blocksize=16;
    tic
    herarichal_img = herarichal_block_match(frame1,frame2,p,blocksize);
    toc
    psnr(3,count) = imgPSNR(frame1,herarichal_img,255);
    
    %% 3_step_search
    p = 7;
    blocksize=16;
    tic
    step_3_search_img = block_3_step_search(frame1,frame2,p,blocksize);
    toc
    psnr(4,count) = imgPSNR(frame1,step_3_search_img,255);
    
    %% 4_step_search
    blocksize=16;
    tic
    four_step_search_img = four_step_search_block(frame1,frame2,blocksize);
    toc
    psnr(5,count) = imgPSNR(frame1,four_step_search_img,255);
    
    count = count+1;
    if(count == 2)
        break;
    end
%     frame1(:,:) = frame2(:,:);
end
%% Display
figure
subplot(2,3,1),imshow(mat2gray(frame1-exh_img));
subplot(2,3,2),imshow(mat2gray(frame1-log_img));
subplot(2,3,3),imshow(mat2gray(frame1-herarichal_img));
subplot(2,3,4),imshow(mat2gray(frame1-step_3_search_img));
subplot(2,3,5),imshow(mat2gray(frame1-four_step_search_img));

