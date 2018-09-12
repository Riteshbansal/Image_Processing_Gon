
clc
clear all
close all
im = rgb2gray(imread('/Users/INNOCENTBOY/Downloads/videos/Imageprocessing/week6/original_cameraman.jpg'));
k1 = 1:1:size(im,1);
k2 = 1:1:size(im,2);
[k1,k2] = meshgrid(k1,k2);
%% Filter

h = (1/8 )*ones(3,3);
h(3,3)=0;
l1 = h.';
vector_h = l1(:);
vector_h = vector_h';
block_circulant_mat_H = block_circulatnt_matrix(h);

%% Blurred image
im1 = imfilter(im,vector_h,'symmetric'  );

%% im  = image
%  im2 = blurred image
%  h = filter

%% Iterative algorithm FILTER

h_fft =  fftshift(fft2(vector_h,size(im,1),size(im,2)));
    figure()
mesh(k1,k2,((abs(h_fft))));


beta = 1.5;
f  = zeros(size(im,1),size(im,2));
im1_fft =  fftshift(fft2(im1));
k =0;
inp = 2;
    [R,f] = f_k_least_square(h_fft,im1_fft);
while(inp ~= 1)

    f = ((beta*(conj(h_fft))).*im1_fft) +((1-(beta*(abs(h_fft).^2))).*f);
    R = ((beta*(conj(h_fft)))) +((1-(beta*(abs(h_fft).^2))).*R);
    k = k+1;
    if(1==any([1,3,5,15,20,50,100,400,465,500,520]==k))
    im2 = ifft2(fftshift(f));
    figure()
    imshow(mat2gray(abs(im2)));
    figure()
    mesh(k1,k2,((abs(R))));
    figure()
    mesh(k1,k2,((abs(f))));
%     prompt = 'What is inp? ';
%     inp = input(prompt);
    end
   
end
f = fftshift((f));
im2 = ifft2((f));
%% figure
% x = 1:512;
figure
subplot(2,2,1),mesh(k1,k2,mat2gray(abs(1-(beta*h_fft))));
subplot(2,2,2),mesh(k1,k2,mat2gray(abs(h_fft)));

% subplot(2,3,2),mesh(k1,k2,mat2gray(abs(c_fft).^2));
% subplot(2,3,3),mesh(k1,k2,mat2gray(l));
% subplot(2,2,2),imshow((im));
% subplot(2,2,3),imshow((im1));
% subplot(2,2,4),imshow(mat2gray(abs(im2)));

% plot(z7);
% imshow(im2);



