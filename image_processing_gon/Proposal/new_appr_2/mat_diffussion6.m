function Image_change = mat_diffussion6(mat)

[M,N] = size(mat);
Image_change = mat(:,:);
for i = 1:1:M
    if(i~=1)
%     temp = bitxor(Image_change(i-1,N), xsin(i,1));
    Image_change(i,1) = bitxor(Image_change(i-1,N),Image_change(i,1));  
    end
   for j = 2:1:N
%        temp = bitxor(Image_change(i,j-1), xsin(i,j));
       Image_change(i,j) = bitxor(Image_change(i,j-1),Image_change(i,j)); 
   end    
end
% Image_change = bitxor(Image_change,xlog);

% for i = M:-1:1;
%     if(i~=M)
% %     temp = bitxor(Image_change(i+1,1),xlog(i,N));
%         f1 = Image_change(i+1,1);
%         f2 = Image_change(i+1,2);
%         temp = bitxor(f1,f2);
%     Image_change(i,N) = bitxor(temp,Image_change(i,N));  
%     end
%    for j = N-2:-1:1
% %        temp = bitxor(Image_change(i,j+1),xlog(i,j));
%         f1 = Image_change(i,j+2);
%         f2 = Image_change(i,j+1);
%         temp = bitxor(f1,f2);
%        Image_change(i,j) = bitxor(temp,Image_change(i,j)); 
%    end    
% end


% m = Image_change;
end