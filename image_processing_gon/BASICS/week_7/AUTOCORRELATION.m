clc
clear all
close all
im = (rgb2gray(imread('/Users/INNOCENTBOY/Downloads/videos/Imageprocessing/week6/original_cameraman.jpg')));
im = imresize(im,[256,256]);
k1 = 1:1:size(im,1);
k2 = 1:1:size(im,2);
[k1,k2] = meshgrid(k1,k2);

%% Filter
h = (1/8 )*ones(3,3);
h(3,3)=0;
l1 = h.';
vector_h = l1(:);
vector_h = vector_h';
% bl_ci_H = block_circulatnt_matrix(h);
% c = [0.00,0.25,0.00;0.25,-1.00,0.25;0.00,0.25,0.00];
% bl_ci_C = block_circulatnt_matrix(c);

%% Blurred image
im1_blurred = (imfilter(im,vector_h,'symmetric'  ));
im1 = double(imnoise(im1_blurred, 'gaussian', 0, 1e-4));
% im1 = (imfilter(im,vector_h,'symmetric'  ));
noise = abs(double(im1_blurred)-im1);

%% im  = image
%  im2 = blurred image
%  h = filter

%% Iterative algorithm FILTER
[n ,m]=size(im1);
h_fft =  (fft2(vector_h,size(im,1),size(im,2)));
B=abs((ifft2(fft2(im).*conj(fft2(im)))))./((n*m).^2);
noisefft = fft2(noise);
noisefft = 0;

% figure, surf(B);
% shading interp;
P_ff = 1;
im1_fft =  (fft2(im1));

%%%%%----Without noise------
% R = zeros(size(h_fft));
% R(abs(h_fft)== 0) = 0;
% R(abs(h_fft) > 0) = 1 ./ h_fft(abs(h_fft) > 0);
% %%%%%%
%%%%%%---with noise
l1 = (((abs(h_fft)).^2)+(noisefft./P_ff));
l2 = conj(h_fft);
R = ones(size(h_fft));
R(abs(l1)== 0) = 0;
% R(abs(l1) > 0) = l2./l1(abs(l1) > 0);

for i = 1:1:n
    for j = 1:1:m
        if(abs(l1(i,j)) > 0)
        R(i,j) = l2(i,j)/l1(i,j);
        end
    end 
end


% R = (conj(h_fft))./(((abs(h_fft)).^2)+(noisefft./P_ff));


imgot = R.*im1_fft;
im_reveerse = ifft2((imgot));
% iz = normalized_his(im_reveerse);
