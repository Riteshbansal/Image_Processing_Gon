% function y = enc_prac(im)clc
clc
clear
im = double(rgb2gray(imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/4.2.04.tiff')));
% im = mat_rev_diffussion4(im);
tic
[comp1, comp, prob1] = huff_enc3(im);

% rem = mod(numel(comp1),8);
% add_val = [ zeros(1,8-rem),de2bi(8-rem,8,'left-msb')];
% comp2 = [comp1;add_val'];
% rem2 = (numel(im)*8)-numel(comp2)-64; 
% add_val = [ zeros(1,rem2),de2bi(rem2,64,'left-msb')];
% comp3 = [comp2;add_val'];
% xsini(1,1)=0.1;
% for i = 2:1:(numel(comp1))+2
%     xsini(1,i) = mod(sin(pi * xsini(1,i-1)),1);
% end
% xsin = 1+floor(mod(xsini(3:end)*10^10,numel(comp1)));
% comp1 = confusion_impl2(comp1,xsin,1);
y = reshape(comp1,[8,numel(comp1)/8]);
y = bi2de(y','left-msb');
y = reshape(y,[512,512])';
% y = mat_rev_diffussion4(y);
toc
[rmn,rpq] =corelation (im,y);

% end