function k = filter_cal(x_block,zz)

x = x_block(:);
x_mean = floor(mean2(x));
h = ones(size(x_block,1),size(x_block,2));

h(:,:) = x_mean;
y = x_block- h;
y = abs(y);

[xk,yk] = find(y==min(y(:)));

if(all(y == y(1)))
    
%     a = unique(x_block);
%     out = [a,histc(x_block(:),a)];
%     b = find(out(:,2)==max(out(:,2)));
%     k1 = out(b,1);
    
    [xk1,yk1] = find(x_block==min(x_block(:)));    
    k2 = x_block(xk1(1,1), yk1(1,1));
%     xx = 100*abs((k2-k1)/k1);
    
%     if(xx<25)
%         k = k1;
%     else 
        k = k2;
%     end
    
else
    k = x_block(xk(1,1), yk(1,1));
end


end