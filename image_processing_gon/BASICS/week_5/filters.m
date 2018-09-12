clc
clear
% h = double(rgb2gray(imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/512/4.2.04.tiff')));
% im = rgb2gray(im);
% im = double(im);
h = ones(7,7);
h=h/49;
z =  fftshift(fft2(h,512,512));
z1 = abs(z);
% z2 = angle(z);
% z3 = real(z);
% z4 = imag(z);
% z5 = log10(z1);
% z7 = mat2gray(log(1+z1));
z7 = mat2gray(10*log10(z1));

k1 = 1:1:512;
k2 = 1:1:512;
[k1,k2] = meshgrid(k1,k2);
mesh(k1,k2,z7);
% mesh(k1,k2,im);

% imshow(z7);

%% shifted -1 times
% a = ones(512,512);
% for n1=1:1:512
%     for n2=1:1:512
%         k = (-1)^(n1+n2);
%     a(n1,n2)= k* a(n1,n2);
%     end
% end
% 
% z6 = im.*a;
% z6 =  (fft2(z6));
% 
% z6 = abs(z6);
% z6 = mat2gray(log(1+z6));
% 
% mesh(k1,k2,z6);
% 
% % surf(k1,k2,z1)


% plot(abs(z));