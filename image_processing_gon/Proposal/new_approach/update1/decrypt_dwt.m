function dec = decrypt_dwt(mat,xlog,ylog,pix)
pix = floor(abs(pix));
[LL1 ,LH1, HL1, HH1] = dwt2(mat,'haar');
ll1 = floor(LL1);
ll1(ll1<0) = 0;
ll1 = confusion_impl_rev(ll1,xlog,ylog);
im11 = mat_rev_diffussion(ll1);
dec = idwt2(im11,LH1,HL1,HH1,'haar');
dec= floor(dec);
dec(dec<0) = 0;
dec = bitxor(dec,pix);

end