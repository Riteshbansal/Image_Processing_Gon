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

       if(pix < 128)
           y = 0;
       else
           y = 1;    
       end
       im_9(j,k) = y;
      end
   end
   
 %% compression  
 im_10 = im_8*128 + im_7*64 +im_6*32+im_5*16+im_4*8+im_3*4+im_2*2+im_1*1;
 im_11= uint8(im_10);
 
 PSNR = sum(sum((double(im)-double(im_11)).*(double(im)-double(im_11))));
 PSNR = PSNR /(numel(im));
PSNR = 20 * log10(255/ sqrt(PSNR));

 
 %% Image Display 
%    figure;
% subplot(4,4,1),imshow(im),title('Plain image');
% subplot(4,4,2),imshow(im2uint8(im_1)),title('image 1');
% subplot(4,4,3),imshow(im2uint8(im_2)),title('image 2');
% subplot(4,4,4),imshow(im2uint8(im_3)),title('image 3');
% subplot(4,4,5),imshow(im2uint8(im_4)),title('image 4');
% subplot(4,4,6),imshow(im2uint8(im_5)),title('image 5');
% subplot(4,4,7),imshow(im2uint8(im_6)),title('image 6');
% subplot(4,4,8),imshow(im2uint8(im_7)),title('image 7');
% subplot(4,4,9),imshow(im2uint8(im_8)),title('image 8');
% subplot(4,4,10),imshow(im2uint8(im_9)),title('intensity transformation');
% subplot(4,4,11),imshow(uint8(im_10)),title('Reconstruction');

