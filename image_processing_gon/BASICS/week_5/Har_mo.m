function x = Har_mo(x)

x_r = x(:);
x_r = x_r';

% x_r = x_r.^-1;
n = numel(x);
sum_val = 0;
for i = 1:1:n
    
    if(x_r(i)~=0)
      sum_val = sum_val+(1/x_r(i));  
    end
end
x = (1/sum_val)*n;

end