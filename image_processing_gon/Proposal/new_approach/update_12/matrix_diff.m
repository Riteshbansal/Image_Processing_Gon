function enc = matrix_diff(mat)
[LL ,LH, HL, HH] = dwt2(mat,'haar');

enc1 = LL(size(LL,1),size(LL,2));
enc2 = LL(1,1);
enc = (enc1+enc2)/2;

end