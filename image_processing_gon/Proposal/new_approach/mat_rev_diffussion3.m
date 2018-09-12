function m = mat_rev_diffussion3(mat,xsin,xlog)

xsin_dash = reshape(fliplr(xsin),size(mat,1),size(mat,2))';
xlog_dash = reshape(fliplr(xlog),size(mat,1),size(mat,2))';
xsin_dash = xsin_dash(:);
xsin_dash = xsin_dash';
xlog_dash = xlog_dash(:);
xlog_dash = xlog_dash';


[M,N] = size(mat);


r = mat(:,:).';
r_col = r(:);
r_col = r_col';

Image_change(:,:) = r_col(:,:);

for i = 1:1:numel(r_col)-2
    temp = (Image_change(1,i+2));
    %         temp = bitxor(Image_change(1,i+2),xlog(1,i+2));
    temp1 = bitxor(Image_change(1,i+1),temp);
    %         temp = (Image_change(1,i+1));
    Image_change(1,i) = bitxor(temp1,Image_change(1,i));
end

% Image_change = bitxor(Image_change,xsin_dash);

for i = numel(mat):-1:3
    temp = (Image_change(1,i-2));
    %         temp = bitxor(Image_change(1,i-2),xsin(1,i-2));
    temp1 = bitxor(Image_change(1,i-1),temp);
    %         temp = (Image_change(1,i-1));
    Image_change(1,i) = bitxor(temp1,Image_change(1,i));
end
% Image_change = bitxor(Image_change,xlog_dash);

r = reshape(Image_change,N,M);

m = r';
end