function m = mat_diffussion3(mat,xlog,ylog,siz)
% clc
% clear
% mat = 1:9;
% mat = reshape(mat,3,3)';
xlog1 = xlog(1:numel(mat));
ylog1 = ylog(1:numel(mat));

xlog = 1+floor(mod(xlog1*10^6,siz));
ylog = 1+floor(mod(ylog1*10^6,siz));

xsin_dash = reshape(xlog,size(mat,1),size(mat,2))';
xlog_dash = reshape(ylog,size(mat,1),size(mat,2))';
xsin_dash = xsin_dash(:);
xsin_dash = xsin_dash';
xlog_dash = xlog_dash(:);
xlog_dash = xlog_dash';

size_mat = size(mat);

r = mat(:,:).';
r_col = r(:);
r_col = r_col';

r_col = bitxor(r_col,xlog_dash);
Image_change(:,:) = r_col(:,:);

for i = 2:1:numel(Image_change)
        temp = bitxor(Image_change(1,i-1),xlog(1,i-1));
        Image_change(1,i) = bitxor(temp,Image_change(1,i));
end
Image_change = bitxor(Image_change,xsin_dash);
% 
for i = numel(Image_change)-1:-1:1;
        temp = bitxor(Image_change(1,i+1),ylog(1,i+1));
        Image_change(1,i) = bitxor(temp,Image_change(1,i));
end

r = reshape(Image_change,size_mat(2),size_mat(1));

m = r';

end