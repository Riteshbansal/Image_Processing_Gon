function arr = bin_arr(matrix_inp)

r = matrix_inp(:,:).';
% g = matrix_inp(:,:,2).';
% b = matrix_inp(:,:,3).';

r = r(:);
% g_col = g(:);
% b_col = b(:);

% r = de2bi(r,8,'left-msb');
% g_col_dec = de2bi(g_col,8,'left-msb');
% b_col_dec = de2bi(b_col,8,'left-msb');

r = r';
% g_col_dec = g_col_dec';
% b_col_dec = b_col_dec';


r = r(:).';
% g_col_dec = g_col_dec(:).';
% b_col_dec = b_col_dec(:).';

% arr = [r_col_dec g_col_dec b_col_dec];
arr = r;

end