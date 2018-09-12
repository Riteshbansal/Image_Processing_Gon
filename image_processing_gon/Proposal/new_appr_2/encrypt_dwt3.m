function [enc] = encrypt_dwt3(mat,mea,xsin,xlogarith,xlog,ylog)
% kk = (mat./2)-floor(mat./2);
enc = (mat./mea);
% no = (mea*8);
% no = ceil(16/mea);
no=1;
% no2 = 1;
% no2 =numel(mat); 

[LL ,LH, HL, HH] = dwt2(enc,'haar');
% kk1 = (LL./no)-floor(LL./no+0.000000000002); 
% LL = floor(LL./no+0.000000000002);
% 
% 
LL = confusion_impl2(LL./no,xsin,xlogarith);
HH = confusion_impl2(HH./no,xsin,xlogarith);
HL = confusion_impl2(HL./no,xsin,xlogarith);
LH = confusion_impl2(LH./no,xsin,xlogarith);
% kk1 = (LL)-floor((LL+0.02)); 
% LL = floor((LL+0.02));
% % LL = mat_diffussion4(LL,xlog,ylog);
% LL = LL+(kk1);
% LH= LH./no2;
% HL= HL./no2;
% HH= HH./no2;
% 
enc = idwt2(LL,HL,LH,HH,'haar');


% kk1 = (LL)-floor(LL+0.000000000002);
% LL = floor(LL+0.000000000002);
% siz = floor((512/no)-1);
% LL = mat_diffussion3(LL,xlog,ylog,siz);
% 
% LL=LL+kk1;
% LL = LL+(kk1);
% x1 = HL+LH;
% x2 = LH-HL;
% enc = idwt2(im1,x1./2,x2,HH,'haar');
% enc = idwt2(LL,HL,LH,HH,'haar');

% enc = idwt2(LL,HL./no,LH./no,HH,'haar');
% 
% enc = idwt2(LL,LH,HL,HH,'haar');
% enc(enc<0) = 0;
end
%  [k1,k2] = meshgrid(1:256,1:256);
% mesh(k1,k2,LL)
% figure(),mesh(k1,k2,LL)
% [k1,k2] = meshgrid(1:512,1:512);
% figure(),mesh(k1,k2,mat)
% figure(),mesh(k1,k2,enc)
