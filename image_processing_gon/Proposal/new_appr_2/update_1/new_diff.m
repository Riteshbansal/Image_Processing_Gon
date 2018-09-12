function [ linker,mat_diff_out ] = new_diff( matrix_gen,mat_diff )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
linker = [];
main_mat = bin_arr(matrix_gen);
diff_mat = bin_arr(mat_diff);
N = 1;

while(N<numel(matrix_gen)+1)
    m1 = main_mat(N);
    m2 = diff_mat(1);
    m3 = bitxor(m1,m2);
    linker = [linker, m3];
    m4(:,:) = diff_mat(:,:);
    diff_mat = [m4(2:end),m3];
    N= N+1;
end
linker = bin_arr_dec(linker,matrix_gen);
mat_diff_out = bin_arr_dec(diff_mat,matrix_gen);
end

