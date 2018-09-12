function d = pix_mod_rev(pix)
% clc
% clear;
% pix = 440;
% d =1;

pix = abs(pix);
pix=floor(pix+0.0002);
pix = de2bi(pix,'left-msb');

d = pix(numel(pix));

end