clc
clear all
tic
x = imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/256/4.1.07.tiff');
x = double(rgb2gray(x));
% x = ones(3,3);
% x = [2,1,0,1;1,0,200,0;1,0,0,0];


% for n1=0:1:2
%     for n2=0:1:2
%         k = (-1)^(n1+n2);
%         x(n1+1,n2+1)= k* x(n1+1,n2+1);
%     end
% end

[N1 ,N2] = size(x);
y = ones(N1,N2);
for k1=0:1:N1-1
    for k2=0:1:N2-1
    y(k1+1,k2+1) = inside_loop(N1,N2,k1,k2,x);
    end
end

toc
z =  fft2(x);


