% % clc
% % clear
clc
clear
% a = [1,1,1,0,0,0,0,1;0,0,1,1,1,1,1,0;0,0,1,0,0,0,0,0;1,0,0,0,1,0,0,0;1,0,1,1,0,0,0,1;0,1,0,0,1,1,0,1;0,0,1,1,0,0,0,1;1,1,1,0,1,1,1,1];
%  n=8;
% a = mod(bsxfun(@plus,1:n,(1:n)'),2);
% % a = ones(8,8);
% % a(:,6) = 0;
% % a(6,:) = 0;
% % a(6,6) = 1;
% % 
% % 
% % [comp,E] = complexity(a)
% a1 = [1 0 1 0 1 0 0 1 1 1 1 0 1 0 1 1 0 0 0 0 1 0 1 0 0 0 0 1 0 1 0 0 1 0 1 1 1 0 0 1 1 0 0 1 1 1 0 1 1 0 0 1 1 0 1 1 0 1 1 0 1 1 1 1 0 0 0 0 1 0 0 0 1 0 0 0 1 1 0 0 0 0 0 0 0 1 1 0 1 1 0 1 1 0 1 0 1 0 0 1 1 0 0 1 0 1 0 1 0 0 1 1 1 0 1 1 1 0 1 0 0 1 0 0 0 0 1 0];
a1 = [0,1,1,1,0,0,1,1,1,0,0,0,1,1,0,0,0,1,1,0,1,0,1,1,1,0,1,0,1,0,0,1,1,1,1,1,1,1,0,1,0,0,1,0,1,1,1,1,1,0,0,1,1,0,1,1,0,1,0,1,0,0,1,1,1,0,1,0,1,0,1,0,0,1,0,0,1,1,1,0,1,0,1,1,0,1,1,1,1,1,0,0,0,0,1,0,0,1,1,1,0,0,0,0,1,0,1,1,0,1,0,0,0,0,0,1,0,0,1,1,0,1,1,0,1,1,1,0,0,1,1,1,1,0,0,1,1,1,1,1,1,0,1,1,0,1,0,0,1,1,0,0,1,1,1,0,0,1,1,1,0,1,1,0,1,0,1,0,0,1,0,0,1,1,0,1,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,1,0,0,0,1,0,0,0,0,1,0,0,1,1,0,0,1,0,0,1,0,0,1,1,1,1,1,1,1,0,1,1,0,0,1,1,1,1,1,1,1,0,0,0,0,1,0,0,0,1,0,1,1,0,0,0,1,1,0,0]; 
b1 = [1,1,1,0,1,0,1,1,1,0,0,1,1,0,1,1,1,0,0,1,1,0,1,0,0,1,1,1,0,0,1,0,1,1,0,0,0,0,0,0,0,1,0,1,1,1,1,0,0,0,1,1,1,0,0,0,0,1,0,1,0,0,0,0,1,1,0,0,0,1,1,0,1,1,0,1,1,0,0,0,0,1,0,0,1,1,1,0,1,1,0,0,1,0,1,0,0,0,0,1,0,1,0,0,0,0,1,1,0,1,1,1,1,1,1,1,0,1,1,1,1,1,0,0,1,1,1,1,0,0,0,1,1,0,0,1,0,0,0,0,0,0,1,1,0,0,0,0,1,1,1,1,0,1,1,0,1,0,0,1,1,0,0,1,0,0,1,0,0,0,1,0,0,0,0,0,1,1,1,0,0,1,1,0,0,0,1,1,1,1,0,1,0,1,0,1,0,1,1,0,0,0,1,1,0,1,1,1,1,0,1,1,0,1,1,0,1,1,1,0,0,0,0,0,1,0,1,0,1,0,1,0,0,0,1,0,0,1,0,0,1,0,0,0,0,0,0,1,0,0,0,1];
k = sum( double( a1(:) ~= b1(:) ) ); 
% a2= reshape(a1',[7,6]);
% b2= reshape(b1',[7,6]);
% a3= bi2de(a2)';
% b3= bi2de(b2)';
correl = corr2(a1(:),b1(:))
% b2 = [0 0 1 1 0 0 1 0 1 0 1 0 0 1 0 0 0 0 1 1 1 1 0 0 0 1 0 0 1 0 0 0 0 1 1 1 1 0 1 1 0 0 1 0 1 0 0 0 1 1 1 0 0 0 1 0 1 0 0 1 1 1 1 1 0 0 0 0 1 0 1 0 0 1 0 0 0 0 0 1 0 1 1 1 1 0 1 0 1 1 0 1 0 1 0 1 1 1 1 1 0 0 0 1 1 1 0 1 1 1 1 0 1 0 0 0 0 0 1 0 1 1 1 1 1 1 1 0];
% b1=  [0,0,1,0,1,1,1,0,0,0,0,1,0,0,0,0,1,1,1,0,0,0,1,1,1,0,0,1,1,1,1,1,1,0,1,0,0,0,0,1,0,1,0,0,0,0,0,0,0];
% b2 = [0,0,1,0,1,1,1,0,0,0,0,1,0,0,0,0,1,1,1,0,0,0,1,1,1,0,0,1,1,1,1,1,1,0,1,0,0,0,0,1,0,1,0,1,0,0,0,0,0];
% d = bsxfun(@eq,a2,b2);
% d= sum(double(d));
% a1= reshape(a1',[7,13]);
% b1= reshape(b1',[7,13]);
% a1= bi2de(a1)';
% b1= bi2de(b1)';
% a1 = char(a1);
% b1 = char(b1);
% 



% % desiredOutputRows = 800; % Whatever.....
% % stripeImage = imresize(a, [desiredOutputRows, desiredOutputColumns], 'nearest');
% % imshow(stripeImage, [])
% % grid on
% % set(gca,'LineWidth',2)
% % set(gca,'LineWidth',5)
% % set(gca,'LineWidth',10)

% % comp2 = zeros(8,8);
% % n=8;
% % comp2 = mod(bsxfun(@plus,1:n,(1:n)'),2);
% % 
% % Mu=3.999; % Parameter of map
% % xlog1= 20;
% % ylog1= 22;
% % zlog1= 19;
% % k_5 = 34;
% % k_6 = 40;
% % k_7 = 36;
% % N = 64;
% % for k=2:N+2
% %     xlog1(1,k)=mod(Mu*k_5*ylog1(1,k-1)*(1-xlog1(1,k-1)+zlog1(1,k-1)),1);
% %     ylog1(1,k)=mod(Mu*k_6*ylog1(1,k-1)+zlog1(1,k-1)*1/(1+(xlog1(1,k-1)^2)),1);
% %     zlog1(1,k)=mod(Mu*(xlog1(1,k-1)+ylog1(1,k-1)+k_7)*sin(zlog1(1,k-1)),1);
% % end
% % xlog = xlog1(1,3:end);
% % ylog = ylog1(1,3:end);
% % zlog = zlog1(1,3:end);
% % 
% % xlog1 = mod(floor(xlog*10^10),2);
% % ylog1 = mod(floor(ylog*10^10),2);
% % zlog1 = mod(floor(zlog*10^10),2);
% % rand_mat =bitxor( xlog1,bitxor(ylog1,zlog1));
% % rand_mat = reshape(rand_mat,[8,8]);
% % 
% % a = ones(8,8);
% % a(:,2) = 0;
% % a(:,4) = 0;
% % a(:,6) = 0;
% % a(:,8) = 0;
% % 
% % v = bitxor(a,rand_mat);
% % 
% % xsini(1,1)=0.4;
% % for i = 2:1:66
% %     xsini(1,i) = mod(sin(pi * xsini(1,i-1)),1);
% % end
% % xsin = 1+floor(mod(xsini(3:end)*10^10,64));
% % ss = confusion_impl2((1:64)',xsin,1);
% % a2 = mod(ss,2);
% % comp1 = confusion_impl2(a2,ss,1);
% % val1 = reshape(comp1,[8,8]);
% % v = bitxor(v,val1);
% % 
% % co = bitxor(comp2,v);
% % 
% % 
% % [k1,k2] = complexity(co);
% % 
% % 
% % 
