function enc = encrypt_dwt2(mat,pix)

pix = ceil(abs(pix));
mat(1,1) =bitxor(pix,mat(1,1)); 
mat = mat_diffussion(mat);

[LL ,LH, HL, HH] = dwt2(mat,'haar');
LL = confusion_impl2(LL,pix);
HH = confusion_impl2(HH,pix);
HL = confusion_impl2(HL,pix);
LH = confusion_impl2(LH,pix);
enc = idwt2(LL,LH,HL,HH,'haar');

end