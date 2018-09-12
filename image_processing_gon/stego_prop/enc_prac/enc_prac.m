% function y = enc_prac(im)clc
clc
clear
im = double((imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/4.2.04.tiff')));
R = im(:,:,1);
G = im(:,:,2);
B = im(:,:,3);

% im = mat_rev_diffussion4(im);
[row,col,dim]=size(R);

Mu = 3.99;
xlog1= 20.1;
ylog1= 22;
zlog1= 19;
k_5 = 34;
k_6 = 40;
k_7 = 36;
pix = 0.1;

N = numel(R);
for k=2:N+2
    xlog1(1,k)=mod(Mu*k_5*ylog1(1,k-1)*(1-xlog1(1,k-1)+zlog1(1,k-1)),1);
    ylog1(1,k)=mod(Mu*k_6*ylog1(1,k-1)+zlog1(1,k-1)*1/(1+(xlog1(1,k-1)^2)),1);
    zlog1(1,k)=mod(Mu*(xlog1(1,k-1)+ylog1(1,k-1)+k_7)*sin(zlog1(1,k-1)),1);
end

xlog = xlog1(1,3:end);
ylog = ylog1(1,3:end);
zlog = zlog1(1,3:end);

xlog1 = floor(mod(xlog(1:numel(R))*10^6,256));
ylog1 = floor(mod(ylog(1:numel(R))*10^6,256));
zlog1 = floor(mod(zlog(1:numel(R))*10^6,256));

tic
[dict] = huff_enc3(im,pix);
dict = dict+1;
m = mat_diff4_n(R,dict,xlog1);
m2 = mat_diff4_n(G,dict,ylog1);
m3 = mat_diff4_n(B,dict,zlog1);
% 
m = cat(3,m,m2,m3);

toc
% m_dec = mat_rev_diff4_n(m,dict,xlog1);

[rmn,rpq] =corelation (im,m);
psnr = PSNR_CAL(m,im);

% % % rem = mod(numel(comp1),8);
% % % add_val = [ zeros(1,8-rem),de2bi(8-rem,8,'left-msb')];
% % % comp2 = [comp1;add_val'];
% % % rem2 = (numel(im)*8)-numel(comp2)-64; 
% % % add_val = [ zeros(1,rem2),de2bi(rem2,64,'left-msb')];
% % % comp3 = [comp2;add_val'];
% % % xsini(1,1)=0.1;
% % % for i = 2:1:(numel(comp1))+2
% % %     xsini(1,i) = mod(sin(pi * xsini(1,i-1)),1);
% % % end
% % % xsin = 1+floor(mod(xsini(3:end)*10^10,numel(comp1)));
% % % comp1 = confusion_impl2(comp1,xsin,1);
% % y = reshape(comp1,[8,numel(comp1)/8]);
% % y = bi2de(y','left-msb');
% % y = reshape(y,[512,512])';
% % % y = mat_rev_diffussion4(y);
% % toc
% % [rmn,rpq] =corelation (im,y);

% end