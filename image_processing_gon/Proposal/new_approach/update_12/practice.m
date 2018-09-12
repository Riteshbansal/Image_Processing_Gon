clc
clear all

x = 1:9;
x = reshape(x,3,3)';
[xsin,xlog] = chaotic_map(0.6,x);
xsin = 1+floor(mod(xsin(3:end)*10^6,255));
xlog = 1+floor(mod(xlog(3:end)*10^6,255));


m1 = mat_diffussion3(x,xsin,xlog);
m2 = mat_rev_diffussion3(m1,xsin,xlog);

xsin = reshape(xsin,size(x,1),size(x,2))';
xlog = reshape(xlog,size(x,1),size(x,2))';

m3 = mat_diffussion2(x,xsin,xlog);
m4 = mat_rev_diffussion2(m3,xsin,xlog);
