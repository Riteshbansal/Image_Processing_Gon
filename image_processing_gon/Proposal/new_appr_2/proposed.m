clc
close all
clear

% im = (rgb2gray(imread('/Users/INNOCENTBOY/Downloads/videos/Imageprocessing/week6/original_cameraman.jpg')));
% src = '/Users/INNOCENTBOY/Documents/MATLAB/4.2.04.tiff' ;
src = '/Users/INNOCENTBOY/Documents/MATLAB/pic/4.2.03.tiff';
% src = '/Users/INNOCENTBOY/Documents/MATLAB/pic/4.2.04.tiff';

im = double((imread(src)));
mea = 1;
Mu=3.999; % Parameter of map
xlog1= 20;
ylog1= 22;
zlog1= 19;
k_5 = 34;
k_6 = 40;
k_7 = 36;
[row,col,dim]=size(im);
p = row;
chaotic = keyset(im,mea,Mu,xlog1,ylog1,zlog1,k_5,k_6,k_7);
xlog1= 20;
ylog1= 22;
zlog1= 19;
k_5 = 34;
k_6 = 40;
k_7 = 36.0000000001;
chaotic1 = keyset(im,mea,Mu,xlog1,ylog1,zlog1,k_5,k_6,k_7);

% N = numel(im)/3;
% for k=2:N+2
%     xlog1(1,k)=mod(Mu*k_5*ylog1(1,k-1)*(1-xlog1(1,k-1)+zlog1(1,k-1)),1);
%     ylog1(1,k)=mod(Mu*k_6*ylog1(1,k-1)+zlog1(1,k-1)*1/(1+(xlog1(1,k-1)^2)),1);
%     zlog1(1,k)=mod(Mu*(xlog1(1,k-1)+ylog1(1,k-1)+k_7)*sin(zlog1(1,k-1)),1);
% end
% 
% xlog = xlog1(1,3:end);
% ylog = ylog1(1,3:end);
% zlog = zlog1(1,3:end);
% 
% pix = xlog(1,1);
% % pix = 44;
% 
% xsini(1,1)=pix;
% for i = 2:1:(row)+2
%     xsini(1,i) = mod(sin(pi * xsini(1,i-1)),1);
% end
%  xlogarithi(1,1) = pix;
% 
% for k=2: (col)+2
%     Alog=4; % Parameter of map
%     xlogarithi(1,k)=mod(Alog*xlogarithi(1,k-1)*(1-xlogarithi(1,k-1)),1);
% end
% xsin = 1+floor(mod(xsini(3:end)*10^6,(row/2)));
% xlogarith = 1+floor(mod(xlogarithi(3:end)*10^6,(col/2)));
% % xlogarith = 1+floor(mod(zlog(1:(col))*10^6,(col/2)));
% 
% 
% xsin_2 = [1];
% xlogarith_2 = 1+floor(mod(xlogarithi(3:end)*10^6,(256)));
% 
% % % xy = 1:row;
% % % yx = 1:col;
% 
% xlog_per_main = 1+floor(mod(xlog(1:row)*10^6,row));
% ylog_per_main = 1+floor(mod(ylog(1:col)*10^6,col));
% 
% % % xlog_per_main = confusion_impl2(xy,1,xlog_per_main);
% % % ylog_per_main = confusion_impl2(yx,1,ylog_per_main);
% % % 
% 
% [xsin1,xlog1_ex] = chaotic_map(xlog(1),row);
% xsin2 = 1+floor(mod(xsin1(3:end)*10^6,255));
% xlog1 = 1+floor(mod(xlog1_ex(3:end)*10^6,255));
% 
% xsin1 = reshape(xsin2,size(im,1),size(im,2))';
% xlog1 = reshape(xlog1,size(im,1),size(im,2))';
% % xlog = 1+floor(mod(xlog*10^6,255));
% 
% chaotic = {xlog,ylog,zlog,mea,xsin,xlogarith,xsin_2,xlogarith_2, ...
%                         xlog_per_main,ylog_per_main ,xlog1,xsin1,xlog1_ex,p};

clearvars -except xlog zlog ylog p  im mea row col dim xsin xlogarith xlog_per_main ...
                        ylog_per_main chaotic chaotic1
