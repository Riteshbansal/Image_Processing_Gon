
clc
clear
im = rgb2gray(imread('/Users/INNOCENTBOY/Downloads/videos/Imageprocessing/week6/original_cameraman.jpg'));
k1 = 1:1:size(im,1);
k2 = 1:1:size(im,2);
[k1,k2] = meshgrid(k1,k2);
%% Filter

h = (1/8 )*ones(3,3);
h(3,3)=0;
block_circulant_mat_H = block_circulatnt_matrix(h);
c = [0.00,0.25,0.00;0.25,-1.00,0.25;0.00,0.25,0.00];
block_circulant_mat_C = block_circulatnt_matrix(c);


% % l1 = h.';
% % vector_h = l1(:);
% % vector_h = vector_h';
% % 
% % %% block circulant matrix
% % block_circulant_mat = zeros(numel(vector_h),numel(vector_h));
% % for i =1:1:numel(vector_h)
% %     k = vector_h';
% %     k = circshift(k,i-1,1);
% %     block_circulant_mat(:,i) = k(:,:);
% % end

%% Blurred image
im1 = imfilter(im,h,'symmetric'  );

%% im  = image
%  im2 = blurred image
%  h = filter

%% CLS FILTER

h_fft =  fftshift(fft2(h,size(im,1),size(im,2)));
c_fft =  fftshift(fft2(c,size(im,1),size(im,2)));
alpha = 0.1;
l = ((abs(h_fft)).^2)+(alpha*((abs(c_fft)).^2));
mesh(k1,k2,mat2gray(l));
 im1_fft =  fftshift(fft2(im1));

f  = zeros(size(im,1),size(im,2));

for i = 1:1:size(im,1)
    for j = 1:1:size(im,2)
        l = abs(h_fft(i,j));
        T = 0.1;
        if(abs(h_fft(i,j))>=T)
            
            f(i,j) = (conj(h_fft(i,j)*im1_fft(i,j)))/(abs(h_fft(i,j)).^2);
%         else
%             
%             f(i,j) = 0;
        end
    end
    
end
f = fftshift(conj(f));
im2 = ifft2((f));
y = (abs(fftshift(fft2(vector_h,1,size(im,2)))));
y1 = y(:,:);
for j = 1:1:size(im,2)
    T = 0.1;
    if(abs(y(1,j))>=T)
        y1(1,j) = y(1,j).^-1;
    else
        y1(1,j) = 0;
    end
end

y = y.^-1;



%% figure
im_fft_abs = abs(im1_fft);
im_fft_mat = mat2gray((im_fft_abs));

x = 1:512;
figure
subplot(2,3,1),mesh(k1,k2,im_fft_mat);
subplot(2,3,2),imshow(im1);
subplot(2,3,3),imshow(im);
subplot(2,3,4),imshow(mat2gray(im2));
subplot(2,3,5),plot(x,y1);
subplot(2,3,6),plot(x,y);

% plot(z7);
% imshow(im2);



