function I_out = confusion_impl_rev2(I_gr,pix)

% size_image = size(I_gr);

%decryption
size_image = size(I_gr);


xsin(1,1)=pix;
for i = 2:1:size_image(1)+2
    xsin(1,i) = mod(sin(pi * xsin(1,i-1)),1);
end
 xlog(1,1) = pix;

for k=2: size_image(2)+2
    Alog=4; % Parameter of map
    xlog(1,k)=mod(Alog*xlog(1,k-1)*(1-xlog(1,k-1)),1);
end
xsin = 1+floor(mod(xsin(3:end)*10^6,size_image(1)));
xlog = 1+floor(mod(xlog(3:end)*10^6,size_image(2)));


I_out(:,:) = I_gr(:,:);

for i = size_image(1):-1:1
   for j = size_image(2):-1: 1
        temp = I_out(i,j);
        I_out(i,j) = I_out(xsin(i),xlog(j));
        I_out(xsin(i),xlog(j)) = temp;
   end
end



end
