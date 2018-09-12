function dec = decrypt_dwt2(enc,pix,per)
pix = ceil (abs(pix));
[LL1 ,LH1, HL1, HH1] = dwt2(enc,'haar');
LL1 = confusion_impl_rev2(LL1,per);
HH1 = confusion_impl_rev2(HH1,per);
HL1 = confusion_impl_rev2(HL1,per);
LH1 = confusion_impl_rev2(LH1,per);
enc = idwt2(LL1,LH1,HL1,HH1,'haar');

enc(enc<0) = 0;
[xsin,xlog] = chaotic_map(mod(per*pix,1),enc);


xsin = 1+floor(mod(xsin(3:end)*10^6,256));
xlog = 1+floor(mod(xlog(3:end)*10^6,256));
xsin = reshape(xsin,size(enc,1),size(enc,2))';
xlog = reshape(xlog,size(enc,1),size(enc,2))';
enc = enc+0.2;
enc = floor(enc);
% enc = ceil(enc);

enc = mat_rev_diffussion((enc),xsin,xlog);
enc(1,1) =bitxor(pix,floor(abs(enc(1,1)))); 
dec = enc;
end