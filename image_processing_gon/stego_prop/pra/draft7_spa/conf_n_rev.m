function mat = conf_n_rev(co)
[m1,n1,z1] = size(co);
orig = co(:,:,1);
orig = orig(:)';
mat = [];

for i = 1:1:z1-1
    val1 = co(:,:,i+1);
    val = val1(:)';
    mat = [mat,val];
end
% xsini(1,1)=0.1;
% for i = 2:1:(numel(mat))+2
%     xsini(1,i) = mod(sin(pi * xsini(1,i-1)),1);
% end
% xsin = 1+floor(mod(xsini(3:end)*10^10,numel(mat)));
% mat = confusion_impl_rev2(mat,1,xsin);
mat = [orig,mat];
end