function m = noise_matrix(val, M,pix_mat)
[R,C] = size(M);

Mu=3.999; % Parameter of map
xlog= 20+val;
ylog= 22+val;
zlog= 19+val;
k_5 = 34+val;
k_6 = 40+val;
k_7 = 36+val;
for k=2:numel(M)   
    xlog(1,k)=mod(Mu*k_5*ylog(1,k-1)*(1-xlog(1,k-1)+zlog(1,k-1)),1);
    ylog(1,k)=mod(Mu*k_6*ylog(1,k-1)+zlog(1,k-1)*1/(1+(xlog(1,k-1)^2)),1);
    zlog(1,k)=mod(Mu*(xlog(1,k-1)+ylog(1,k-1)+k_7)*sin(zlog(1,k-1)),1); 
end
xlog = mod(xlog+ylog-zlog,1);
m = reshape(xlog,R,C)';

m(pix_mat(1),pix_mat(2)) = 0;
end