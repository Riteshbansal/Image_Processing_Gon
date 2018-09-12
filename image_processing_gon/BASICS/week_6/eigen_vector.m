clc
clear
% image = double(rgb2gray(imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/512/4.2.04.tiff')));
x = [1,2,3;4,5,6];
h = (1/8 )*ones(3,3);
h(3,3)=0;
M= size(x,1);
N= size(x,2);
m= size(h,1);
n= size(h,2);
h_circul_conv = zeros(numel(x)+numel(h)-1,numel(x)+numel(h)-1);
vector_x = zeros(numel(x)+numel(h)-1,1);
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
vector_x(1:numel(l1)) = l1(:);

l1 = h.';
vector_h = l1(:);

for i = 1:1:numel(x)+numel(h)-1
    if(i+numel(h)-1<= numel(x)+numel(h)-1)
        
    h_circul_conv(i:i+numel(h)-1,i) = vector_h(:,1);
    else
        var = (i+numel(h)-1)-(numel(x)+numel(h)-1);
        h_circul_conv(i:i+numel(h)-var-1,i) = vector_h(1:numel(h)-var,1);
        h_circul_conv(1:1+var-1,i) = vector_h(numel(h)-var+1:numel(h),1);

    end
end
l =numel(h);
wn = zeros(1,numel(h));
% wn(:,1:numel(h)) = exp((((2*pi)/l)*((1:l)-1))*1i);


mat_wn = ones(numel(h),numel(h));
for i = 1:1:numel(h)
    
    wn(1,i) = exp((((2*pi)/l)*(i-1))*1i);

mat_wn(:,i) = wn(1,i);

end

mat_wn_inverse = inv(mat_wn);
lamda = fft2(vector_h);
lamda_identity = diag(lamda);
 
% H_new = 
% y = h_circul_conv*vector_x;

% y1 = reshape(M+m-1,N+n-1);

