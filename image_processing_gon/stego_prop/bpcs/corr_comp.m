function [rmn] = corr_comp(a)
% clc
% clear
%
% % n=8;
% % a = mod(bsxfun(@plus,1:n,(1:n)'),2);
%
% a = ones(8,8);
% % a(:,6) = 0;
% % a(6,:) = 0;
% % a(6,6) = 1;
%
%
% % a(:,2) = 0;
% % a(:,4) = 0;
% % a(:,6) = 0;
% % a(:,8) = 0;
%
% a(1,3) = 0;a(1,6)=1;
% a(2,2) = 0;a(2,5)=1;a(2,8)=1;
% a(3,1) = 0;a(3,4)=1;a(3,7)=1;
% a(3,1) = 0;a(3,4)=1;a(3,7)=1;
% a(4,3) = 0;a(4,6)=1;
% a(5,3) = 0;a(5,6)=1;
% a(6,2) = 0;a(6,5)=1;a(6,8)=1;
% a(7,2) = 0;a(7,5)=1;a(7,8)=1;
% a(8,1) = 0;a(8,4)=1;a(8,7)=1;
%

[row,col] = size(a);

count = 1;
for i = 1:1:row-1
    for j = 1:1:col
        m_h(count)=a(i,j);
        n_h(count)=a(i+1,j);
        count = count+1;
    end
end
rmn=[];
m_h=double(m_h);n_h=double(n_h);

Em=mean(m_h);En=mean(n_h);
Dm=std(m_h);Dn=std(n_h);
Cmn=mean((m_h-Em).*(n_h-En));
rmn(1)=Cmn/(Dm*Dn);

count = 1;
for i = 1:1:row
    for j = 1:1:col-1
        m_v(count)=a(i,j);
        n_v(count)=a(i,j+1);
        count = count+1;
    end
end
m_v=double(m_v);n_v=double(n_v);

Em=mean(m_v);En=mean(n_v);
Dm=std(m_v);Dn=std(n_v);
Cmn=mean((m_v-Em).*(n_v-En));
rmn(2)=Cmn/(Dm*Dn);

count = 1;
for i = 1:1:row-1
    for j = 1:1:col-1
        m_d(count)=a(i,j);
        n_d(count)=a(i+1,j+1);
        count = count+1;
    end
end

m_d=double(m_d);n_d=double(n_d);

Em=mean(m_d);En=mean(n_d);
Dm=std(m_d);Dn=std(n_d);
Cmn=mean((m_d-Em).*(n_d-En));
rmn(3)=Cmn/(Dm*Dn);

end