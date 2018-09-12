clc
clear all;
close all;

% im = double(rgb2gray(imread('/Users/INNOCENTBOY/Downloads/videos/Imageprocessing/week6/original_cameraman.jpg')));
% im = imresize(im,[256,256]);
i = 1:4;
mat = reshape(i,2,2)';
Mu=3.999; % Parameter of map
xlog= 20;
ylog= 22;
zlog= 19;
k_5 = 34;
k_6 = 40;
k_7 = 36;

for k=2:numel(mat)+2
    xlog(1,k)=mod(Mu*k_5*ylog(1,k-1)*(1-xlog(1,k-1)+zlog(1,k-1)),1);
    ylog(1,k)=mod(Mu*k_6*ylog(1,k-1)+zlog(1,k-1)*1/(1+(xlog(1,k-1)^2)),1);
    zlog(1,k)=mod(Mu*(xlog(1,k-1)+ylog(1,k-1)+k_7)*sin(zlog(1,k-1)),1);
end
xlog = xlog(3:numel(xlog));
ylog = ylog(3:numel(ylog));
zlog = zlog(3:numel(zlog));

clear i Mu k_5 k_6 k_7 k ylog zlog;
% [r,c]=size(mat);
% shift_count = 0;
% for i = 1:4:r-4+1
%     for j = 1:4:c-4+1
%
%         matrix_gen = mat(i:i+4-1,j:j+4-1);
%         stream_mat = matrix_gen';
%         stream_mat = stream_mat(:);
%
%         shift_count = shift_count+1;
%     end
% end
mat_stream = bin_arr(mat);
arr_new = zeros(1,numel(mat_stream));
xlog = ceil(xlog*numel(mat));

x = 1:numel(mat);
for i = 1:1:numel(mat)
    j = xlog(i);
    tem = x(i);
    x(i) = x(j);
    x(j) = tem;
end

for i = 1:1:numel(mat_stream)
    j = x(i);
        Z1 = mat_stream(i);
        Z2 = mat_stream(j);
        Z3 = bitxor(Z1,Z2);
        arr_new(i) = Z3;
        arr_new(j) = Z1;
%     Z1 = mat_stream(i);
%     Z2 = mat_stream(j);
%     arr_new(i) = Z2;
%     arr_new(j) = Z1;
end

mat_enc = bin_arr_dec(arr_new,mat);
clear  Z1 Z2 Z3 i j;

mat_enc_stream = bin_arr(mat_enc);
arr_new1 = zeros(1,numel(mat_enc_stream));
for i = numel(mat_enc_stream):-1:1
    j = x(i);
        Z3 = mat_enc_stream(i);
        Z1 = mat_enc_stream(j);
        Z2 = bitxor(Z1,Z3);
        arr_new1(i) = Z1;
        arr_new1(j) = Z2;
%     Z3 = mat_enc_stream(i);
%     Z1 = mat_enc_stream(j);
%     arr_new1(i) = Z1;
%     arr_new1(j) = Z3;
%     
end

mat_dec = bin_arr_dec(arr_new1,mat_enc);
clear  Z1 Z2 Z3 i j;
