function m = mat_rev_diffussion2(mat,xsin,xlog)

[M,N] = size(mat);
Image_change_dec = mat(:,:);

for i = 1:1:M;
    
   for j = 1:1:N-1
       temp = bitxor(Image_change_dec(i,j+1), xlog(i,j));
       Image_change_dec(i,j) = bitxor(temp,Image_change_dec(i,j)); 
%        Image_change_dec(i,j) = bitxor(Image_change_dec(i,j+1),Image_change_dec(i,j)); 

   end
    if(i~=M)
    temp = bitxor(Image_change_dec(i+1,1), xlog(i,N));
    Image_change_dec(i,N) = bitxor(temp,Image_change_dec(i,N));  
%      Image_change_dec(i,N) = bitxor(Image_change_dec(i+1,1),Image_change_dec(i,N));  

    end
end
Image_change_dec = bitxor(Image_change_dec,xsin');

for i = M:-1:1;
   for j = N:-1:2
       temp = bitxor(Image_change_dec(i,j-1), xsin(i,j));
       Image_change_dec(i,j) = bitxor(Image_change_dec(i,j),temp);
%        Image_change_dec(i,j) = bitxor(Image_change_dec(i,j),Image_change_dec(i,j-1));
 
   end
    if(i~=1)
    temp = bitxor(Image_change_dec(i-1,N), xsin(i,1));
    Image_change_dec(i,1) = bitxor(Image_change_dec(i,1),temp);
%        Image_change_dec(i,1) = bitxor(Image_change_dec(i,1),Image_change_dec(i-1,N));
 
    end
end
Image_change_dec = bitxor(Image_change_dec,xlog');

m = Image_change_dec;
end