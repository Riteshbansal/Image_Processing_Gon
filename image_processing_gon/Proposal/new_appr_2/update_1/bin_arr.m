function arr = bin_arr(matrix_inp)

r = matrix_inp(:,:).';

r_col = r(:);

% r_col = de2bi(r_col,8,'left-msb');

r_col = r_col';


% r_col = r_col(:).';

arr = [r_col];
end