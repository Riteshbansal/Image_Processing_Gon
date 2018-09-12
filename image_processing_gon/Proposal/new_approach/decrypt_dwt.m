function dec = decrypt_dwt(mat,pix,per)
pix =  ceil(abs(pix));
no = 1;
no2 =512*512; 

[LL1 ,LH1, HL1, HH1] = dwt2(mat,'haar');
LH1= LH1.*no2;
HL1= HL1.*no2;
HH1= HH1.*no2;

% LL1 = LL1+1;
val = mod(per*pix,1);
[xsin,xlog] = chaotic_map(val,LL1);
xsin = 1+floor(mod(xsin(3:end)*10^6,127));
xlog = 1+floor(mod(xlog(3:end)*10^6,127));
kk  = LL1-floor(LL1+0.002);
LL1 = floor(LL1+0.002);
LL1 = mat_rev_diffussion3(LL1,xsin,xlog);
LL1 = no.*(LL1 +kk);





LL1 = confusion_impl_rev2(LL1,per);
HH1 = confusion_impl_rev2(HH1.*no,per);
HL1 = confusion_impl_rev2(HL1.*no,per);
LH1 = confusion_impl_rev2(LH1.*no,per);



% xsin = reshape(xsin,size(ll1,1),size(ll1,2))';
% xlog = reshape(xlog,size(ll1,1),size(ll1,2))';

% ll1 =ll1+1;
% % kk  = ll2-floor(ll2+0.002);
% % ll1 = floor(ll2+0.002);
% % ll1 = mat_rev_diffussion3(ll1,xsin,xlog);
% % im11 = no.*(ll1 +(kk));

% HH1 = confusion_impl_rev2(HH1.*no,per);
% HL1 = confusion_impl_rev2(HL1.*no,per);
% LH1 = confusion_impl_rev2(LH1.*no,per);
% dec = idwt2(im11,LH1,HL1,HH1,'haar');
dec = idwt2(LL1,HL1,LH1,HH1,'haar');
% x1 = (LH1+HL1)/2;
% x2 = (LH1-HL1)/2;
% 
% dec = idwt2(im11,x1,x2,HH1,'haar');

dec = floor(dec+0.002);
dec(1,1) =bitxor(pix,floor(abs(dec(1,1)))); 

end