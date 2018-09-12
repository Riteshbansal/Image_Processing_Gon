function m = mat_diffussion(mat)

[M,N] = size(mat);
Image_change = mat(:,:);
for i = 1:1:M
    if(i~=1)
%     temp = bitxor(Image_change(i-1,N), vig(1+xlog_d(1,i),1));
    Image_change(i,1) = bitxor(Image_change(i-1,N),Image_change(i,1));  
    end
   for j = 2:1:N
%        temp = bitxor(Image_change(i,j-1), vig(1+xlog_d(1,i),j));
       Image_change(i,j) = bitxor(Image_change(i,j-1),Image_change(i,j)); 
   end    
end

for i = M:-1:1;
    if(i~=M)
%     temp = (Image_change(i+1,1));
    Image_change(i,N) = bitxor(Image_change(i+1,1),Image_change(i,N));  
    end
   for j = N-1:-1:1
%        temp = (Image_change(i,j+1));
       Image_change(i,j) = bitxor(Image_change(i,j+1),Image_change(i,j)); 
   end    
end


m = Image_change;
end