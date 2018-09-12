clc
clear
% x = double(rgb2gray(imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/256/4.1.01.tiff')));

x = [1,2,3;4,5,6;];
% h = [-1,-1,-1;-1,9,-1;-1,-1,-1];
h = ones(5,5);
h = h/25;
% h = [1,1;1,1];
M= size(x,1);
N= size(x,2);
m= size(h,1);
n= size(h,2);
c= zeros(M+m-1,N+n-1);
c2 = zeros(M+(2*(m-1)),N+(2*(n-1)));

y(m:-1:1,:) = h(1:m,:);
x2 = zeros(M+(2*(m-1)),N+(2*(n-1)));
x2(m:M+m-1,n:N+n-1) = x(:,:);
var1 = m-1;
var2 = n-1;
for i = 1:1:size(c,1)
    for j = 1:1:size(c,2)
        imp = zeros(M+(2*(m-1)),N+(2*(n-1)));
        imp = impulse_matrix(y,imp, i,j);
        z = imp.*x2;
        c2(i,j) = sum(sum(z));
    end
end

% c(:,:) = c2(2:size(c,1)+1,2:size(c,2)+1);
imfilter