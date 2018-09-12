
clc
clear all
close all
im = (rgb2gray(imread('/Users/INNOCENTBOY/Downloads/videos/Imageprocessing/week6/original_cameraman.jpg')));
im = imresize(im,[256,256]);
k1 = 1:1:size(im,1);
k2 = 1:1:size(im,2);
[k1,k2] = meshgrid(k1,k2);

%% Filter
h = (1/8)*ones(3,3);
h(3,3)=0;
l1 = h.';
vector_h = l1(:);
vector_h = vector_h';
bl_ci_H = block_circulatnt_matrix(h);
c = [0.00,0.25,0.00;0.25,-1.00,0.25;0.00,0.25,0.00];
bl_ci_C = block_circulatnt_matrix(c);

%% Blurred image
im1_blurred = (imfilter(im,vector_h,'symmetric'  ));
im1 = double(imnoise(im1_blurred, 'gaussian', 0, 1e-4));


%% im  = image
%  im2 = blurred image
%  h = filter

%% Iterative algorithm FILTER

h_fft =  fftshift(fft2(vector_h,size(im,1),size(im,2)));
c_fft =  fftshift(fft2(c,size(im,1),size(im,2)));
alpha = 0.01;


beta = 1.5;
im1_fft =  fftshift(fft2(im1));
k =3;
% [R,f] = f_k_cls(h_fft,im1_fft,c_fft,alpha);
% f = ((beta*(conj(h_fft))).*im1_fft) +((1-(beta*(abs(h_fft).^2)) + (alpha*(abs(c_fft).^2))).*f);
% im2 = ifft2(fftshift(f));
im2(:,:) = im1(:,:);
fnew = im2(:,:);
w2 = zeros(size(im));
w1 = ones(size(im));
inp = 2;
im_to(:,:) = im1(:,:);
count = 1;
while(k>1)

for i = 2:1:size(im,1)-1
    var = 0;
    for j = 2:1:size(im,2)-1
       
        mat = zeros(3,3);
        d = 1;
        x1 = i;
        y1 = j;
        for i1 = -1:1:1
            for j1 = -1:1:1
                mat(i1+2,j1+2) = im2(x1+(i1*d),y1+(j1*d));
            end
        end
        mean_val=mean2(mat);
        mat2=mat-mean_val;
        var=(sum(sum((mat-mean_val).^2)));
        v = 1/var;        
        w2(i,j) = v;
    end
end

w2(w2>1) = 1;
w2(w2<0) = 0;
[w2_mat,midval] = normalized_his(w2,count);
count= count+1;
w2(w2>midval) = 1;
w2(w2<=midval) = 0;
w1_mat = 1-w2_mat;

imshow((w2));
for i = 2:1:size(im,1)-1
    for j = 2:1:size(im,2)-1
        w1 = w1_mat(i,j);
        w2 = w2_mat(i,j);
        l1_1= beta * conv2(bl_ci_H',(w1'*w1*im_to(i,j)));
        l1 = ifft2(fft2(l1_1,1,1));
        l2_1 = ifft2(fft2(conv2(bl_ci_H',(conv2(w1',conv2(w1,bl_ci_H)))),1,1));
        l2_2 = ifft2(fft2(conv2(bl_ci_C',(conv2(w2',conv2(w2,bl_ci_C)))),1,1));
        l2 = (1-(beta*(l2_1+(alpha*l2_2))))*im_to(i,j);
        fnew(i,j) =l1+l2;
    end
end
im2(:,:) = fnew(:,:);
im_to(:,:) = fnew(:,:);
 k = k-1;
figure(),imshow(uint8(im2));
end
% figure
x = 1:512;
figure
subplot(2,2,1),mesh(k1,k2,mat2gray(abs(1-(beta*h_fft))));
subplot(2,2,2),mesh(k1,k2,mat2gray(abs(h_fft)));

subplot(2,3,2),mesh(k1,k2,mat2gray(abs(c_fft).^2));
subplot(2,3,3),mesh(k1,k2,mat2gray(l));
subplot(2,2,2),imshow((im));
subplot(2,2,3),imshow((im1));
subplot(2,2,4),imshow(mat2gray(abs(im2)));

plot(z7);
imshow(im2);



