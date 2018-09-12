function enc = encrypt_dwt(mat,pix)
pix = ceil(abs(pix));
% mat = bitxor(mat,pix);
mat(1,1) =bitxor(pix,mat(1,1)); 
[LL ,LH, HL, HH] = dwt2(mat,'haar');
ll = ceil(LL);
im1 = mat_diffussion(ll);
im1 = confusion_impl2(im1,pix);
HH = confusion_impl2(HH,pix);
HL = confusion_impl2(HL,pix);
LH = confusion_impl2(LH,pix);

enc = idwt2(im1,LH,HL,HH,'haar');

end