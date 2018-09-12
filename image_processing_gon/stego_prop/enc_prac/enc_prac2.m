% function y = enc_prac(im)clc
clc
clear
im = double((imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/4.2.04.tiff')));
R = im(:,:,1);
G = im(:,:,2);
B = im(:,:,3);
% im = mat_rev_diffussion4(im);
[row,col,dim]=size(R);
tic
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

xlog1 = 1+floor(mod(xlog(1:numel(R))*10^6,row));
ylog1 = 1+floor(mod(ylog(1:numel(R))*10^6,col));
zlog1 = 1+floor(mod(zlog(1:256)*10^6,256));
%% enc

m1 = floor(mean2(R));
R1 = bitxor(R,m1);
R1 = enc_Common(R1,xlog1,ylog1,zlog1);
m2 = floor(mean2(G));
G1 = bitxor(G,m2);
G1 = enc_Common(G1,xlog1,ylog1,zlog1);
m3 = floor(mean2(B));
B1 = bitxor(B,m3);
B1 = enc_Common(B1,xlog1,ylog1,zlog1);
toc
R_enc = cat(3,R1,G1,B1);

%% dec
tic
R1 = dec_Common(R1,xlog1,ylog1,zlog1);
R1 = bitxor(R1,m1);
G1 = dec_Common(G1,xlog1,ylog1,zlog1);
G1 = bitxor(G1,m2);
B1 = dec_Common(B1,xlog1,ylog1,zlog1);
B1 = bitxor(B1,m3);
toc
R_Dec = cat(3,R1,G1,B1);
clearvars -except im R_Dec R_enc
fontSize = 20;
[rmn,rpq] =corelation (im,R_enc);
psnr = PSNR_CAL(im,R_enc);
psnr1 = PSNR_CAL(im,R_Dec);

entopy_val = entropy(uint8(R_enc));

figure;
subplot(3,2,1),imshow(mat2gray(im)),title('Orignal image');
[r,g,b] = three_3d_im(im);
subplot(3,2,2),scatter3(r, g, b, 3),title('Histogram Orignal');
xlabel('R', 'FontSize', fontSize);
ylabel('G', 'FontSize', fontSize);
zlabel('B', 'FontSize', fontSize);

subplot(3,2,3),imshow(mat2gray(R_enc)),title('Encrypted image');
[r1,g1,b1] = three_3d_im(R_enc);
subplot(3,2,4),scatter3(r1,g1,b1,3),title('Histogram Encrypted');
xlabel('R', 'FontSize', fontSize);
ylabel('G', 'FontSize', fontSize);
zlabel('B', 'FontSize', fontSize);

subplot(3,2,5),imshow(mat2gray(R_Dec)),title('Decrypted image');
[r1,g1,b1] = three_3d_im(R_Dec);
subplot(3,2,6),scatter3(r1,g1,b1,3),title('Histogram Decrypted');
xlabel('R', 'FontSize', fontSize);
ylabel('G', 'FontSize', fontSize);
zlabel('B', 'FontSize', fontSize);



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