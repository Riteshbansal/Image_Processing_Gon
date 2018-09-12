function [enc,pix1] = encrypt_dwt(mat,pix,per)
pix = ceil(abs(pix));

if(pix <= 0)
 pix = 0;   
end
pix = pix+1;
% mat = bitxor(mat,pix);
mat(1,1) =bitxor(pix,mat(1,1)); 
[LL ,LH, HL, HH] = dwt2(mat,'haar');
ll = ceil(LL);
[xsin,xlog] = chaotic_map(per,ll);


xsin = 1+floor(mod(xsin(3:end)*10^6,256));
xlog = 1+floor(mod(xlog(3:end)*10^6,256));

xsin = reshape(xsin,size(ll,1),size(ll,2))';
xlog = reshape(xlog,size(ll,1),size(ll,2))';

im1 = mat_diffussion(ll,xsin,xlog);
im1 = confusion_impl2(im1,per);
HH = confusion_impl2(HH,per);
HL = confusion_impl2(HL,per);
LH = confusion_impl2(LH,per);
pix1 = im1(size(im1,1),size(im1,2));
enc = idwt2(im1,LH,HL,HH,'haar');

end