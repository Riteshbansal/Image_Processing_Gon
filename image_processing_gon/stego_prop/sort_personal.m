function [a,idx] = sort_personal(mat, col)

[~,idx]=sort(mat(:,col),'descend');
a=mat(idx,:);

end