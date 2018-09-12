
clc
clear
im2 = (imread('/Users/INNOCENTBOY/Downloads/videos/Imageprocessing/week5/stan.jpg'));
% imshow(im2);

h = (1/8 )*ones(3,3);
h(3,3)=0;


z =  fftshift(fft2(h,256,256));
z1 = abs(z);

z7 = mat2gray((z1));

k1 = 1:1:256;
k2 = 1:1:256;
[k1,k2] = meshgrid(k1,k2);

l1 = h.';
vector_h = l1(:);
vector_h = vector_h';
z_dash =  fftshift(fft2(vector_h,1,256));
z_dash_abs = abs(z_dash);
x = 1:256;

im = imfilter(im2,vector_h,'symmetric'  );
im_fft =  fftshift(fft2(im,256,256));
im_fft_abs = abs(im_fft);
im_fft_mat = mat2gray((im_fft_abs));

k1 = 1:1:256;
k2 = 1:1:256;
[k1,k2] = meshgrid(k1,k2);

figure

subplot(2,2,1),plot(x,z_dash_abs);
subplot(2,2,2),mesh(k1,k2,z7);
subplot(2,2,3),mesh(k1,k2,im_fft_mat);


% plot(z7);
% imshow(im2);



