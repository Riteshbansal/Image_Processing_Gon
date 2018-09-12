clc
clear all

x = 1:512*512;
x = reshape(x,512,512)';
x = mod(x,255);
% [ Image_change2 ] = vignere( x );
% [ Image_change_dec ] = vignere_rev( Image_change2 );

[xsin,xlog] = chaotic_map(0.6,x);
xsin = 1+floor(mod(xsin(3:end)*10^6,255));
xlog = 1+floor(mod(xlog(3:end)*10^6,255));
% 
% 
m1 = mat_diffussion3(x,xsin,xlog);
x(1,1) = 0;
m2 = mat_diffussion3(x,xsin,xlog);

m3 = mat_rev_diffussion3(m1,xsin,xlog);
m4 = mat_rev_diffussion3(m2,xsin,xlog);
% 
% xsin = reshape(xsin,size(x,1),size(x,2))';
% xlog = reshape(xlog,size(x,1),size(x,2))';
% 
% m3 = mat_diffussion2(x,xsin,xlog);
% m4 = mat_rev_diffussion2(m3,xsin,xlog);
