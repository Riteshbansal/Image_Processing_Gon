function mat = bin_arr_dec(matrix_inp,I)
% size_mat = size(I);
% r = reshape(matrix_inp,8,size_mat(1)*size_mat(2));
% r = r';
% r = bi2de(r, 'left-msb');
% r = r';
% r = reshape(r,size_mat(2),size_mat(1));
% r = r';
% mat = r;

size_mat = size(I);
r = reshape(matrix_inp,size_mat(2),size_mat(1));
r = r';
% r = bi2de(r, 'left-msb');
% r = r';
% r = reshape(r,size_mat(2),size_mat(1));
% r = r';
mat = r;

end