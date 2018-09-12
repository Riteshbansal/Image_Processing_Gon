function dec = decrypt_dwt(mat,pix,per)


pix =  ceil(abs(pix));
[LL1 ,LH1, HL1, HH1] = dwt2(mat,'haar');
kk  = LL1-floor(LL1+0.002);
ll2 = confusion_impl_rev2(LL1-kk,per);
ll1 = floor(ll2+0.002);
% ll1(ll1<0) = 0;
val = mod(per*pix,1);

[xsin,xlog] = chaotic_map(val,ll1);

xsin = 1+floor(mod(xsin(3:end)*10^6,127));
xlog = 1+floor(mod(xlog(3:end)*10^6,127));
% xsin = reshape(xsin,size(ll1,1),size(ll1,2))';
% xlog = reshape(xlog,size(ll1,1),size(ll1,2))';


im11 = mat_rev_diffussion3(ll1,xsin,xlog);
im11 = 4.*(im11 +kk);

HH1 = confusion_impl_rev2(HH1,per);
HL1 = confusion_impl_rev2(HL1,per);
LH1 = confusion_impl_rev2(LH1,per);
% dec = idwt2(im11,LH1,HL1,HH1,'haar');
% dec = idwt2(im11,HL1,LH1,HH1,'haar');
x1 = (LH1+HL1)/2;
x2 = (LH1-HL1)/2;

dec = idwt2(im11,x1,x2,HH1,'haar');

dec = floor(dec+0.002);
dec(1,1) =bitxor(pix,floor(abs(dec(1,1)))); 

end