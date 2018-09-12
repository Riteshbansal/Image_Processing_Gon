function enc = matrix_diff(mat)
[LL ,LH, HL, HH] = dwt2(mat,'haar');

enc1 = ceil(LL(size(LL,1),size(LL,2))+0.5);
enc2 = ceil(LL(1,1)+0.5);
enc = (enc1+enc2)/2;

end