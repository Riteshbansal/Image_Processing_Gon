function mat = impulse_matrix(inp_mat,mat, row,column)
% clc
% clear
% x = [1,2,3;4,5,6;];
% h = [1,1;1,1];
% % h = [-1,-1,-1;-1,9,-1;-1,-1,-1];
% M= size(x,1);
% N= size(x,2);
% m= size(h,1);
% n= size(h,2);
% mat = zeros(M+(2*(m-1)),N+(2*(n-1)));
% % h = [-1,-1,-1;-1,9,-1;-1,-1,-1];
% row = 1;
% column=1;
% mat(row:row+size(h,1)-1,column:column+size(h,2)-1)= h(:,:);


mat(row:row+size(inp_mat,1)-1,column:column+size(inp_mat,2)-1)= inp_mat(:,:);

end