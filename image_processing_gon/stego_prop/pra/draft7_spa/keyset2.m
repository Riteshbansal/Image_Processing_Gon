function [xlog1,ylog1,zlog] = keyset2(im,xlog2,ylog2,zlog2,k_5,k_6,k_7)
Mu = 3.99;

[row,col,dim]=size(im);
p = row;
xlog1= [xlog2];
ylog1= [ylog2];
zlog1= [zlog2];

N = numel(im);
for k=2:N+2
    xlog1(1,k)=mod(Mu*k_5*ylog1(1,k-1)*(1-xlog1(1,k-1)+zlog1(1,k-1)),1);
    ylog1(1,k)=mod(Mu*k_6*ylog1(1,k-1)+zlog1(1,k-1)*1/(1+(xlog1(1,k-1)^2)),1);
    zlog1(1,k)=mod(Mu*(xlog1(1,k-1)+ylog1(1,k-1)+k_7)*sin(zlog1(1,k-1)),1);
end

xlog = xlog1(1,3:end);
ylog = ylog1(1,3:end);
zlog = zlog1(1,3:end);

xlog1 = (mod(floor(xlog*10^10),2));
ylog1 = (mod(floor(ylog*10^10),2));

end