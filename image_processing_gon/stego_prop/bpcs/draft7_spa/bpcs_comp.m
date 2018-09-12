function [comp] = bpcs_comp(a)

hig_comp = 112;
[row,col] = size(a);
sumtotal = 0;
for i = 1:1:row
    for j = 1:1:col-1
        a1 = a(i,j);
        pi = a(i,j+1);
        if(a1~=pi)
            sumtotal = sumtotal+1;
        end
        a1 = a(j,i);
        pi = a(j+1,i);
        if(a1~=pi)
            sumtotal = sumtotal+1;
        end
    end
end

comp = sumtotal/hig_comp;

end