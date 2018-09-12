function I_out = confusion_impl2(I_gr,xsin,xlog)

size_image = size(I_gr);

I_out(:,:) = I_gr(:,:);

for i = 1:1:size_image(1)
   for j = 1:1: size_image(2)
        temp = I_out(i,j);
        I_out(i,j) = I_out(xsin(i),xlog(j));
        I_out(xsin(i),xlog(j)) = temp;
   end
end


end
 