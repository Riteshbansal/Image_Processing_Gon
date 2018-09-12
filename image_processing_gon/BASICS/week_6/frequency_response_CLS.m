
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
h_fft = zeros(size(im,1),size(im,2));
l1 = h.';
vector_h = l1(:);
vector_h = vector_h';
h_fft_m =  fftshift(fft2(vector_h,1,size(im,2)));


% c_fft = zeros(size(im,1),size(im,2));

% l1 =c.';
% vector_c = l1(:);
% vector_c = vector_c';
c_fft =  fftshift(fft2(c,size(im,1),size(im,2)));
for i = 1:1: size(im,1)
h_fft(i,:) = h_fft_m(:,:);
% c_fft(i,:) = c_fft_m(:,:);
end
alpha = 0.1;
l = ((abs(h_fft)).^2)+(alpha*((abs(c_fft)).^2));


%% figure
x = 1:512;
figure
subplot(2,2,1),mesh(k1,k2,mat2gray(abs(h_fft).^2));
subplot(2,2,2),mesh(k1,k2,mat2gray(abs(c_fft).^2));
subplot(2,2,3),mesh(k1,k2,mat2gray(l));


% plot(z7);
% imshow(im2);



