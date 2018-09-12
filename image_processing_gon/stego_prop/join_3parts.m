function  comp1 = join_3parts(mat,mat1,mat2) 

mat = [mat;mat1;mat2];
% mat = bitxor(mat,1);
kkk=mat2(end-2:end);
kkk= 3+(bi2de(kkk','left-msb'));
comp1 = mat(1:numel(mat)-kkk,1);

end