function [xlog1,ylog1,zlog] = keyset(im)
Mu = 3.99;
xlog1= 20.1;
ylog1= 22;
zlog1= 19;
k_5 = 34;
k_6 = 40;
k_7 = 36;

[row,col,dim]=size(im);
p = row;

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