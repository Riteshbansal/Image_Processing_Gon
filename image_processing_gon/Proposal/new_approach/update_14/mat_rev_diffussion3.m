function m = mat_rev_diffussion3(mat,xsin,xlog)

xsin_dash = reshape(xsin,size(mat,1),size(mat,2))';
xlog_dash = reshape(xlog,size(mat,1),size(mat,2))';
xsin_dash = xsin_dash(:);
xsin_dash = xsin_dash';
xlog_dash = xlog_dash(:);
xlog_dash = xlog_dash';


[M,N] = size(mat);


r = mat(:,:).';
r_col = r(:);
r_col = r_col';

Image_change(:,:) = r_col(:,:);

for i = 1:1:numel(r_col)-1
        temp = bitxor(Image_change(1,i+1),xlog(1,i));
%         temp = (Image_change(1,i+1));
        Image_change(1,i) = bitxor(temp,Image_change(1,i));
end

Image_change = bitxor(Image_change,xsin_dash);

for i = numel(mat):-1:2
        temp = bitxor(Image_change(1,i-1),xsin(1,i));
%         temp = (Image_change(1,i-1));
        Image_change(1,i) = bitxor(temp,Image_change(1,i));
end
r_col = bitxor(Image_change,xlog_dash);

r = reshape(r_col,N,M);

m = r';
end