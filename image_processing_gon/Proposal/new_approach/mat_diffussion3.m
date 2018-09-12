function m = mat_diffussion3(mat,xsin,xlog)
% clc
% clear
% mat = 1:9;
% mat = reshape(mat,3,3)';
xsin_dash = reshape(fliplr(xsin),size(mat,1),size(mat,2))';
xlog_dash = reshape(fliplr(xlog),size(mat,1),size(mat,2))';
xsin_dash = xsin_dash(:);
xsin_dash = xsin_dash';
xlog_dash = xlog_dash(:);
xlog_dash = xlog_dash';

size_mat = size(mat);

r = mat(:,:).';
r_col = r(:);
r_col = r_col';

% r_col = bitxor(r_col,xlog_dash);
Image_change(:,:) = r_col(:,:);

for i = 3:1:numel(Image_change)
    temp = (Image_change(1,i-2));
    %             temp = bitxor(Image_change(1,i-2),xsin(1,i-2));
    temp1 = bitxor(Image_change(1,i-1),temp);
%         temp1 = (Image_change(1,i-1));
    Image_change(1,i) = bitxor(temp1,Image_change(1,i));
end
% Image_change = bitxor(Image_change,xsin_dash);

for i = numel(Image_change)-2:-1:1;
    temp = (Image_change(1,i+2));
    %             temp = bitxor(Image_change(1,i+2),xlog(1,i+2));
    temp1 = bitxor(Image_change(1,i+1),temp);
    %     temp = (Image_change(1,i+1));
    Image_change(1,i) = bitxor(temp1,Image_change(1,i));
end

r = reshape(Image_change,size_mat(2),size_mat(1));

m = r';

end