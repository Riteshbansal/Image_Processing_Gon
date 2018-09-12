function [s1,s2,s3] = divide_3parts(comp1)
rem = mod(numel(comp1),3);
add_val = [ zeros(1,3-rem),de2bi(3-rem,3,'left-msb')];
comp2 = [comp1;add_val'];
k = numel(comp2)/3;
s1 = comp2(1:k,1);
s2 = comp2(k+1:2*k,1);
s3 = comp2(2*k+1:3*k,1);
end