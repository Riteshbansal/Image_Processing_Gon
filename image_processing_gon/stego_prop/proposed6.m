% function enco = huffman_encoder(sig, dict)
clc
clear all
close all

% im = imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/256/4.1.01.tiff');
% im = rgb2gray(im);
%% Data
data = 'ABCDEFABCDEFABCD';
% data = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
A = double(int16(data));
% im = rgb2gray(imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/4.2.03.tiff'));
% siz = [256,256];
% A = double(imresize(im,siz));
%% Diffusion

A = mat_rev_diffussion4(A);

%% Cover Image
im = (imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/4.2.04.tiff'));
% im = imread('/Users/INNOCENTBOY/Desktop/Ritesh.png');
im = imresize(im,[1024,1024]);
im = double((im));

Mu = 3.99;
xlog1= 20;
ylog1= 22;
zlog1= 19;
k_5 = 34;
k_6 = 40;
k_7 = 36;
pix = 0.1;
B = A(:);

%% UNIQUE
a1 = A(:).';
a2 = sort(a1);
a3 = diff(a2);
a4 = a3 ~= 0;
a4 = [true, a4];
C = a2(a4);

%% BSXFUN ,  Calculating no of time a pixel is there in matrix
D = bsxfun(@eq, B,C);
F = sum(D);
G (1,:) = C;
prob = F/numel(A);
G (2,:) = prob;
g1 = G';
g2 = sort_personal(g1, 2);

%% huffman encoder
prob = g2(:,2);

comp = huffmandict(G (1,:),G (2,:));
l = cell(numel(comp)/2,1);
for  i= 1:1:numel(comp)/2
    l{i} = comp{i};
end
B = A';
C = B(:);
comp1 = huffmanenco(C,comp);

xsini(1,1)=pix;
for i = 2:1:(numel(comp1))+2
    xsini(1,i) = mod(sin(pi * xsini(1,i-1)),1);
end
xsin = 1+floor(mod(xsini(3:end)*10^10,numel(comp1)));
comp1 = confusion_impl2(comp1,xsin,1);


% comp1 = bitxor(comp1,1);
rem = mod(numel(comp1),3);
add_val = [ zeros(1,3-rem),de2bi(3-rem,3,'left-msb')];

comp2 = [comp1;add_val'];
k = numel(comp2)/3;
s1 = comp2(1:k,1);
s2 = comp2(k+1:2*k,1);
s3 = comp2(2*k+1:3*k,1);
tic
%% Stego

R = im(:,:,1);
G = im(:,:,2);
B = im(:,:,3);
[LL,LH,HL,HH] = dwt2(B,'haar');
[LL1,LH1,HL1,HH1] = dwt2(G,'haar');
[LL2,LH2,HL2,HH2] = dwt2(R,'haar');


[row,col]=size(LL);

[xlog2,ylog2,zlog2] = keyset(LL,Mu,xlog1,ylog1,zlog1,k_5,k_6,k_7);
% [xlog2,ylog2,zlog2] = keyset(LL,Mu,xlog1,ylog1,zlog1,k_5,k_6,k_7);

I_gr = 1:row;
I_row = confusion_impl2(I_gr,1,xlog2);
I_col = confusion_impl2(I_gr,1,ylog2);
I_col2 = confusion_impl2(I_gr,1,zlog2);

count = 1;
for i = 1:1:row
    for j = 1:1:col
        temp = HH(I_row(i),I_col(j));
        HH(I_row(i),I_col(j)) = pix_mod(temp,s1(count,1));
        temp = HH1(I_col(i),I_col2(j));
        HH1(I_col(i),I_col2(j)) = pix_mod(temp,s2(count,1));
        temp = HH2(I_col2(i),I_row(j));
        HH2(I_col2(i),I_row(j)) = pix_mod(temp,s3(count,1));
        count = count+1;
        if(count>k)
            break;
        end
    end
    if(count>k)
        break;
        
    end
end

[B] = idwt2(LL,LH,HL,HH,'haar');
[G] = idwt2(LL1,LH1,HL1,HH1,'haar');
[R] = idwt2(LL2,LH2,HL2,HH2,'haar');

im2 = cat(3,R,G,B);
toc
%% Invstego
R = im2(:,:,1);
G = im2(:,:,2);
B = im2(:,:,3);

Mu = 3.99;
xlog1= 20;
ylog1= 22;
zlog1= 19;
k_5 = 34;
k_6 = 40;
k_7 = 36;
[LL,LH,HL,HH] = dwt2(B,'haar');
[LL1,LH1,HL1,HH1] = dwt2(G,'haar');
[LL2,LH2,H2L,HH2] = dwt2(R,'haar');
[row,col]=size(LL);

[xlog2,ylog2,zlog2] = keyset(LL,Mu,xlog1,ylog1,zlog1,k_5,k_6,k_7);

I_gr = 1:row;
I_row = confusion_impl2(I_gr,1,xlog2);
I_col = confusion_impl2(I_gr,1,ylog2);
I_col2 = confusion_impl2(I_gr,1,zlog2);

count = 1;
mat = zeros(k,1);
mat1 = zeros(k,1);
mat2 = zeros(k,1);
for i = 1:1:row
    for j = 1:1:col
        temp = HH(I_row(i),I_col(j));
        mat(count,1) = pix_mod_rev(temp);
        temp = HH1(I_col(i),I_col2(j));
        mat1(count,1) = pix_mod_rev(temp);
        temp = HH2(I_col2(i),I_row(j));
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

[B] = idwt2(LL,LH,HL,HH,'haar');
[G] = idwt2(LL1,LH1,HL1,HH1,'haar');
[R] = idwt2(LL2,LH2,HL2,HH2,'haar');

mat = [mat;mat1;mat2];
% mat = bitxor(mat,1);
kkk=mat2(end-2:end);
kkk= 3+(bi2de(kkk','left-msb'));
mat2 = mat(1:numel(mat)-kkk,1);

xsini(1,1)=pix;
for i = 2:1:(numel(mat2))+2
    xsini(1,i) = mod(sin(pi * xsini(1,i-1)),1);
end
xsin = 1+floor(mod(xsini(3:end)*10^10,numel(mat2)));
mat2 = confusion_impl_rev2(mat2,xsin,1);

psnr = PSNR_CAL(im,((im2)))
figure();
subplot(1,2,1), imshow(mat2gray(im));
subplot(1,2,2), imshow(mat2gray(im2));

dhsig = huffmandeco(mat2,comp);
% dhsig=dhsig';
% dhsig = reshape(dhsig,siz)';
% figure(),imshow(uint8(dhsig));
dhsig=(dhsig');

dhsig = mat_diffussion4(dhsig);
dhsig = char(dhsig);

[qs, qm, qmaps] = imageQualityIndex (im, im2);
qs
qm
[rmn,rpq] =corelation (im,im2)
