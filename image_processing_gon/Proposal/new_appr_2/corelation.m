function [rmn,rpq] =corelation (I,CiI)
ff = 10000;
for i=1:ff
    x=randi([1 (size(I,1)-1)]);
    y=randi([1 (size(I,2)-1)]);
    m(i)=I(x,y);
    n(i)=I(x+1,y);
    p(i)=CiI(x,y);
    q(i)=CiI(x+1,y);
end
rmn=[];rpq=[];
m=double(m);n=double(n);p=double(p);q=double(q);

Em=mean(m);En=mean(n);Ep=mean(p);Eq=mean(q);
Dm=std(m);Dn=std(n);Dp=std(p);Dq=std(q);
Cmn=mean((m-Em).*(n-En));Cpq=mean((p-Ep).*(q-Eq));
rmn(1)=Cmn/(Dm*Dn);rpq(1)=Cpq/(Dp*Dq);
% figure,suptitle('correlation of horizontal adjacent pixels');
% subplot(1,2,1),plot(m,n,'k.');
% subplot(1,2,2),plot(p,q,'k.');

for i=1:ff
    x=randi([1 (size(I,1)-1)]);
    y=randi([1 (size(I,2)-1)]);
    m(i)=I(x,y);
    n(i)=I(x,y+1);
    p(i)=CiI(x,y);
    q(i)=CiI(x,y+1);
end
m=double(m);n=double(n);p=double(p);q=double(q);

Em=mean(m);En=mean(n);Ep=mean(p);Eq=mean(q);
Dm=std(m);Dn=std(n);Dp=std(p);Dq=std(q);
Cmn=mean((m-Em).*(n-En));Cpq=mean((p-Ep).*(q-Eq));
rmn(2)=Cmn/(Dm*Dn);rpq(2)=Cpq/(Dp*Dq);
% figure,suptitle('correlation of vertical adjacent pixels');
% subplot(1,2,1),plot(m,n,'k.');
% subplot(1,2,2),plot(p,q,'k.');

for i=1:ff
    x=randi([1 (size(I,1)-1)]);
    y=randi([1 (size(I,2)-1)]);
    m(i)=I(x,y);
    n(i)=I(x+1,y+1);
    p(i)=CiI(x,y);
    q(i)=CiI(x+1,y+1);
end
m=double(m);n=double(n);p=double(p);q=double(q);

Em=mean(m);En=mean(n);Ep=mean(p);Eq=mean(q);
Dm=std(m);Dn=std(n);Dp=std(p);Dq=std(q);
Cmn=mean((m-Em).*(n-En));Cpq=mean((p-Ep).*(q-Eq));
rmn(3)=Cmn/(Dm*Dn);rpq(3)=Cpq/(Dp*Dq);
% figure,suptitle('correlation of diagonal adjacent pixels');
% subplot(1,2,1),plot(m,n,'k.');
% subplot(1,2,2),plot(p,q,'k.');


end