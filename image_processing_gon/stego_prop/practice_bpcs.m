clc
clear
% im = rgb2gray(imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/4.2.04.tiff'));
im1 = double(imread('128_p.jpg'));
im = im1(:,:,3);
im2(:,:,:) = im1(:,:,:);

data = 'ABCDEFABCDEFABCD';
A = double(int16(data));
[comp1, comp, prob1] = huff_enc(A);

[M ,N] = size(im);
im_1= zeros(M,N);
im_2= zeros(M,N);
im_3= zeros(M,N);
im_4= zeros(M,N);
im_5= zeros(M,N);
im_6= zeros(M,N);
im_7= zeros(M,N);
im_8= zeros(M,N);
im_9= zeros(M,N);

for j = 1:1:M
    for k = 1:1:N
        pix = im(j,k);
        pix_bin = de2bi(pix,8,'left-msb');
        im_1(j,k) = pix_bin(8);
        im_2(j,k) = pix_bin(7);
        im_3(j,k) = pix_bin(6);
        im_4(j,k) = pix_bin(5);
        im_5(j,k) = pix_bin(4);
        im_6(j,k) = pix_bin(3);
        im_7(j,k) = pix_bin(2);
        im_8(j,k) = pix_bin(1);
    end
end
[LL,LH,HL,HH] = dwt2(im_1,'haar');

p=8;
[r,c] = size(im_1);
for i = 1:p:r-p+1
    for j = 1:p:c-p+1
        matrix_gen = im_3(i:i+p-1,j:j+p-1);
        comp = complexity(matrix_gen);

    end
end

[LL,LH,HL,HH] = dwt2(im_1,'haar');
Mu = 3.99;
xlog1= 20.1;
ylog1= 22;
zlog1= 19;
k_5 = 34;
k_6 = 40;
k_7 = 36;
[xlog2,ylog2,zlog2] = keyset(LL,Mu,xlog1,ylog1,zlog1,k_5,k_6,k_7);
[row,col]=size(LL);
I_gr = 1:row;
I_row = confusion_impl2(I_gr,1,xlog2);
I_col = confusion_impl2(I_gr,1,ylog2);

k = numel(comp1);

count = 1;
for i = 1:1:row
    for j = 1:1:col
        temp = LL(I_row(i),I_col(j));
        LL(I_row(i),I_col(j)) = pix_mod(temp,comp1(count,1));
        count = count+1;
        if(count>k)
            break;
        end
    end
    if(count>k)
        break;
    end
end

[im_1_] = idwt2(LL,LH,HL,HH,'haar');
% im_10 = im_8*128 + im_7*64 +im_6*32+im_5*16+im_4*8+im_3*4+im_2*2+im_1*1;
im_10 = im_8*128 + im_7*64 +im_6*32+im_5*16+im_4*8+im_3*4+im_2*2+im_1_*1;
im_11= (im_10);
im2(:,:,3) = im_11(:,:);
psnr = PSNR_CAL(double(im1),double(im2));
   figure;
subplot(4,4,1),imshow(im),title('Plain image');
subplot(4,4,2),imshow(im2uint8(im_1)),title('image 1');
subplot(4,4,3),imshow(im2uint8(im_2)),title('image 2');
subplot(4,4,4),imshow(im2uint8(im_3)),title('image 3');
subplot(4,4,5),imshow(im2uint8(im_4)),title('image 4');
subplot(4,4,6),imshow(im2uint8(im_5)),title('image 5');
subplot(4,4,7),imshow(im2uint8(im_6)),title('image 6');
subplot(4,4,8),imshow(im2uint8(im_7)),title('image 7');
subplot(4,4,9),imshow(im2uint8(im_8)),title('image 8');
subplot(4,4,10),imshow(im2uint8(im_9)),title('intensity transformation');
subplot(4,4,11),imshow(uint8(im_10)),title('Reconstruction');

