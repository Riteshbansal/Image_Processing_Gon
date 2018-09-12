clc
clear



x = [1;1;0;0;1;0;1;0;0;0;0;0;0;0;1;0];

y = reshape(x,[8,numel(x)/8]);
pix_out = bi2de(y','left-msb');

