clc
clear
% image = double(rgb2gray(imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/512/4.2.04.tiff')));
x = [1,2,3;4,5,6];
h = ones(2,2);
% h = h/9;
M= size(x,1);
N= size(x,2);
m= size(h,1);
n= size(h,2);
h_conv = zeros(numel(x)+numel(h)-1,numel(x));

y = zeros(numel(x)+numel(h),1);
%% Stacking
% % [r,c] = size(image);
% % 
% % stack_cell = zeros(r*c,1);
% %  
% % for i = 0:1:r-1
% %     kn = image(i+1,:)';
% %    stack_cell(i*r+1:i*r+r,1) = kn(:,:) ;
% % end
l1 = x.';
vector_x = l1(:);

l1 = h.';
vector_h = l1(:);

for i = 1:1:numel(x)
    h_conv(i:i+m*n-1,i) = vector_h(:,:);
end



y = h_conv*vector_x;

% y1 = reshape(M+m-1,N+n-1);

