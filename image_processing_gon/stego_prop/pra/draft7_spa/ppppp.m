clc
clear 
imo = double(imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/4.1.01.tiff'));

im1(:,:,:) = imo(:,:,:);
im = im1(:,:,3);
im2(:,:,:) = im1(:,:,:);
% data = 'ABCDEFABCDEFABCD';
% data = 'ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ';
fid=fopen('textprojectfile1.txt','r');
data=fread(fid);
A = double(int16(data'));
encr = (double(A));

[comp1, comp, prob1] = huff_enc(encr);
tic


% toc
siz_app= size(imo);
siz_app = (siz_app(1)*siz_app(2)*3)*8*(1/2);
if(numel(comp1)>=(siz_app))
    siz_enc = comp1(1:siz_app);
    siz_con = comp1(siz_app+1:end);
    comp1 = zeros(size(siz_enc));
    comp1(:,:) = siz_enc(:,:);
else
    siz_con=[];
end
Mu = 3.99;
xlog1= 20.1;
ylog1= 22;
zlog1= 19;
k_5 = 34;
k_6 = 40;
k_7 = 36;
[xlog1,ylog1,zlog1] = keyset2(comp1,xlog1,ylog1,zlog1,k_5,k_6,k_7);
comp2 = mat_diffussion4(comp1,xlog1,ylog1);
xsin = 1+floor(mod(zlog1*10^10,numel(comp2)));
comp2 = confusion_impl2(comp2,xsin,1);
comp2= comp2';


xlog1= 20.1;
ylog1= 22;
zlog1= 19;
k_5 = 34;
k_6 = 40;
k_7 = 36.1;
[xlog1,ylog1,zlog1] = keyset2(comp1,xlog1,ylog1,zlog1,k_5,k_6,k_7);
comp3 = mat_diffussion4(comp1,xlog1,ylog1);
xsin = 1+floor(mod(zlog1*10^10,numel(comp3)));
comp3 = confusion_impl2(comp3,xsin,1);
comp3= comp3';
num_of_pix = numel( comp2 );
k = sum( double( comp2(:) ~= comp3(:) ) )
k1 = sum( double( comp2(:) ~= comp3(:) ) )/num_of_pix
correl = corr2(comp2(:),comp3(:))

