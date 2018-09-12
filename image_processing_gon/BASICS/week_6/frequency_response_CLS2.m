
clc
clear
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
c = [0.00,0.25,0.00;0.25,-1.00,0.25;0.00,0.25,0.00];
l1 = c.';
vector_c = l1(:);
vector_c = vector_c';
block_circulant_mat_C = block_circulatnt_matrix(c);

%% Blurred image
im1 = imfilter(im,vector_h,'symmetric'  );

%% im  = image
%  im2 = blurred image
%  h = filter

%% CLS FILTER

h_fft =  fftshift(fft2(vector_h,size(im,1),size(im,2)));

c_fft =  fftshift(fft2(c,size(im,1),size(im,2)));

alpha = 0.1;
l = ((abs(h_fft)).^2)+(alpha*((abs(c_fft)).^2));
f  = zeros(size(im,1),size(im,2));
im1_fft =  fftshift(fft2(im1));

for i = 1:1:size(im,1)
    for j = 1:1:size(im,2)
        T = 0.1;
         
            f(i,j) = conj(h_fft(i,j)*im1_fft(i,j))/l(i,j);

    end
    
end
f = fftshift(conj(f));
im2 = ifft2((f));
%% figure
% x = 1:512;
figure
subplot(2,3,1),mesh(k1,k2,mat2gray(abs(h_fft).^2));
subplot(2,3,2),mesh(k1,k2,mat2gray(abs(c_fft).^2));
subplot(2,3,3),mesh(k1,k2,mat2gray(l));
% subplot(2,3,4),imshow((im));
% subplot(2,3,5),imshow((im1));
% subplot(2,3,6),imshow(mat2gray(abs(im2)));

% plot(z7);
% imshow(im2);



