function val = conf_n(comp3)
mat1 = comp3(1:64);
comp2 =comp3(65:end); 
xsini(1,1)=0.1;
for i = 2:1:(numel(comp2))+2
    xsini(1,i) = mod(sin(pi * xsini(1,i-1)),1);
end
no_block = numel(comp3)/64;
val = zeros(8,8,no_block);
val(:,:,1) = reshape(mat1(1:64),[8,8]);
xsin = 1+floor(mod(xsini(3:end)*10^10,numel(comp2)));
comp2 = confusion_impl2(comp2,1,xsin);
no_block = numel(comp2)/64;
count =1;
for i = 0:1:no_block-1
    val1 = reshape(comp2((i*64)+1:(i*64)+64),[8,8]);
    val(:,:,count+1) = val1(:,:);
    count = count+1;
end
end