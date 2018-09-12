function [enc,pix1] = encrypt_dwt(mat,pix,per)
pix = ceil(abs(pix));

if(pix <= 0)
 pix = 0;   
end
pix = pix+1;
no=1;
no2 =512*512; 
% mat = bitxor(mat,pix);
mat(1,1) =bitxor(pix,mat(1,1)); 
[LL ,LH, HL, HH] = dwt2(mat,'haar');

% kk = LL-floor(LL+0.2);
% ll = floor(LL+0.2);
val=mod(per*pix,1);

[xsin,xlog] = chaotic_map(val,LL);
xsin = 1+floor(mod(xsin(3:end)*10^6,127));
xlog = 1+floor(mod(xlog(3:end)*10^6,127));
% xsin = reshape(xsin,size(ll,1),size(ll,2))';
% xlog = reshape(xlog,size(ll,1),size(ll,2))';

% % kk1 = (LL./no)-floor(LL./no+0.002); 
% % ll = floor(LL./no+0.002);
% % ll = mat_diffussion3(ll,xsin,xlog);
% % ll = ll+(kk1);
% % 
% % im1 = confusion_impl2(ll,per);
% % HH = confusion_impl2(HH./no,per);
% % HL = confusion_impl2(HL./no,per);
% % LH = confusion_impl2(LH./no,per);


LL = confusion_impl2(LL./no,per);
HH = confusion_impl2(HH./no,per);
HL = confusion_impl2(HL./no,per);
LH = confusion_impl2(LH./no,per);

kk1 = (LL./no)-floor(LL./no+0.002); 
LL = floor(LL./no+0.002);
LL = mat_diffussion3(LL,xsin,xlog);
LL = LL+(kk1);
% % 




% im1 = im1-1;
% enc = idwt2(im1,LH,HL,HH,'haar');
enc = idwt2(LL,HL./no2,LH./no2,HH./no2,'haar');

% x1 = HL+LH;
% x2 = LH-HL;
% enc = idwt2(im1,x1./no2,x2./no2,HH./no2,'haar');
% if(max(max(enc))>255)
%     max_val = max(max(enc));
%     [x,y] = find(enc==max(max(enc)));
% end

[LL ,LH, HL, HH] = dwt2(enc,'haar');

pix_2 = (LL(size(LL,1),size(LL,2))+0.5);
pix2 = (LL(1,1)+0.5);
pix1 = ((pix_2+pix2)/2);
max(max(enc))
min(min(enc))


end