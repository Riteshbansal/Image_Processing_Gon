function m = conj_n(comp2)

n=8;
val1 = mod(bsxfun(@plus,1:n,(1:n)'),2);
m = bitxor(val1,comp2);

% a = ones(8,8);
% a(5,:) = 0;
% a(6,:) = 0;
% a(7,:) = 0;
% a(8,:) = 0;
% xsini(1,1)=0.4;
% for i = 2:1:(numel(a))+2
%     xsini(1,i) = mod(sin(pi * xsini(1,i-1)),1);
% end
% xsin = 1+floor(mod(xsini(3:end)*10^10,numel(a)));
% ss = confusion_impl2((1:64)',xsin,1);
% comp1 = confusion_impl2(a(:),ss,1);
% val1 = reshape(comp1,[8,8]);
% val1(1,1)=0;

% m = bitxor(val1,comp2);


end