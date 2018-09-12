x = imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/512/4.2.04.tiff');
x = double(rgb2gray(x));
% x = [1,2,3;4,5,6];
x(1:5,1:5) = 1;
y = circshift(x,[40 40]);

% % imshow(mat2gray(x));
% % imshow(mat2gray(y));
%% fft
x_dft = fft2(x);
y_dft = fft2(y);

%% Complex Conjugate (Inverse )
z = imshow(mat2gray(ifft2(conj(x_dft))));

%% Phase correlation
a = y_dft.*(conj(x_dft));
b = abs(a);

c = a./b;

d = ifft2(c);

imshow(mat2gray(d));