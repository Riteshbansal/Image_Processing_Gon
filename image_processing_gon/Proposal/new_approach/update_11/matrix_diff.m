function enc = matrix_diff(mat)
% [LL ,LH, HL, HH] = dwt2(mat,'haar');

enc1 = mat(size(mat,1),size(mat,2));
enc2 = mat(1,1);
enc = (enc1+enc2)/2;

end