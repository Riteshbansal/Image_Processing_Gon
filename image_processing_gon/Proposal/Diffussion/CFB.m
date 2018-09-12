clc
clear all;
close all;

% im = double(rgb2gray(imread('/Users/INNOCENTBOY/Downloads/videos/Imageprocessing/week6/original_cameraman.jpg')));
% im = imresize(im,[256,256]);
i = 1:64;
mat = reshape(i,8,8)';
Mu=3.999; % Parameter of map
xlog= 20;
ylog= 22;
zlog= 19;
k_5 = 34;
k_6 = 40;
k_7 = 36;

for k=2:16   
    xlog(1,k)=mod(Mu*k_5*ylog(1,k-1)*(1-xlog(1,k-1)+zlog(1,k-1)),1);
    ylog(1,k)=mod(Mu*k_6*ylog(1,k-1)+zlog(1,k-1)*1/(1+(xlog(1,k-1)^2)),1);
    zlog(1,k)=mod(Mu*(xlog(1,k-1)+ylog(1,k-1)+k_7)*sin(zlog(1,k-1)),1); 
end
clear i Mu k_5 k_6 k_7 xlog ylog zlog k;
[r,c]=size(mat); 
pix = 1;
new_mat = zeros(size(mat));
for i = 1:4:r-4+1
    for j = 1:4:c-4+1
        matrix_gen = mat(i:i+4-1,j:j+4-1);
        linker = encrypt_fn(matrix_gen,pix);
        pix = linker(size(linker,1),size(linker,2));
        new_mat(i:i+4-1,j:j+4-1) = linker(:,:);
    end
end
 