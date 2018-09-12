function dec = decrypt_dwt3(enc,per,mea,xlog,ylog)
% % dec = enc.*mea;
no=16;

[LL1 ,LH1, HL1, HH1] = dwt2(enc,'haar');
% no = (mea*8);
% no = ceil(16/mea);

% kk1 = (LL1)-floor(LL1+0.000000000002); 
% LL1 = confusion_impl_rev2(LL1-kk1,per);
% LL1 = floor(LL1+0.000000000002); 
% LL1 = no.*(LL1+kk1);

% kk1 = (LL1)-floor(LL1+0.000000000002);
% LL1 = floor(LL1+0.000000000002);
% siz = floor((512/no)-1);
% 
% LL1 = mat_rev_diffussion3(LL1,xlog,ylog,siz);
% 
% LL1=LL1+kk1;
LL1 = confusion_impl_rev2(LL1.*no,per);
HH1 = confusion_impl_rev2(HH1.*no,per);
HL1 = confusion_impl_rev2(HL1.*no,per);
LH1 = confusion_impl_rev2(LH1.*no,per);

% LH1 = LH1.*1.4;
% x1 = (LH1+HL1)/2;
% x2 = (LH1-HL1)/2;
% % 
% dec = idwt2(im11,x1,x2,HH1,'haar');
% dec = idwt2(LL1,LH1,HL1,HH1,'haar');
 dec = idwt2(LL1,HL1,LH1,HH1,'haar');
%   dec = idwt2(LL1,HL1.*no,LH1.*no,HH1,'haar');

dec = dec.*mea;
dec = floor(dec+0.000000000002);
 dec(dec<0)=0;
end