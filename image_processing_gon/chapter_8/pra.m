clc
clear
% % 
% % a = {'aaaa';'bbbb'};
% % % X = [1,2,3,4;19,5,7,8];
% % % I = [1,9,10;2,12,13];
% % % 
% % % Y(:,1) = X(I(:,1),1); 
% % 
% % A = {1,2,3;3,5,9};

x = (imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/256/4.1.01.tiff'));

a1 = x(:,:,1);
a2 = x(:,:,2);
a3 = x(:,:,3);
imshow(a1);
imshow(a2);
imshow(a3);

% x = 1:4;
% x = reshape(x,2,2);
% x = (x');
% x(64:178,64:178) = 0;
% Y = dct(x);
% imshow(uint8(x));
% imshow(uint8(Y));
% n=2;
% e = -1i;
% d = e*(0:n-1);
% c = d*pi;
% b = c/(2*n);
% a = exp(b);
% ww = (a/sqrt(2*n)).';
