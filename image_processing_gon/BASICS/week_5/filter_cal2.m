function k = filter_cal2(x_block,zz)
% x_block_1(:,:) = x_block(:,:);
% x_block_1 = x_block_1-zz;
x = x_block(:);
x_mean = floor(mean2(x));
h = ones(size(x_block,1),size(x_block,2));

h(:,:) = x_mean;
y = x_block- h;
y = abs(y);

%                y1 = y(:);
%                y1 = floor(mean2(y1));
%                y = y1-y;
%                 y = abs(y);
[xk,yk] = find(y==min(y(:)));
sum_pix = sum(sum(y));
nu = numel(y);
sum_pix = sum_pix/nu;

if(y(1,1)==sum_pix && y(1,2)==sum_pix && y(1,1)==sum_pix && y(2,1)==sum_pix&&y(1,1)==sum_pix && y(size(x_block,1),size(x_block,2)))
    [xk1,yk1] = find(x_block==min(x_block(:)));
    k = x_block(xk1(1,1), yk1(1,1));
else
    k = x_block(xk(1,1), yk(1,1));
end

x1 = sort(x);
num_mid = numel(x1);
mid = mod(num_mid,2);
if(mid==0)
mid = num_mid/2;
k_ext = x(mid);
else
mid = floor(num_mid/2);

k_ext = floor(x(mid)+x(mid/2));
end

xx = 100*abs((k-k_ext)/k);

if(xx<20)
    k = k_ext;
end


end