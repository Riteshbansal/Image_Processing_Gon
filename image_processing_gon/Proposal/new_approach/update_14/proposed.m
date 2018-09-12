clc
clear all
close all

% im = (rgb2gray(imread('/Users/INNOCENTBOY/Downloads/videos/Imageprocessing/week6/original_cameraman.jpg')));
% src = '/Users/INNOCENTBOY/Documents/MATLAB/4.2.04.tiff' ;
src = '/Users/INNOCENTBOY/Documents/MATLAB/pic/512/4.2.04.tiff';
im = double((imread(src)));
mea = 1;
Mu=3.999; % Parameter of map
xlog1= 20;
ylog1= 22;
zlog1= 19;
k_5 = 34;
k_6 = 40;
k_7 = 36;
[row,col , dim]=size(im);
p = 512;

N = (row*col)/p^2;
if(N<row|| N<col)
    N = row;
end
for k=2:N+2
    xlog1(1,k)=mod(Mu*k_5*ylog1(1,k-1)*(1-xlog1(1,k-1)+zlog1(1,k-1)),1);
    ylog1(1,k)=mod(Mu*k_6*ylog1(1,k-1)+zlog1(1,k-1)*1/(1+(xlog1(1,k-1)^2)),1);
    zlog1(1,k)=mod(Mu*(xlog1(1,k-1)+ylog1(1,k-1)+k_7)*sin(zlog1(1,k-1)),1);
end

xlog = xlog1(1,3:end);
ylog = ylog1(1,3:end);
zlog = zlog1(1,3:end);

clearvars -except xlog zlog ylog p  im mea row col dim

r = im(:,:,1);
g = im(:,:,2);
b = im(:,:,3);


%% ENC
tic
r_enc =  enc_newappr(r,xlog,ylog,mea,p);
g_enc =  enc_newappr(g,xlog,ylog,mea,p);
b_enc =  enc_newappr(b,xlog,ylog,mea,p);
r_enc1 =  xor_operation(r_enc);
g_enc1 =  xor_operation(g_enc);
b_enc1 =  xor_operation(b_enc);

toc
% r_enc =  r_enc./2;
% g_enc =  g_enc./2;
% b_enc =  b_enc./2;
% 

img_enc = cat(3,r_enc1,g_enc1,b_enc1);



%% ENC 2
tic
r(1,1) = 0;
g(1,1) = 0;
b(1,1) = 0;


r_enc_2 =  enc_newappr(r,xlog,ylog,mea,p);
g_enc_2 =  enc_newappr(g,xlog,ylog,mea,p);
b_enc_2 =  enc_newappr(b,xlog,ylog,mea,p);

r_enc_2 =  xor_operation(r_enc_2);
g_enc_2 =  xor_operation(g_enc_2);
b_enc_2 =  xor_operation(b_enc_2);

img_enc_2 = cat(3,r_enc_2,g_enc_2,b_enc_2);
toc

%% DEC
% r_enc =  r_enc.*2;
% g_enc =  g_enc.*2;
% b_enc =  b_enc.*2;

r_enc2 =  xor_operation(r_enc1);
g_enc2 =  xor_operation(g_enc1);
b_enc2 =  xor_operation(b_enc1);


r_dec =  dec_newappr(r_enc2,xlog,ylog,mea,p);
g_dec =  dec_newappr(g_enc2,xlog,ylog,mea,p);
b_dec =  dec_newappr(b_enc2,xlog,ylog,mea,p);
img_dec = cat(3,r_dec,g_dec,b_dec);

clearvars -except img_enc im img_enc_2 img_dec row col p mea dim

%% Results

% new_mat_dec = floor(new_mat_dec);
% enc_image(:,:,1) = floor(abs(img_enc(:,:,1)));
% enc_image(:,:,2) = floor(abs(img_enc(:,:,2)));
% enc_image(:,:,3) = floor(abs(img_enc(:,:,3)));
% img_enc(img_enc>255) = 255;

enc_image = (floor(img_enc));
enc_image1(:,:,1) = floor(normalized_his(enc_image(:,:,1)));
enc_image1(:,:,2) = floor(normalized_his(enc_image(:,:,2)));
enc_image1(:,:,3) = floor(normalized_his(enc_image(:,:,3)));

[x,y] = corelation((im),(((img_enc))));
PSNR = sum(sum(sum((im-img_enc).*(im-img_enc))));
PSNR = PSNR /(row*col*dim);
PSNR = 20 * log10(255/ sqrt(PSNR));
entropy_i_enc = entropy(uint8(enc_image));
% entropy_i_enc1 = entropy(uint8(enc_image));

entropy_i_main = entropy(uint8(im));
res = NPCR_and_UACI((((img_enc))),(((img_enc_2))),1);
% zz=corr2(enc_image,im);
figure()
subplot(2,2,1),imshow(uint8(img_dec));
% subplot(2,2,2),imhist(uint8(img_enc));
fontSize = 20;

[r,g,b] = three_3d_im(im);
subplot(2,2,2),scatter3(r, g, b, 3),title('Histogram Orignal');
xlabel('R', 'FontSize', fontSize);
ylabel('G', 'FontSize', fontSize);
zlabel('B', 'FontSize', fontSize);

% r = enc_image1(:,:,1);
% g = enc_image1(:,:,2);
% b = enc_image1(:,:,3);
[r,g,b] = three_3d_im(enc_image1);

subplot(2,2,3),scatter3(r, g, b, 3),title('Histogram enc');
xlabel('R', 'FontSize', fontSize);
ylabel('G', 'FontSize', fontSize);
zlabel('B', 'FontSize', fontSize);
% % x = uint8(im)-(uint8(img_dec));
% % x1 = x(:,:,1);
% % max = max(max(max(x1)));
im = double(uint8(im));
img_dec = double(uint8(img_dec));

PSNR1 = sum(sum(sum((im-img_dec).*(im-img_dec))));
PSNR1 = PSNR1 /(row*col*dim);
PSNR1 = 20 * log10(255/ sqrt(PSNR1));