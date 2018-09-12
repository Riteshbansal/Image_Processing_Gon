function m = mat_diffussion2(mat,xsin,xlog,xlog1)

[M,N] = size(mat);
Image_change = mat(:,:);
Image_change = bitxor(Image_change,xlog');
for i = 1:1:M
    if(i~=1)
        temp = bitxor(Image_change(i-1,N), xsin(i,1));
        Image_change(i,1) = bitxor(temp,Image_change(i,1));
        %     Image_change(i,1) = bitxor(Image_change(i-1,N),Image_change(i,1));
        
    end
    for j = 2:1:N
        temp = bitxor(Image_change(i,j-1), xsin(i,j));
        Image_change(i,j) = bitxor(temp,Image_change(i,j));
        %        Image_change(i,j) = bitxor(Image_change(i,j-1),Image_change(i,j));
        
    end
end
Image_change = bitxor(Image_change,xsin');
Image_change = vignere(Image_change,xlog1);

for i = M:-1:1;
    if(i~=M)
        temp = bitxor(Image_change(i+1,1),xlog(i,N));
        Image_change(i,N) = bitxor(temp,Image_change(i,N));
        %         Image_change(i,N) = bitxor(Image_change(i+1,1),Image_change(i,N));
        
    end
    for j = N-1:-1:1
        temp = bitxor(Image_change(i,j+1),xlog(i,j));
        Image_change(i,j) = bitxor(temp,Image_change(i,j));
        %         Image_change(i,j) = bitxor(Image_change(i,j+1),Image_change(i,j));
        
    end
end


m = Image_change;
end