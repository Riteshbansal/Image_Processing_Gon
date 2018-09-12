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
% im = 1:(32*32);
% im = reshape(im,32,32)';
% [r,c]=size(im);
% meshgrid_show(img)
siz = 255;
im1 = mat_diffussion3(im,xlog,ylog,siz);
im2 = mat_rev_diffussion3(im1,xlog,ylog,siz);




mea = 1;
enc = (im./mea);
meshgrid_show(enc);
% no = ceil(16/mea);
no=16;
per = xlog(1);
[LL ,LH, HL, HH] = dwt2(enc,'haar');
% meshgrid_show(LL);
% meshgrid_show(LH);
% meshgrid_show(HL);
% meshgrid_show(HH);

% kk1 = (LL./no)-floor(LL./no+0.000000000002); 
% LL = floor(LL./no+0.000000000002);
% meshgrid_show(LL);

LL = confusion_impl2(LL./no,per);
% meshgrid_show(LL);
HH = confusion_impl2(HH./no,per);
% meshgrid_show(LH);
HL = confusion_impl2(HL./no,per);
% meshgrid_show(HL);
LH = confusion_impl2(LH./no,per);
% meshgrid_show(HH);



% HH = (HH./no);
% % meshgrid_show(HH);
% HL = (HL./no);
% % meshgrid_show(HL);
% LH = (LH./no);
% % meshgrid_show(LH);
% LL = LL+(kk1);
% meshgrid_show(LL);

% x1 = HL+LH;
% x2 = LH-HL;
% enc = idwt2(im1,x1./2,x2,HH,'haar');
enc = idwt2(LL,HL,LH,HH,'haar');
meshgrid_show(enc);

max_val = max(max(enc));
min_val = min(min(enc));




%% Results

% %  new_mat(new_mat<-127) = -127;
% % new_mat(new_mat>127) = 127;

% enc_image = ((new_mat));
% enc_image1 = floor(normalized_his(ceil(enc_image)));
% [x,y] = corelation((im),floor(abs((new_mat))));
% PSNR = sum(sum((((new_mat_dec)-im).*((new_mat_dec)-im))));
% PSNR = PSNR/(r*c);
% PSNR = 20 * log10(255/ sqrt(PSNR));
% 
% PSNR1 = sum(sum((((new_mat)-im).*((new_mat)-im))));
% PSNR1 = PSNR1/(r*c);
% PSNR1 = 20 * log10(255/ sqrt(PSNR1));
% 
% new_mat_dec =floor(new_mat_dec);
% x1 =im - new_mat_dec;
% entropy_i_enc = entropy(uint8(enc_image));
% entropy_i_enc1 = entropy(uint8(enc_image1));
