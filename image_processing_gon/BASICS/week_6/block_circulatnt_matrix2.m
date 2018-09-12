function block_circulant_mat = block_circulatnt_matrix2(h)
% % clc
% % clear all
% % h = (1/8 )*ones(3,3);
% % h(3,3)=0;
% % h = [1,2,3;4,5,6;7,8,9];
l1 = h.';
vector_h = l1(:);
vector_h = vector_h';

block_circulant_mat = zeros(numel(vector_h),numel(vector_h));
for i =1:1:numel(vector_h)
    k1 = vector_h';
    k1 = circshift(k1,(i-1),1);
    block_circulant_mat(:,i) = k1(:,:);
end

end