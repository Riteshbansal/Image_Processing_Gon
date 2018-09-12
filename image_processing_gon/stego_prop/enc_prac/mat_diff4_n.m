function m = mat_diff4_n(mat,dict,xsin_dash)
% clc
% clear
% mat = 1:9;
% mat = reshape(mat,3,3)';
% xsin_dash = reshape(fliplr(xsin),size(mat,1),size(mat,2))';
% xlog_dash = reshape(fliplr(xlog),size(mat,1),size(mat,2))';
xsin_dash = xsin_dash(:);
xsin_dash = xsin_dash';
% xlog_dash = xlog_dash(:);
% xlog_dash = xlog_dash';
% xlog_per_main = 1+floor(mod(xlog(1:row)*10^6,255));
% ylog_per_main = 1+floor(mod(ylog(1:col)*10^6,255));

size_mat = size(mat);

r = mat(:,:).';
Image_change = r(:)';
% Image_change = r_col';

% r_col = bitxor(r_col,xlog_dash);
% Image_change(:,:) = r_col(:,:);

for i = 2:1:numel(Image_change)
%     temp = (Image_change(1,i-2));
%     %             temp = bitxor(Image_change(1,i-2),xsin(1,i-2));
%     temp1 = bitxor(Image_change(1,i-1),temp);
        temp1 = (Image_change(1,i-1));
    Image_change(1,i) = bitxor(temp1,dict(Image_change(1,i)+1,2)-1);
%     Image_change(1,i) = bitxor(temp1,(Image_change(1,i)));
end

Image_change = bitxor(Image_change,xsin_dash);
% Image_change = fliplr(Image_change);
for i = numel(Image_change)-1:-1:1;
%     temp = (Image_change(1,i+2));
%     %             temp = bitxor(Image_change(1,i+2),xlog(1,i+2));
%     temp1 = bitxor(Image_change(1,i+1),temp);
        temp1 = (Image_change(1,i+1));
    Image_change(1,i) = bitxor(temp1,Image_change(1,i));
end

m = reshape(Image_change,size_mat(2),size_mat(1))';

end