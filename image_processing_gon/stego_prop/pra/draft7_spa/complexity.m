function [comp,E] = complexity(a)

hig_comp = 420;
% hig_comp = 224;
% n=8;
% a = mod(bsxfun(@plus,1:n,(1:n)'),2);
% a = ones(8,8);
% a(:,2) = 0;
% a(:,4) = 0;
% a(:,6) = 0;
% a(:,8) = 0;
% 
% a(:,6) = 0;
% a(6,:) = 0;
% a(6,6) = 1;

% a(1,3) = 0;a(1,6)=1;
% a(2,2) = 0;a(2,5)=1;a(2,8)=1;
% a(3,1) = 0;a(3,4)=1;a(3,7)=1;
% a(3,1) = 0;a(3,4)=1;a(3,7)=1;
% a(4,3) = 0;a(4,6)=1;
% a(5,3) = 0;a(5,6)=1;
% a(6,2) = 0;a(6,5)=1;a(6,8)=1;
% a(7,2) = 0;a(7,5)=1;a(7,8)=1;
% a(8,1) = 0;a(8,4)=1;a(8,7)=1;


% a = zeros(8,8);
% a(1,1) = 1;a(1,2)=1;
% a(2,2) = 1;a(2,4)=1;
% a(3,1) = 1;a(3,2) = 1;a(3,4)=1;
% a(4,1) = 1;a(4,3) = 1;a(4,5)=1;
% a(5,1) = 1;a(5,2) = 1;a(5,4)=1;
% a(6,2) = 1;a(6,4)=1;
% a(7,1) = 1;a(7,3:5)=1;
% a(8,2:3) = 1;a(8,5)=1;
% 

% a = ones(8,8);
% a(:,3) = 0;
% a(:,7) = 0;
% [comp2] = bpcs_comp(a);
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
% [k1,k2] = meshgrid(1:8,1:8);

% figure(),mesh(k1,k2,cor);

% figure(1)
% surfc(k2, k1, cor)
% % xlabel('X axis');
% % ylabel('Y axis');
% % zlabel('Z axis');
% 
% xlabel('Complexity along Row')
% ylabel('Complexity along Columns')
% zlabel('Pixel Complexity')
% title('Complexity Analysis of Block')
% 
% axis tight
% grid on
% shading interp
% set(gcf, 'Render', 'Zbuffer')
% ch = colorbar;
% set(ch, 'FontSize', 10)
% ylabel(ch, 'Pixel Complexity Range') 
% colormap jet
% alpha(0.7)

G =  histogram_personal(cor);
p = G(2,:);
% p1 = G(1,:);
E = -sum(p.*log2(p));

% cor2(:,:) = cor(:,:);
% cor2(cor2<=4)=0;
% sumcor = sum(sum(cor2));
% if(comp>1)
%     comp;
% end
end