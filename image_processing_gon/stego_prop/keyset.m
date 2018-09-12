function [xlog1,ylog1,zlog1] = keyset(im,Mu,xlog1,ylog1,zlog1,k_5,k_6,k_7)
[row,col,dim]=size(im);
p = row;

N = numel(im)/3;
for k=2:N+2
    xlog1(1,k)=mod(Mu*k_5*ylog1(1,k-1)*(1-xlog1(1,k-1)+zlog1(1,k-1)),1);
    ylog1(1,k)=mod(Mu*k_6*ylog1(1,k-1)+zlog1(1,k-1)*1/(1+(xlog1(1,k-1)^2)),1);
    zlog1(1,k)=mod(Mu*(xlog1(1,k-1)+ylog1(1,k-1)+k_7)*sin(zlog1(1,k-1)),1);
end

xlog = xlog1(1,3:end);
ylog = ylog1(1,3:end);
zlog = zlog1(1,3:end);

xlog1 = 1+floor(mod(xlog(1:row)*10^6,row));
ylog1 = 1+floor(mod(ylog(1:col)*10^6,col));
zlog1 = 1+floor(mod(zlog(1:col)*10^6,col));

% 
% pix = xlog(1,1);
% % pix = 44;
% 
% xsini(1,1)=pix;
% for i = 2:1:(row)+2
%     xsini(1,i) = mod(sin(pi * xsini(1,i-1)),1);
% end
%  xlogarithi(1,1) = pix;
% 
% for k=2: (col)+2
%     Alog=4; % Parameter of map
%     xlogarithi(1,k)=mod(Alog*xlogarithi(1,k-1)*(1-xlogarithi(1,k-1)),1);
% end
% xsin = 1+floor(mod(xsini(3:end)*10^6,(row/2)));
% xlogarith = 1+floor(mod(xlogarithi(3:end)*10^6,(col/2)));
% % xlogarith = 1+floor(mod(zlog(1:(col))*10^6,(col/2)));
% 
% 
% xsin_2 = [1];
% xlogarith_2 = 1+floor(mod(xlogarithi(3:end)*10^6,(256)));
% 
% % % xy = 1:row;
% % % yx = 1:col;
% 
% xlog_per_main = 1+floor(mod(xlog(1:row)*10^6,row));
% ylog_per_main = 1+floor(mod(ylog(1:col)*10^6,col));
% 
% % % xlog_per_main = confusion_impl2(xy,1,xlog_per_main);
% % % ylog_per_main = confusion_impl2(yx,1,ylog_per_main);
% % % 
% 
% [xsin1,xlog1_ex] = chaotic_map(xlog(1),row);
% xsin2 = 1+floor(mod(xsin1(3:end)*10^6,255));
% xlog1 = 1+floor(mod(xlog1_ex(3:end)*10^6,255));
% 
% xsin1 = reshape(xsin2,size(im,1),size(im,2))';
% xlog1 = reshape(xlog1,size(im,1),size(im,2))';
% % xlog = 1+floor(mod(xlog*10^6,255));
% 
% chaotic = {xlog,ylog,zlog,mea,xsin,xlogarith,xsin_2,xlogarith_2, ...
%                         xlog_per_main,ylog_per_main ,xlog1,xsin1,xlog1_ex,p};
end