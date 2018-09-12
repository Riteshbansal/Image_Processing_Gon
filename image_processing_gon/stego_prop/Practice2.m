% function enco = huffman_encoder(sig, dict)
clc
clear
% im = imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/256/4.1.01.tiff');
% im = rgb2gray(im);

data = 'ABCDEFABCDEFABCD';
data = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
A = double(int16(data));
% A = [255,250,122,133,122,43,46,34,22,99];
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

g1 = G';
% g2 = sortrows(g1,3);
% [g11,j] = sort(g1(:,3))
% [~,idx]=sort(g1(:,3),'descend');
% g2=g1(idx,:);

g2 = sort_personal(g1, 2);

%% huffman encoder
prob = g2(:,2);

% [M,N] = size(prob);
% prob_cell = num2cell(prob);
% a = symbol_huff(g2);

% end
comp = huffmandict(G (1,:),G (2,:));
l = cell(numel(comp)/2,1);
for  i= 1:1:numel(comp)/2
    l{i} = comp{i};
end
B = A';
C = B(:);
comp1 = huffmanenco(C,comp);

im = rgb2gray(imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/4.2.04.tiff'));
% im = imread('/Users/INNOCENTBOY/Desktop/Ritesh.png');
im = imresize(im,[512,512]);
im = double((im));

%% Stego 
Mu = 3.99;
xlog1= 20;
ylog1= 22;
zlog1= 19;
k_5 = 34;
k_6 = 40;
k_7 = 36;
[row,col]=size(im);

[xlog,ylog,zlog] = keyset(im,Mu,xlog1,ylog1,zlog1,k_5,k_6,k_7);
xlog1 = 1+floor(mod(xlog(1:row)*10^6,row));
ylog1 = 1+floor(mod(ylog(1:col)*10^6,col));

I_gr = 1:row;
I_row = confusion_impl2(I_gr,1,xlog1);
I_gr = 1:col;
I_col = confusion_impl2(I_gr,1,ylog1);
count = 1;


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


for i = 1:1:row
    
  for j = 1:1:col
        temp = im_1(I_row(i),I_col(j));    
        im_1(I_row(i),I_col(j)) = pix_mod(temp,comp1(count,1));
      
    count = count+1;
    if(count>numel(comp1))
        break; 
    end
  end
     if(count>numel(comp1))
        break;
        
    end 
end

im_10 = im_8*128 + im_7*64 +im_6*32+im_5*16+im_4*8+im_3*4+im_2*2+im_1*1;


psnr = PSNR_CAL(im,((im_10)));
figure();
subplot(1,2,1), imshow(mat2gray(im));
subplot(1,2,2), imshow(mat2gray(im_10));

dhsig = huffmandeco(comp1,comp);
dhsig=dhsig';
dhsig=char(dhsig);
% im_11= uint8(im_10);
