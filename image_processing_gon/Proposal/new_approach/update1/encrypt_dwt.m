function enc = encrypt_dwt(mat,xlog,ylog,pix)
pix = floor(abs(pix));
mat = bitxor(mat,pix);
[LL ,LH, HL, HH] = dwt2(mat,'haar');
ll = floor(LL);
im1 = mat_diffussion(ll);
im1 = confusion_impl(im1,xlog,ylog);
enc = idwt2(im1,LH,HL,HH,'haar');

end