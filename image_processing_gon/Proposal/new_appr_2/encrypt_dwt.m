function [enc,pix1] = encrypt_dwt(mat,pix,per)
pix = ceil(abs(pix));

if(pix <= 0)
 pix = 0;   
end
pix = pix+1;
% mat = bitxor(mat,pix);
mat(1,1) =bitxor(pix,mat(1,1)); 
[LL ,LH, HL, HH] = dwt2(mat,'haar');
kk = LL-floor(LL+0.2);
ll = floor(LL+0.2);
val=mod(per*pix,1);
[xsin,xlog] = chaotic_map(val,ll);
xsin = 1+floor(mod(xsin(3:end)*10^6,256));
xlog = 1+floor(mod(xlog(3:end)*10^6,256));
% xsin = reshape(xsin,size(ll,1),size(ll,2))';
% xlog = reshape(xlog,size(ll,1),size(ll,2))';

im1 = mat_diffussion3(ll,xsin,xlog);
im1 = confusion_impl2(im1,per);
HH = confusion_impl2(HH,per);
HL = confusion_impl2(HL,per);
LH = confusion_impl2(LH,per);
im1 = im1+kk;
enc = idwt2(im1,LH,HL,HH,'haar');
[LL ,LH, HL, HH] = dwt2(enc,'haar');

pix_2 = LL(size(im1,1),size(im1,2));
pix2 = LL(1,1);

pix1 = ((pix_2+pix2)/2);
end