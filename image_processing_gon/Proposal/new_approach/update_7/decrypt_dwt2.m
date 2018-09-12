function dec = decrypt_dwt2(mat,pix)
pix = ceil (abs(pix));

[LL1 ,LH1, HL1, HH1] = dwt2(mat,'haar');
% % ll1 = floor(LL1);
% % ll1(ll1<0) = 0;
LL1 = confusion_impl_rev2(LL1,pix);
HH1 = confusion_impl_rev2(HH1,pix);
HL1 = confusion_impl_rev2(HL1,pix);
LH1 = confusion_impl_rev2(LH1,pix);
dec = idwt2(LL1,LH1,HL1,HH1,'haar');
dec(dec<0) = 0;
dec = mat_rev_diffussion(floor(dec));

dec(1,1) =bitxor(pix,floor(abs(dec(1,1)))); 

end