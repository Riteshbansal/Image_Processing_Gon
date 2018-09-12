function pix_out = pix_mod(pix, d)
% clc
% clear;
% pix = 440;
% d =1;
sign =1;
sign(pix<0) = -1;
pix = abs(pix);
kk = pix-floor(pix+0.00001);
pix=floor(pix+0.00001);
pix = de2bi(pix,'left-msb');

pix(numel(pix)) = d;

pix_out = bi2de(pix,'left-msb');
pix_out = pix_out+kk;
pix_out = pix_out*sign;
end