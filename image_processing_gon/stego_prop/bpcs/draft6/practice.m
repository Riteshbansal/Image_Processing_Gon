clc
clear
comp = [0,1,1,0,0,0,0,0;0,0,0,0,0,0,0,1;0,0,0,1,1,0,0,1;1,0,0,1,0,0,0,0;1,0,0,0,1,0,0,1;0,0,1,0,0,0,0,0;0,1,1,0,0,0,0,1;1,0,0,1,1,0,0,1];

% comp1 = 1:64;
% comp = ones(8,8);
% comp(5,5) = 1;

a = ones(8,8);
a(5,:) = 0;
a(6,:) = 0;
a(7,:) = 0;
a(8,:) = 0;
xsini(1,1)=0.4;
for i = 2:1:(numel(a))+2
    xsini(1,i) = mod(sin(pi * xsini(1,i-1)),1);
end
xsin = 1+floor(mod(xsini(3:end)*10^10,numel(a)));
ss = confusion_impl2((1:64)',xsin,1);
comp1 = confusion_impl2(a(:),ss,1);
a = reshape(comp1,[8,8]);
a(1,1)=0;
[complex1,E] = complexity(a);
% % % 
% % % Mu = 3.99;
% % % xlog1= 20.1;
% % % ylog1= 22;
% % % zlog1= 19;
% % % k_5 = 34;
% % % k_6 = 40;
% % % k_7 = 36;
% % % for k=2:8+2
% % %     xlog1(1,k)=mod(Mu*k_5*ylog1(1,k-1)*(1-xlog1(1,k-1)+zlog1(1,k-1)),1);
% % %     ylog1(1,k)=mod(Mu*k_6*ylog1(1,k-1)+zlog1(1,k-1)*1/(1+(xlog1(1,k-1)^2)),1);
% % %     zlog1(1,k)=mod(Mu*(xlog1(1,k-1)+ylog1(1,k-1)+k_7)*sin(zlog1(1,k-1)),1);
% % % end
% % % 
% % % xlog = xlog1(1,3:end);
% % % ylog = ylog1(1,3:end);
% % % zlog = zlog1(1,3:end);
% % % xlog1 = 1+floor(mod(xlog(1:8)*10^6,8));
% % % ylog1 = 1+floor(mod(ylog(1:8)*10^6,8));
% % % zlog1 = 1+floor(mod(zlog(1:8)*10^6,8));
% % % 
% % % I_gr = 1:8;
% % % I_row = confusion_impl2(I_gr,1,xlog1);
% % % I_col = confusion_impl2(I_gr,1,ylog1);
% % % I_col2 = confusion_impl2(I_gr,1,zlog1);
% % % 
n=8;
val1 = mod(bsxfun(@plus,1:n,(1:n)'),2);

% m = bitxor(a,comp);



[complex2,E2] = complexity(bitxor(a,comp));


% y = reshape(comp1, [8,8])';













% % comp2 = zeros(1,64);
% % comp2(2:40) = comp1(1:39);
% % add_val = de2bi(numel(comp1),24,'left-msb');
% % comp2(41:64) = add_val(:,:);
% % mat1 = comp1(40:end);
% % rem = mod(numel(mat1),63);
% % mat2 = mat1(end-rem+1:end);
% % mat3 = mat1(1:(numel(mat1)-rem));
% % msg_block = numel(mat3)/63;
% % msg = zeros(msg_block+2,64);
% % msg(1,1:64) = comp2(:,:);
% % for i = 0:1:msg_block-1
% %     val1 = mat3((i*63)+1:(i*63)+63);
% %     msg(i+2,2:64) = val1(:,:);
% % end
% % add_val = [0,mat2, zeros(1,64-numel(mat2)-1-8),de2bi(64-numel(mat2)-1-8,8,'left-msb')];
% % msg(msg_block+2,1:64) = add_val(:,:);
% % msg = msg';
% % co = msg(:)';
% % mat = reshape(co,[64,numel(co)/64])';
% % 
% % v1 = mat(1,2:40);
% % v2 = [];
% % for i = 1:1:(numel(co)/64)-2
% % v2 = [v2, mat(i+1,2:64)];
% % end
% % el = mat(numel(co)/64,2:64);
% % ze = el(1,63-7:63);
% % ze = 63-bi2de(ze,'left-msb')-8;
% % v3 = el(1,1:ze);
% % co = [v1,v2,v3];
% % 
% % 









% 
% num = comp2(end-23:end);
% num = bi2de(num,'left-msb');
% totalval = 1+39+24; 
% mat1 = num-39;
% rem = mod(mat1,63);
% mat2 = rem;
% mat3 = mat1-mat2;
% msg_block = (mat3)/63;
% msg = (msg_block+2)*64;
% 











% % if(numel(comp1)<=64)
% %     if(numel(comp1)==64)
% %         comp2 = comp1;
% %     else
% %         rem = 64-8-numel(comp1);
% %         add_val = [ zeros(1,rem),de2bi(numel(comp1),8,'left-msb')];
% %         comp2 = [comp1, add_val];
% %     end
% % else
% %     comp2 = zeros(1,numel(comp1)+24);
% %     comp2(1:40) = comp1(1:40);
% %     add_val = de2bi(numel(comp1),24,'left-msb');
% %     comp2(41:64) = add_val(:,:);
% %     comp2(65:end) = comp1(41:end);
% %     comp1 =  comp2(:,:);
% %     rem = mod(numel(comp1),64);
% %     add_val = [ zeros(1,64-rem-8),de2bi(64-rem-8,8,'left-msb')];
% %     mat1 = [comp1(end-rem+1:end), add_val];
% %     comp3 = comp1(1:(numel(comp1)-rem));
% %     comp2 = [comp3,mat1];
% % end