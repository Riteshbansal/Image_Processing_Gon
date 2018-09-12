function dec = decrypt_dwt2(mat,xlog,ylog,pix)
pix = ceil (abs(pix));
[LL1 ,LH1, HL1, HH1] = dwt2(mat,'haar');

LL1 = confusion_impl_rev(LL1,xlog,ylog);
dec = idwt2(LL1,LH1,HL1,HH1,'haar');
dec(dec<0) = 0;
dec = mat_rev_diffussion(floor(dec));
dec(1,1) =bitxor(pix,floor(abs(dec(1,1)))); 

end