function [enc,pix1] = encrypt_dwt2(mat,pix,per)
pix = ceil(abs(pix));
if(pix <= 0)
 pix = 0;   
end
pix = pix+1;
% mat = bitxor(mat,pix);
val=mod(per*pix,1);
mat(1,1) =bitxor(pix,mat(1,1)); 
[xsin,xlog] = chaotic_map(val,mat);
xsin = 1+floor(mod(xsin(3:end)*10^6,255));
xlog = 1+floor(mod(xlog(3:end)*10^6,255));
xsin = reshape(xsin,size(mat,1),size(mat,2))';
xlog = reshape(xlog,size(mat,1),size(mat,2))';
max1 =max(max(xsin));
max2 = max(max(xlog));

if(max1 ==256||max2 == 256)
    max2;
    
end
enc = mat_diffussion2(mat,xsin,xlog);
[LL ,LH, HL, HH] = dwt2(enc,'haar');
LL = confusion_impl2(LL,per);
HH = confusion_impl2(HH,per);
HL = confusion_impl2(HL,per);
LH = confusion_impl2(LH,per);
enc = idwt2(LL,LH,HL,HH,'haar');

pix_2 = enc(size(enc,1),size(enc,2));
pix2 = enc(1,1);

pix1 = (pix_2+pix2)/2;
end