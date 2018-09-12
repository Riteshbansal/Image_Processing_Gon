function m = changer(mat,dict)
size_mat = size(mat);
r = mat(:,:).';
Image_change = r(:)';
for i = 1:1:numel(Image_change)
    Image_change(1,i) = dict(Image_change(1,i),2);
end
m = reshape(Image_change,size_mat(2),size_mat(1))';
end