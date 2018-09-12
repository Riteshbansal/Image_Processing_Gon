
clc
clear all
close all
im = rgb2gray(imread('/Users/INNOCENTBOY/Downloads/videos/Imageprocessing/week6/original_cameraman.jpg'));
k1 = 1:1:size(im,1);
k2 = 1:1:size(im,2);
[k1,k2] = meshgrid(k1,k2);

R = 20;
h = zeros(size(im));
for i = 1:1:size(im,1)
    
    for j = 1:1:size(im,1)
        
        if(sqrt(i^2+j^2) <=R)
            h(i,j) = 1/(pi * R^2);
        else
            
             h(i,j) = 0;
        end 
    end
end

h_fft =  fftshift(fft2(h,size(im,1),size(im,2)));

im1_fft =  fftshift(fft2(im));
    im2 = ifft2(fftshift(im1_fft.*h_fft));
    
    imshow(mat2gray(im2));


