function I_out = confusion_new_rev(I_gr,val,xlog)

% size_image = size(I_gr);

%decryption
size_image = size(I_gr);



I_out(:,:) = I_gr(:,:);

for i = size_image(1):-1:1
   for j = size_image(2):-1: 1
        temp = I_out(i,j);
        I_out(i,j) = I_out(xsin(i),xlog(j));
        I_out(xsin(i),xlog(j)) = temp;
   end
end



end
