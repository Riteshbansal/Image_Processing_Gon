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
p = 128;

N = (r*c)/p^2;
if(N<r|| N<c)
    N = r;
end
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
% im = 1:(32*32);
% im = reshape(im,32,32)';
% [r,c]=size(im);


%% ENC
new_mat = zeros(size(im));
pix = [1];
val = 1;
count = 1;
[xsin1,xlog1] = chaotic_map(xlog(1),im);
xsin1 = 1+floor(mod(xsin1(3:end)*10^6,256));
xlog1 = 1+floor(mod(xlog1(3:end)*10^6,256));
% xsin1 = reshape(xsin1,size(im,1),size(im,2))';
% xlog1 = reshape(xlog1,size(im,1),size(im,2))';
enc(:,:) = im(:,:);
% mea = floor(mean2(im));
% enc (1,1) = bitxor(enc (1,1),mea);
tic
enc = mat_diffussion3(enc,xsin1,xlog1);
for i = 1:p:r-p+1
    for j = 1:p:c-p+1

        matrix_gen = enc(i:i+p-1,j:j+p-1);
        [linker,val] = encrypt_dwt3(matrix_gen,val,xlog(count));
        pix = [pix, val];
        new_mat(i:i+p-1,j:j+p-1) = linker(:,:);
        count = count+1;
    end
end
new_mat = new_mat./2;
% xlog_per_main = 1+floor(mod(xlog*10^6,r));
% ylog_per_main = 1+floor(mod(ylog*10^6,c));

% new_mat = confusion_impl(new_mat,xlog_per_main,ylog_per_main);
toc


% % %% ENC 2
% % [r,c]=size(im);
% % new_mat_2 = zeros(size(im));
% % pix = [];
% % val = 1;
% % count = 1;
% % im1(:,:) = im(:,:);
% % im1(1,1) = 0;
% % for i = 1:p:r-p+1
% %     for j = 1:p:c-p+1
% % 
% %         matrix_gen = im1(i:i+p-1,j:j+p-1);
% %         [linker,val] = encrypt_dwt3(matrix_gen,val,xlog(count));
% %         pix = [pix, val];
% %         new_mat_2(i:i+p-1,j:j+p-1) = linker(:,:);
% %         count = count+1;
% %     end
% % end
% % 
% % xlog_per_main = 1+floor(mod(xlog*10^6,r));
% % ylog_per_main = 1+floor(mod(ylog*10^6,c));
% % 
% % new_mat_2 = confusion_impl(new_mat_2,xlog_per_main,ylog_per_main);
% % toc

%% DEC
new_mat1 = new_mat.*2;

[r,c]=size(im);
new_mat_dec = zeros(size(im));
new_mat_fordec(:,:) = new_mat1(:,:);
% new_mat_fordec = confusion_impl_rev(new_mat_fordec,xlog_per_main,ylog_per_main);
pix2 = [];

N =((r*c)/(p^2)) +1;


mat = [1];
for i = 1:p:r-p+1
    for j = 1:p:c-p+1
        if(i == 193 && j== 257)
           val; 
        end
        matrix_gen = new_mat_fordec(i:i+p-1,j:j+p-1);
        enc = matrix_diff2(matrix_gen);
        mat = [mat,enc];
        
    end
end
mat = ceil(abs(mat));
mat (mat<=0) = 0;
count = numel(mat)-1;
for i = r-p+1:-p:1
    for j = c-p+1:-p:1
         if(i == 481 && j== 481)
           val; 
        end
        
        matrix_gen2 = new_mat_fordec(i:i+p-1,j:j+p-1);
        linker = decrypt_dwt3(matrix_gen2,mat(count)+1,xlog(count));
        new_mat_dec(i:i+p-1,j:j+p-1) = linker(:,:);
        count = count -1;
    end
end

[xsin1,xlog1] = chaotic_map(xlog(1),new_mat_dec);
xsin1 = 1+floor(mod(xsin1(3:end)*10^6,256));
xlog1 = 1+floor(mod(xlog1(3:end)*10^6,256));
% xsin1 = reshape(xsin1,size(new_mat_dec,1),size(new_mat_dec,2))';
% xlog1 = reshape(xlog1,size(new_mat_dec,1),size(new_mat_dec,2))';
new_mat_dec = mat_rev_diffussion3(new_mat_dec,xsin1,xlog1);
% new_mat_dec (1,1) = bitxor(new_mat_dec (1,1),mea);

clearvars -except new_mat im new_mat_2 new_mat_dec r c p pix mat mea

enc_image = ((new_mat));
% enc_image1 = floor(normalized_his(enc_image));
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
% entropy_i_enc1 = entropy(uint8(enc_image1));
% 
% entropy_i_main = entropy(uint8(im));
% res = NPCR_and_UACI((((new_mat))),(((new_mat_2))),1);
% zz=corr2(enc_image,im);
% figure()
% subplot(1,2,1),imshow(uint8(new_mat_dec));
% subplot(1,2,2),imhist(uint8(enc_image1))