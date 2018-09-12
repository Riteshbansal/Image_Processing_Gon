function m = mat_rev_diffussion(mat)

[M,N] = size(mat);
Image_change_dec = mat(:,:);
for i = M:-1:1;
    
   for j = N:-1:2
%        temp = bitxor(Image_change_dec(i,j-1), vig(1+xlog_d(1,i),j));
       Image_change_dec(i,j) = bitxor(Image_change_dec(i,j),Image_change_dec(i,j-1));
   end
    if(i~=1)
%     temp = bitxor(Image_change_dec(i-1,N), vig(1+xlog_d(1,i),1));
    Image_change_dec(i,1) = bitxor(Image_change_dec(i,1),Image_change_dec(i-1,N));
    
    end
end

m = Image_change_dec;
end