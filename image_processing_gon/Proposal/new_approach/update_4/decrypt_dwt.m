function dec = decrypt_dwt(mat,pix)
pix = ceil (abs(pix));
[LL1 ,LH1, HL1, HH1] = dwt2(mat,'haar');
ll1 = floor(LL1);
ll1(ll1<0) = 0;
ll1 = confusion_impl_rev2(ll1,pix);
im11 = mat_rev_diffussion(ll1);
dec = idwt2(im11,LH1,HL1,HH1,'haar');
dec(1,1) =bitxor(pix,floor(abs(dec(1,1)))); 

end