r = im(:,:,1);
g = im(:,:,2);
b = im(:,:,3);


%% ENC
tic
r_enc =  enc_newappr(r,chaotic);
g_enc =  enc_newappr(g,chaotic);
b_enc =  enc_newappr(b,chaotic);
toc
img_enc = cat(3,r_enc,g_enc,b_enc);
% img_enc = img_enc.*mea;



%% ENC 2
tic
% r(1,1) = 1;
% g(1,1) = 1;
% b(1,1) = 1;

r_enc_2 =  enc_newappr(r,chaotic1);
g_enc_2 =  enc_newappr(g,chaotic1);
b_enc_2 =  enc_newappr(b,chaotic1);
img_enc_2 = cat(3,r_enc_2,g_enc_2,b_enc_2);
% img_enc_2 = img_enc_2.*mea;

toc

%% DEC

r_dec =  dec_newappr(r_enc,chaotic);
g_dec =  dec_newappr(g_enc,chaotic);
b_dec =  dec_newappr(b_enc,chaotic);
img_dec = cat(3,r_dec,g_dec,b_dec);

clearvars -except img_enc im img_enc_2 img_dec row col p mea dim

%% Results

% new_mat_dec = floor(new_mat_dec);
% enc_image(:,:,1) = floor(abs(img_enc(:,:,1)));
% enc_image(:,:,2) = floor(abs(img_enc(:,:,2)));
% enc_image(:,:,3) = floor(abs(img_enc(:,:,3)));
enc_image = ((img_enc));
l1 = enc_image(:,:,1);
enc_image1(:,:,1) = (mat2gray(enc_image(:,:,1)));
l1 = enc_image(:,:,2);
enc_image1(:,:,2) = (mat2gray(enc_image(:,:,2)));
l1 = enc_image(:,:,3);
enc_image1(:,:,3) = (mat2gray(enc_image(:,:,3)));

% % count =1;
% % l=zeros(25,3);
% % while(count<25)
[x,y] = corelation((im),double(((img_enc))));
% % l(count,1) = y(1);
% % l(count,2) = y(2);
% % l(count,3) = y(3);
% % 
% % 
% % count = count+1;
% % end


x1 = im(:,:,1)-img_enc(:,:,1);
PSNR = sum(sum(sum((im-img_enc).*(im-img_enc))));
PSNR = PSNR /(row*col*dim);
PSNR = 20 * log10(255/ sqrt(PSNR));
entropy_i_enc = entropy(uint8(enc_image));
entropy_i_enc1 = entropy(im2uint8(enc_image1));

entropy_i_main = entropy(uint8(im));
res = NPCR_and_UACI((((img_enc))),(((img_enc_2))),1,255);
% zz=corr2(enc_image,im);
figure()
subplot(2,2,1),imshow(im2uint8(mat2gray(img_dec)));
subplot(2,2,3),imshow(im2uint8(mat2gray(img_enc)));
fontSize = 20;

[r,g,b] = three_3d_im(im);
subplot(2,2,2),scatter3(r, g, b, 3),title('Histogram Orignal');
xlabel('R', 'FontSize', fontSize);
ylabel('G', 'FontSize', fontSize);
zlabel('B', 'FontSize', fontSize);

% r = enc_image1(:,:,1);
% g = enc_image1(:,:,2);
% b = enc_image1(:,:,3);

[r,g,b] = three_3d_im(im2uint8(mat2gray(img_enc)));

subplot(2,2,4),scatter3(r, g, b, 3),title('Histogram enc');
xlabel('R', 'FontSize', fontSize);
ylabel('G', 'FontSize', fontSize);
zlabel('B', 'FontSize', fontSize);


im = double(uint8(im));
img_dec = double(uint8(img_dec));

PSNR1 = sum(sum(sum((im-img_dec).*(im-img_dec))));
PSNR1 = PSNR1 /(row*col*dim);
PSNR1 = 20 * log10(255/ sqrt(PSNR1));

% [k1,k2] = meshgrid(1:512,1:512);
% figure(),mesh(k1,k2,img_enc(:,:,1));
% figure(),mesh(k1,k2,im(:,:,1));