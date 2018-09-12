
clc
clear all
close all
im = (rgb2gray(imread('/Users/INNOCENTBOY/Downloads/videos/Imageprocessing/week6/original_cameraman.jpg')));

k1 = 1:1:size(im,1);
k2 = 1:1:size(im,2);
[k1,k2] = meshgrid(k1,k2);
%% Filter

h = (1/8 )*ones(3,3);
h(3,3)=0;
l1 = h.';
vector_h = l1(:);
vector_h = vector_h';
block_circulant_mat_H = block_circulatnt_matrix(h);
c = [0.00,0.25,0.00;0.25,-1.00,0.25;0.00,0.25,0.00];
block_circulant_mat_C = block_circulatnt_matrix(c);

%% Blurred image
im1_blurred = imfilter(im,vector_h,'symmetric'  );
im1 = double(imnoise(im1_blurred, 'gaussian'));


%% im  = image
%  im2 = blurred image
%  h = filter

%% Iterative algorithm FILTER

h_fft =  fftshift(fft2(vector_h,size(im,1),size(im,2)));
c_fft =  fftshift(fft2(c,size(im,1),size(im,2)));
alpha = 0.01;


beta = 1.5;
im1_fft =  fftshift(fft2(im1));
k =0;
inp = 2;
[R,f] = f_k_cls(h_fft,im1_fft,c_fft,alpha);
f = ((beta*(conj(h_fft))).*im1_fft) +((1-(beta*(abs(h_fft).^2)) + (alpha*(abs(c_fft).^2))).*f);
im2 = ifft2(fftshift(f));
fnew = im2(:,:);
tic
for i = 2:1:size(im,1)-1
    var = 0;
    for j = 2:1:size(im,2)-1
        var = 0;
        
        row_str = i-1;
        row_end = i+1;
%         if(i==1)
%             row_str = 1;
%         end
%         if(i==size(im,1))
%             row_end = size(im,1);
%         end
        col_str = j-1;
        col_end = j+1;
%         if(j==1)
%             col_str = 1;
%         end
%         if(j==size(im,2))
%             col_end = size(im,2);
%         end
        mat = zeros(3,3);
        d = 1;
        x1 = i;
        y1 = j;
        for i1 = -1:1:1
            for j1 = -1:1:1
                mat(i1+2,j1+2) = im2(x1+(i1*d),y1+(j1*d));
            end
        end
        mean_val =mean2( mat);
        
        var = (sum(sum((mat-mean_val).^2)));
        w2 = 1/var;
        w1 = 1-w2;
        l1_1= beta * conv2(h',(w1'*w1*im1(i,j)));
        l1 = ifft2(fft2(l1_1,1,1));
        l2_1 = ifft2(fft2(conv2(h',(conv2(w1',conv2(w1,h)))),1,1));
        l2_2 = ifft2(fft2(conv2(c',(conv2(w2',conv2(w2,c)))),1,1));
        l2 = (1-(beta*(l2_1+(alpha*l2_2))))*im2(i,j);
        fnew(i,j) =l1+l2;
    end
end
toc

%% figure
% x = 1:512;
% figure
% subplot(2,2,1),mesh(k1,k2,mat2gray(abs(1-(beta*h_fft))));
% subplot(2,2,2),mesh(k1,k2,mat2gray(abs(h_fft)));

% subplot(2,3,2),mesh(k1,k2,mat2gray(abs(c_fft).^2));
% subplot(2,3,3),mesh(k1,k2,mat2gray(l));
% subplot(2,2,2),imshow((im));
% subplot(2,2,3),imshow((im1));
% subplot(2,2,4),imshow(mat2gray(abs(im2)));

% plot(z7);
% imshow(im2);



