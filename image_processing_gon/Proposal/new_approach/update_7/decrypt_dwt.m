function dec = decrypt_dwt(mat,pix,per)
pix = ceil (abs(pix));
[LL1 ,LH1, HL1, HH1] = dwt2(mat,'haar');
ll1 = floor(LL1);
ll1(ll1<0) = 0;
ll1 = confusion_impl_rev2(ll1,per);
im11 = mat_rev_diffussion(ll1);
HH1 = confusion_impl_rev2(HH1,per);
HL1 = confusion_impl_rev2(HL1,per);
LH1 = confusion_impl_rev2(LH1,per);
dec = idwt2(im11,LH1,HL1,HH1,'haar');
dec(1,1) =bitxor(pix,floor(abs(dec(1,1)))); 

end