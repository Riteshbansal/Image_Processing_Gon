function enc = encrypt_dwt2(mat,xlog,ylog,pix)
pix = ceil(abs(pix));
% mat = bitxor(mat,pix);
mat(1,1) =bitxor(pix,mat(1,1)); 
mat = mat_diffussion(mat);

[LL ,LH, HL, HH] = dwt2(mat,'haar');
% ll = ceil(LL);
% im1 = mat_diffussion(ll);
im1 = confusion_impl(LL,xlog,ylog);
enc = idwt2(im1,LH,HL,HH,'haar');

end