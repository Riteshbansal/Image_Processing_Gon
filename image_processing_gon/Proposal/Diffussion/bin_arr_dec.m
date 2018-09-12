function mat = bin_arr_dec(matrix_inp,I)
size_mat = size(I);
N = numel(matrix_inp);
r = matrix_inp(1:N);
% g = matrix_inp(N+1:2*N);
% b = matrix_inp((2*N)+1:3*N);
% 

r = reshape(r,size_mat(2),size_mat(1));

% r = reshape(r,8,size_mat(1)*size_mat(2));
% g = reshape(g,8,size_mat(1)*size_mat(2));
% b = reshape(b,8,size_mat(1)*size_mat(2));

r = r';
% g = g';
% b = b';

% r = bi2de(r, 'left-msb');
% g = bi2de(g, 'left-msb');
% b = bi2de(b, 'left-msb');


r = r';
% g = g';
% b = b';


r = reshape(r,size_mat(2),size_mat(1));
% g = reshape(g,size_mat(2),size_mat(1));
% b = reshape(b,size_mat(2),size_mat(1));

r = r';
% g = g';
% b = b';

% mat = cat(3,r,g,b);
mat = r;

end