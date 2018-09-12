clc
clear all
close all

% im = (rgb2gray(imread('/Users/INNOCENTBOY/Downloads/videos/Imageprocessing/week6/original_cameraman.jpg')));
% src = '/Users/INNOCENTBOY/Documents/MATLAB/4.2.04.tiff' ;
src = '/Users/INNOCENTBOY/Documents/MATLAB/pic/512/4.2.04.tiff';
im = double(rgb2gray(imread(src)));
% im=im+1;
Mu=3.999; % Parameter of map
xlog1= 20;
ylog1= 22;
zlog1= 19;
k_5 = 34;
k_6 = 40;
k_7 = 36;
[r,c]=size(im);
p = 512;
mea = 1;
N= numel(im);
for k=2:N+2
    xlog1(1,k)=mod(Mu*k_5*ylog1(1,k-1)*(1-xlog1(1,k-1)+zlog1(1,k-1)),1);
    ylog1(1,k)=mod(Mu*k_6*ylog1( 1,k-1)+zlog1(1,k-1)*1/(1+(xlog1(1,k-1)^2)),1);
    zlog1(1,k)=mod(Mu*(xlog1(1,k-1)+ylog1(1,k-1)+k_7)*sin(zlog1(1,k-1)),1);
end

xlog = xlog1(1,3:end);
ylog = ylog1(1,3:end);
zlog = zlog1(1,3:end);

clearvars -except xlog zlog ylog p  im mea r c


% im = (rgb2gray(imread('/Users/INNOCENTBOY/Downloads/videos/Imageprocessing/week6/original_cameraman.jpg')));
% src = '/Users/INNOCENTBOY/Documents/MATLAB/4.2.04.tiff' ;
% src = '/Users/INNOCENTBOY/Documents/MATLAB/pic/256/4.1.01.tiff';
% im = (rgb2gray(imread(src)));
% im = double(imresize(im,[256,256]));
% im = 1:(16*16);
% im = reshape(im,16,16)';
% [r,c]=size(im);


%% ENC
new_mat = zeros(size(im));

count = 1;
[xsin1,xlog1] = chaotic_map(xlog(1),512);
xsin1 = 1+floor(mod(xsin1(3:end)*10^6,255));
xlog1 = 1+floor(mod(xlog1(3:end)*10^6,255));
% xsin1 = reshape(xsin1,size(im,1),size(im,2))';
% xlog1 = reshape(xlog1,size(im,1),size(im,2))';
enc(:,:) = im(:,:);
% mea = floor(mean2(im));
% enc (1,1) = bitxor(enc (1,1),mea);
tic
% enc = mat_diffussion3(enc,xsin1,xlog1);
% enc = vignere(enc,xlog1);
for i = 1:p:r-p+1
    for j = 1:p:c-p+1

        matrix_gen = enc(i:i+p-1,j:j+p-1);
        [linker] = encrypt_dwt3(matrix_gen,xlog(count),mea,xlog,ylog);
        new_mat(i:i+p-1,j:j+p-1) = linker(:,:);
    end
end
% xlog_per_main = 1+floor(mod(xlog*10^6,r));
% ylog_per_main = 1+floor(mod(ylog*10^6,c));
% 
% new_mat = confusion_impl(new_mat,xlog_per_main,ylog_per_main);
% new_mat = xor_operation(new_mat);

max_val = max(max(new_mat));
min_val = min(min(new_mat));

% if(max_val>255|| min_val<0)
    max_val
    min_val
% end
toc


% % %% ENC 2
% % [r,c]=size(im);
% % new_mat_2 = zeros(size(im));
% % 
% % count = 1;
% % im1(:,:) = im(:,:);
% % im1(1,1) = 0;
% % % im1 = mat_diffussion3(im1,xsin1,xlog1);
% % % im1 = vignere(enc,im1);
% % 
% % for i = 1:p:r-p+1
% %     for j = 1:p:c-p+1
% % 
% %         matrix_gen = im1(i:i+p-1,j:j+p-1);
% %         [linker] = encrypt_dwt3(matrix_gen,xlog(count));
% %         new_mat_2(i:i+p-1,j:j+p-1) = linker(:,:);
% %     end
% % end

