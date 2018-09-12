
clc
clear
im = rgb2gray(imread('/Users/INNOCENTBOY/Downloads/videos/Imageprocessing/week6/original_cameraman.jpg'));
%% Filter
h = (1/8 )*ones(3,3);
h(3,3)=0;
l1 = h.';
vector_h = l1(:);
vector_h = vector_h';

%% block circulant matrix
block_circulant_mat = zeros(numel(vector_h),numel(vector_h));
for i =1:1:numel(vector_h)
    k = vector_h';
    k = circshift(k,i-1,1);
    block_circulant_mat(:,i) = k(:,:);
end

%% Blurred image
im1 = imfilter(im,vector_h,'symmetric'  );

%% im  = image
%  im2 = blurred image
%  h = filter

%% INVERSE FILTER

h_fft =  fftshift(fft2(vector_h,size(im,1),size(im,2)));
im1_fft =  fftshift(fft2(im1));

f  = zeros(size(im,1),size(im,2));
        T = 0.1;

for i = 1:1:size(im,1)
    for j = 1:1:size(im,2)
        l = abs(h_fft(i,j));
        if(abs(h_fft(i,j))>=T)
            
            f(i,j) = (conj(h_fft(i,j)*im1_fft(i,j)))/(abs(h_fft(i,j)).^2);
        else
            
            f(i,j) = 0;
        end
    end
    
end
inverse_freq = zeros(size(h_fft));
inverse_freq(abs(h_fft) < T) = 0;
inverse_freq(abs(h_fft) >= T) = 1 ./ h_fft(abs(h_fft) >= T);
restored_freq = im1_fft .* inverse_freq;
restored = ifft2(fftshift(restored_freq));

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
k1 = 1:1:size(im,1);
k2 = 1:1:size(im,2);
[k1,k2] = meshgrid(k1,k2);
x = 1:512;
figure
subplot(2,3,1),mesh(k1,k2,im_fft_mat);
subplot(2,3,2),imshow(im1);
subplot(2,3,3),imshow(im);
subplot(2,3,4),imshow(im2uint8(im2));
subplot(2,3,5),plot(x,y1);
subplot(2,3,6),plot(x,y);

% plot(z7);
% imshow(im2);



