function out = inside_loop(N1,N2,k1,k2,x)
% clc
% clear all
% n2 = 1;
% n1 = 1;
% [N1 ,N2] = size(x);
j = sqrt(-1);
% el = 1;
new_mat = ones(N1,N2);
w2 = (2*pi*k2)/N2;
w1  = (2*pi*k1)/N1;

for n1=0:1:N1-1
   exp_1 = exp(-j*n1*w1);
    for n2=0:1:N2-1
        exp_2 = exp(-j*n2*w2);
        new_mat(n1+1,n2+1) = x(n1+1,n2+1)*exp_1*exp_2; 
    end
end


out = sum(sum(new_mat));

end