% xlog_per_main = 1+floor(mod(xlog*10^6,r));
% ylog_per_main = 1+floor(mod(ylog*10^6,c));
% 
% new_mat_2 = confusion_impl(new_mat_2,xlog_per_main,ylog_per_main);
% new_mat_2 = xor_operation(new_mat_2);

toc

%% DEC
[r,c]=size(im);
new_mat_dec = zeros(size(im));
% new_mat_fordec = xor_operation(new_mat);

% new_mat_fordec(:,:) = new_mat(:,:);
% new_mat_fordec = confusion_impl_rev(new_mat,xlog_per_main,ylog_per_main);

count = 1;
for i = r-p+1:-p:1
    for j = c-p+1:-p:1

        matrix_gen2 = new_mat(i:i+p-1,j:j+p-1);
        linker = decrypt_dwt3(matrix_gen2,xlog(count),mea,xlog,ylog);
        new_mat_dec(i:i+p-1,j:j+p-1) = linker(:,:);
    end
end

[xsin1,xlog1] = chaotic_map(xlog(1),512);
xsin1 = 1+floor(mod(xsin1(3:end)*10^6,255));
xlog1 = 1+floor(mod(xlog1(3:end)*10^6,255));
% xsin1 = reshape(xsin1,size(new_mat_dec,1),size(new_mat_dec,2))';
% xlog1 = reshape(xlog1,size(new_mat_dec,1),size(new_mat_dec,2))';
% new_mat_dec = vignere_rev(new_mat_dec,xlog1);

% new_mat_dec = mat_rev_diffussion3(new_mat_dec,xsin1,xlog1);
% new_mat_dec (1,1) = bitxor(new_mat_dec (1,1),mea);

clearvars -except new_mat im new_mat_2 new_mat_dec r c p pix mat mea
%% Results

% %  new_mat(new_mat<-127) = -127;
% % new_mat(new_mat>127) = 127;

enc_image = ((new_mat));
enc_image1 = floor(normalized_his(ceil(enc_image)));
[x,y] = corelation((im),floor(abs((new_mat))));
PSNR = sum(sum((((new_mat_dec)-im).*((new_mat_dec)-im))));
PSNR = PSNR/(r*c);
PSNR = 20 * log10(255/ sqrt(PSNR));

PSNR1 = sum(sum((((new_mat)-im).*((new_mat)-im))));
PSNR1 = PSNR1/(r*c);
PSNR1 = 20 * log10(255/ sqrt(PSNR1));

new_mat_dec =floor(new_mat_dec);
x1 =im - new_mat_dec;
entropy_i_enc = entropy(uint8(enc_image));
entropy_i_enc1 = entropy(uint8(enc_image1));
figure()
subplot(2,2,1),imshow(uint8(new_mat));
subplot(2,2,2),imshow(uint8(new_mat_dec));

% subplot(2,2,2),imhist(uint8(img_enc));
fontSize = 20;
% % [r,g,b] = three_3d_im(im);
% % subplot(2,2,2),scatter3(r, g, b, 3),title('Histogram Orignal');
% % xlabel('R', 'FontSize', fontSize);
% % ylabel('G', 'FontSize', fontSize);
% % zlabel('B', 'FontSize', fontSize);
% % 
% % % r = enc_image1(:,:,1);
% % % g = enc_image1(:,:,2);
% % % b = enc_image1(:,:,3);
% % [r,g,b] = three_3d_im(im2uint8(enc_image1));
% % 
% % subplot(2,2,3),scatter3(r, g, b, 3),title('Histogram enc');
% % xlabel('R', 'FontSize', fontSize);
% % ylabel('G', 'FontSize', fontSize);
% % zlabel('B', 'FontSize', fontSize);
% % 
% % [r,g,b] = three_3d_im(im2uint8(mat2gray(new_mat)));
% % 
% % subplot(2,2,4),scatter3(r, g, b, 3),title('Histogram enc');
% % xlabel('R', 'FontSize', fontSize);
% % ylabel('G', 'FontSize', fontSize);
% % zlabel('B', 'FontSize', fontSize);
% 
% entropy_i_main = entropy(uint8(im));
% res = NPCR_and_UACI((((new_mat))),(((new_mat_2))),1);
% zz=corr2(enc_image,im);
% figure()
% subplot(1,2,1),imshow(uint8(new_mat_dec));
% subplot(1,2,2),imhist(uint8(enc_image1))