function [c]=rl_enc(x)
% clc
% clear
% x = [1,1,1,1,1,1,0,1,0,0,0,0,0,1];
% x = [65,66,67,68,69,70,65,66,67,68,69,70,65,66,67,68];
x = x';

x = de2bi(x,8,'left-msb');
y = x';
x = y(:);
x = x';

ind=1;
c(ind)=0;
if(x(ind)==0)
    c(ind)=c(ind)+1;
else
    c(ind+1)=1;
    ind =2;
end

for i=2 :length(x)
    if x(i-1)==x(i)
        c(ind)=c(ind)+1;
    else
        ind=ind+1;
        c(ind)=1;
    end
end



end