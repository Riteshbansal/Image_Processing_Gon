function m = mat_rev_diffussion(mat)

[M,N] = size(mat);
Image_change_dec = mat(:,:);

for i = 1:1:M;
    
   for j = 1:1:N-1
%        temp = bitxor(I_gr(i,j+1), vig3(1+xsin_d(1,i),1+vig3(i,j)));
       Image_change_dec(i,j) = bitxor(Image_change_dec(i,j+1),Image_change_dec(i,j)); 
   end
    if(i~=M)
%     temp = bitxor(I_gr(i+1,1), vig3(1+xsin_d(1,i),1+vig3(i,N)));
    Image_change_dec(i,N) = bitxor(Image_change_dec(i+1,1),Image_change_dec(i,N));  
    end
end

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