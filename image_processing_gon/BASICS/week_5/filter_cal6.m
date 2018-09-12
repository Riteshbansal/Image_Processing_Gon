function k = filter_cal6(x_block,zz)

x = x_block(:);
x_mean = floor(mean2(x));
[s1,s2] = size(x_block);
h = ones(s1,s2);

h(:,:) = x_mean;
y = x_block- h;
y = abs(y);

[xk,yk] = find(y==min(y(:)));

a = unique(x_block);
    out = [a,histc(x_block(:),a)];
    b = find(out(:,2)==max(out(:,2)));
    nu = numel(b);
    if(nu==1)
    k1 = out(b,1);
    else
       if(mod(nu,2)==1)
          mid = ceil(nu/2); 
           k1 = out(b(mid),1);
       else
           mid = floor(nu/2); 
           
           if(zz==out(b(mid),1))
               k1 = out(b(mid),1);
           elseif(zz == out(b(mid+1),1))
              k1 =  out(b(mid+1),1);
              
           else
           k1 = floor((out(b(mid),1)+out(b(mid+1),1))/2);
           end
       end
    end
    
if(all(y == y(1)))
    
    
    
    [xk1,yk1] = find(x_block==min(x_block(:)));    
    k2 = x_block(xk1(1,1), yk1(1,1));
    
else
    k2 = x_block(xk(1,1), yk(1,1));
end
xx = 100*abs((k2-k1)/k1);
    
    if(xx<20)
        k = k1;
    else 
        k = k2;
    end
    
    fil = (1/9)*ones(3,3);
    im = imfilter(x_block,fil);
    
 
%              xx = 100*abs((k-zz)/zz);
%             
% 
%             if(xx>15 && xx<50)
%                 k ;
%             end
end