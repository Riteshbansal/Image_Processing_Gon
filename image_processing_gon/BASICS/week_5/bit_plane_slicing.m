clc
clear

%% Image Source
im = imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/4.2.04.tiff');
% im = imread('/Users/INNOCENTBOY/Desktop/Ritesh.png');
im = rgb2gray(im);
[M ,N] = size(im);
im_1= zeros(M,N);
im_2= zeros(M,N);
im_3= zeros(M,N);
im_4= zeros(M,N);
im_5= zeros(M,N);
im_6= zeros(M,N);
im_7= zeros(M,N);
im_8= zeros(M,N);
im_9= zeros(M,N);

   for j = 1:1:M
      for k = 1:1:N 
       pix = im(j,k);
       pix_bin = de2bi(pix,8,'left-msb');
       im_1(j,k) = pix_bin(8);
       im_2(j,k) = pix_bin(7);
       im_3(j,k) = pix_bin(6);
       im_4(j,k) = pix_bin(5);
       im_5(j,k) = pix_bin(4);
       im_6(j,k) = pix_bin(3);
       im_7(j,k) = pix_bin(2);
       im_8(j,k) = pix_bin(1);
       %% Intensity transformation
% 
%        if(pix < 128)
%            y = 0;
%        else
%            y = 1;    
%        end
%        im_9(j,k) = y;
      end
   end
   
 %% compression
 % 128 = 2^(n-1)(n = plane)
%  im_10 = im_8*128 + im_7*64 +im_6*32+im_5*16;
%  im_11= uint8(im_10);
%  
 %% Image Display 
   figure;
subplot(3,3,1),imshow(im),title('Plain image');
subplot(3,3,2),imshow(im2uint8(im_1)),title('image 1,lsb');
subplot(3,3,3),imshow(im2uint8(im_2)),title('image 2');
subplot(3,3,4),imshow(im2uint8(im_3)),title('image 3');
subplot(3,3,5),imshow(im2uint8(im_4)),title('image 4');
subplot(3,3,6),imshow(im2uint8(im_5)),title('image 5');
subplot(3,3,7),imshow(im2uint8(im_6)),title('image 6');
subplot(3,3,8),imshow(im2uint8(im_7)),title('image 7');
subplot(3,3,9),imshow(im2uint8(im_8)),title('image 8,msb');

