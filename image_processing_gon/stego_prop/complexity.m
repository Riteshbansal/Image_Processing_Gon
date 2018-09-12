function comp = complexity(a)

hig_comp = 420;
% hig_comp = 224;
% n=8;
% a = mod(bsxfun(@plus,1:n,(1:n)'),2);
% a = ones(8,8);
% a(:,2) = 0;
% a(:,4) = 0;
% a(:,6) = 0;
% a(:,8) = 0;

cor = zeros(size(a));
[row,col] = size(a);
sumtotal = 0;
for i = 1:1:row
    for j = 1:1:col
        sr= -1;
        er= 1;
        sc= -1;
        ec= 1;
        if(i-1<=0)
            sr = 0;
        end
        if(i+1>row)
            er = 0;
        end
        if(j-1<=0)
            sc = 0;
        end
        if(j+1>col)
            ec = 0;
        end
        a1 = a(i,j);
        sum_nu = 0;
        for k = sr:1:er
            for l = sc:1:ec
                pi = a(i+k,j+l);
                if(a1~=pi)
                    sum_nu = sum_nu+1;
                end
            end
        end
        cor(i,j) = sum_nu;
        sumtotal = sumtotal+sum_nu;
    end
end

comp = sumtotal/hig_comp;
% cor2(:,:) = cor(:,:);
% cor2(cor2<=4)=0;
% sumcor = sum(sum(cor2));
% if(comp>1)
%     comp;
% end
end