function block_circulant_mat = block_circulatnt_matrix(h)
% clc
% clear all
% % h = (1/8 )*ones(3,3);
% % h(3,3)=0;
% h = [1,2,3;4,5,6;7,8,9];
k = zeros(1,numel(h));
count = size(h,1);
for i =1:1:size(h,1)
    k(1,(size(h,1)*(i-1))+1:(size(h,1)*(i-1))+size(h,1)) = h(count,:);
    count = count-1;
end

l1 = h.';
vector_h = l1(:);
vector_h = vector_h';

block_circulant_mat = zeros(size(h,1),numel(vector_h));
for i =1:1:size(h,1)
    k1 = k(:,:);
    k1 = circshift(k1,3*(i),2);
    block_circulant_mat(i,:) = k1(:,:);
end

end