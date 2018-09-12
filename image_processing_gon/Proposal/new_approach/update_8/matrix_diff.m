function enc = matrix_diff(mat)
[LL ,LH, HL, HH] = dwt2(mat,'haar');

enc = LL(size(LL,1),size(LL,2));

end