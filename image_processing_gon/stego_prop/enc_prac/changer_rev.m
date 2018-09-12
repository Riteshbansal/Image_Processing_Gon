function m = changer_rev(mat,dict)

dic_new(:,1) = dict(:,2);
dic_new(:,2) = dict(:,1);
[~,idx]=sort(dic_new(:,1),'ascend');
dic_new=dic_new(idx,:);
[M,N] = size(mat);
r = mat(:,:).';
r_col = r(:);
r_col = r_col';

Image_change(:,:) = r_col(:,:);
for i = numel(mat):-1:1
    Image_change(1,i) = dic_new(Image_change(1,i),2);
end
r = reshape(Image_change,N,M);
m = r';
end