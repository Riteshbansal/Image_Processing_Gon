% function enco = huffman_encoder(sig, dict)
clc
clear all
close all
% im = imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/256/4.1.01.tiff');
% im = rgb2gray(im);

data = 'ABCDEFABCDEFABCD';
% data = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
A = double(int16(data));
% A = [255,250,122,133,122,43,46,34,22,99];

% im = rgb2gray(imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/4.2.03.tiff'));
% siz = [128,128];
% A = double(imresize(im,siz));

B = A(:);

%% UNIQUE
a1 = A(:).';
a2 = sort(a1);
a3 = diff(a2);
a4 = a3 ~= 0;
a4 = [true, a4];
C = a2(a4);

%% BSXFUN ,  Calculating no of time a pixel is there in matrix
% C = unique();
D = bsxfun(@eq, B,C);
F = sum(D);
G (1,:) = C;
prob = F/numel(A);
G (2,:) = prob;


tic
%% huffman encoder

comp = huffmandict(G (1,:),G (2,:));
l = cell(numel(comp)/2,1);
for  i= 1:1:numel(comp)/2
    l{i} = comp{i};
end
B = A';
C = B(:);
comp1 = huffmanenco(C,comp);
% % %
% % % rem = mod(numel(comp1),8);
% % % add_val = [ zeros(1,8-rem),de2bi(8-rem,8,'left-msb')];
% % %
% % % comp2 = [comp1;add_val'];
% % %
% % % y = reshape(comp2,[8,numel(comp2)/8]);
% % % y = bi2de(y','left-msb');
% % %
% % % yG = prob_find(y);
% % % comp_1 = huffmandict(yG (1,:),yG (2,:));
% % % l = cell(numel(comp)/2,1);
% % % for  i= 1:1:numel(comp_1)/2
% % %     l{i} = comp_1{i};
% % % end
% % % B = y';
% % % C = B(:);
% % % comp1_1 = huffmanenco(C,comp_1);



leng = numel(comp1);
im = rgb2gray(imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/4.2.04.tiff'));
% im = imread('/Users/INNOCENTBOY/Desktop/Ritesh.png');
% im = imresize(im,[1024,1024]);
im = double((im));

%% Stego
Mu = 3.99;
xlog1= 20;
ylog1= 22;
zlog1= 19;
k_5 = 34;
k_6 = 40;
k_7 = 36;
[LL,LH,HL,HH] = dwt2(im,'haar');
[row,col]=size(LL);

[xlog,ylog,zlog] = keyset(LL,Mu,xlog1,ylog1,zlog1,k_5,k_6,k_7);
xlog1 = 1+floor(mod(xlog(1:row)*10^6,row));
ylog1 = 1+floor(mod(ylog(1:col)*10^6,col));

I_gr = 1:row;
I_row = confusion_impl2(I_gr,1,xlog1);
I_gr = 1:col;
I_col = confusion_impl2(I_gr,1,ylog1);
count = 1;
rem = mod(numel(comp1),3);
add_val = [ zeros(1,3-rem),de2bi(3-rem,3,'left-msb')];

comp2 = [comp1;add_val'];
k = numel(comp2)/3;
s1 = comp2(1:k,1);
s2 = comp2(k+1:2*k,1);
s3 = comp2(2*k+1:3*k,1);
for i = 1:1:row
    for j = 1:1:col
        temp = HH(I_row(i),I_col(j));
        HH(I_row(i),I_col(j)) = pix_mod(temp,s1(count,1));
        temp = HL(I_row(i),I_col(j));
        HL(I_row(i),I_col(j)) = pix_mod(temp,s2(count,1));
        temp = LH(I_row(i),I_col(j));
        LH(I_row(i),I_col(j)) = pix_mod(temp,s3(count,1));
        count = count+1;
        if(count>k)
            break;
        end
    end
    if(count>k)
        break;
    end
end

[im2] = idwt2(LL,LH,HL,HH,'haar');

toc
%% Invstego

Mu = 3.99;
xlog1= 20;
ylog1= 22;
zlog1= 19;
k_5 = 34;
k_6 = 40;
k_7 = 36;
[LL,LH,HL,HH] = dwt2(im2,'haar');
[row,col]=size(LL);

[xlog,ylog,zlog] = keyset(LL,Mu,xlog1,ylog1,zlog1,k_5,k_6,k_7);
xlog1 = 1+floor(mod(xlog(1:row)*10^6,row));
ylog1 = 1+floor(mod(ylog(1:col)*10^6,col));

I_gr = 1:row;
I_row = confusion_impl2(I_gr,1,xlog1);
I_gr = 1:col;
I_col = confusion_impl2(I_gr,1,ylog1);
count = 1;
mat = zeros(k,1);
mat1 = zeros(k,1);
mat2 = zeros(k,1);
for i = 1:1:row
    for j = 1:1:col
        temp = HH(I_row(i),I_col(j));
        mat(count,1) = pix_mod_rev(temp);
        temp = HL(I_row(i),I_col(j));
        mat1(count,1) = pix_mod_rev(temp);
        temp = LH(I_row(i),I_col(j));
        mat2(count,1) = pix_mod_rev(temp);
        
        count = count+1;
        if(count>k)
            break;
        end
    end
    if(count>k)
        break;
        
    end
end
mat = [mat;mat1;mat2];
[im2] = idwt2(LL,LH,HL,HH,'haar');


psnr = PSNR_CAL(im,((im2)));
figure();
subplot(1,2,1), imshow(mat2gray(im));
subplot(1,2,2), imshow(mat2gray(im2));

dhsig = huffmandeco(mat,comp);
% dhsig=dhsig';
% dhsig = reshape(dhsig,siz)';
% figure(),imshow(uint8(dhsig));
dhsig=char(dhsig');
% [M ,N] = size(im);
% im_1= zeros(M,N);
% im_2= zeros(M,N);
% im_3= zeros(M,N);
% im_4= zeros(M,N);
% im_5= zeros(M,N);
% im_6= zeros(M,N);
% im_7= zeros(M,N);
% im_8= zeros(M,N);
% im_9= zeros(M,N);
%
% for j = 1:1:M
%     for k = 1:1:N
%         pix = im(j,k);
%         pix_bin = de2bi(pix,8,'left-msb');
%         im_1(j,k) = pix_bin(8);
%         im_2(j,k) = pix_bin(7);
%         im_3(j,k) = pix_bin(6);
%         im_4(j,k) = pix_bin(5);
%         im_5(j,k) = pix_bin(4);
%         im_6(j,k) = pix_bin(3);
%         im_7(j,k) = pix_bin(2);
%         im_8(j,k) = pix_bin(1);
%     end
% end
%
%
%
% im_10 = im_8*128 + im_7*64 +im_6*32+im_5*16+im_4*8+im_3*4+im_2*2+im_1*1;
% im_11= uint8(im_10);
