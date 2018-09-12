% test for Disfrft, cdpei, frft, frft2
clc
clear all
close all

% im = (rgb2gray(imread('/Users/INNOCENTBOY/Downloads/videos/Imageprocessing/week6/original_cameraman.jpg')));
% im = double(imresize(im,[256,256]));
% im2 = zeros(256+40,256+40);
% 
% im2(21:276,21:276) = im(:,:);
i = 1:3;
tic
a = frft(i,0.5);
tic
b = frft2(i,0.5);
toc

a1 = frft(a,-0.5);
tic
b1 = frft2(b,-0.5);% % % tic
% % % im1 = fft(im);
% % % toc
% % % tic
% % % im2 = ifft(im1);
% % % toc

% im_rec = double(uint8(abs(im3)));
% im4 = zeros(256,256);
% im4(:,:) = im_rec(21:276,21:276);
% kk = corr2(im,im4);

% x=0.0:0.02:2*pi; y =cos(x);
% clear p_saved hn_saved E_saved
% for a=0:0.05:4
%     fy=Disfrft(y,a);
%     fys=cdpei(y,a);
%     fyss=frft(y,a);
%     fysss=frft2(y,a);
%     % blue,green,red,cyan
%     figure(1)
%     subplot(311);plot(x,real([fy,fys,fyss,fysss]));
%     title(['a = ',num2str(a)]);
%     subplot(312);plot(x,imag([fy,fys,fyss,fysss]));
%     subplot(313);plot(x,abs([fy,fys,fyss,fysss]));
%     pause(0.7);
% end