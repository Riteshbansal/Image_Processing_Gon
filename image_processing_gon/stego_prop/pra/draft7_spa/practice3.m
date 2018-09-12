clc
% clear
% % a = double(rgb2gray(imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/4.2.04.tiff')));
% im = double((imread('64_p.jpg')));

% a = imo(:,:,3);
[M ,N,pll] = size(im_10);
a = im_10(:,:,pll);
counttotal= 0;
% while (pll>=1)
im_1= zeros(M,N);
im_2= zeros(M,N);
im_3= zeros(M,N);
im_4= zeros(M,N);
im_5= zeros(M,N);
im_6= zeros(M,N);
im_7= zeros(M,N);
im_8= zeros(M,N);

% a = pbc_to_cgc(a);
for j = 1:1:M
    for k = 1:1:N
        pix = a(j,k);
        pix_bin = de2bi(pix,8,'left-msb');
        im_1(j,k) = pix_bin(8);
        im_2(j,k) = pix_bin(7);
        im_3(j,k) = pix_bin(6);
        im_4(j,k) = pix_bin(5);
        im_5(j,k) = pix_bin(4);
        im_6(j,k) = pix_bin(3);
        im_7(j,k) = pix_bin(2);
        im_8(j,k) = pix_bin(1);
    end
end

[r,c] = size(im_1);
p=8;
G = ones(r/8,16);
count = 1;
for i = 1:p:r-p+1
    for j = 1:p:c-p+1
        matrix_gen = im_1(i:i+p-1,j:j+p-1);
        [G(count,1),G(count,2)] = complexity(matrix_gen);
        if(G(count,1)>0.42 && G(count,2)>=2.3)
            counttotal= counttotal+1;
        end
        count = count +1;
    end
end

count = 1;
for i = 1:p:r-p+1
    for j = 1:p:c-p+1
        matrix_gen = im_2(i:i+p-1,j:j+p-1);
        [G(count,3),G(count,4)] = complexity(matrix_gen);
        if(G(count,4)>0.42 && G(count,4)>=2.3)
            counttotal= counttotal+1;
        end
        count = count +1;
    end
end

count = 1;
for i = 1:p:r-p+1
    for j = 1:p:c-p+1
        matrix_gen = im_3(i:i+p-1,j:j+p-1);
        [G(count,5),G(count,6)] = complexity(matrix_gen);
        if(G(count,5)>0.42 && G(count,6)>=2.3)
            counttotal= counttotal+1;
        end
        count = count +1;
    end
end
count = 1;
for i = 1:p:r-p+1
    for j = 1:p:c-p+1
        matrix_gen = im_4(i:i+p-1,j:j+p-1);
        [G(count,7),G(count,8)] = complexity(matrix_gen);
        if(G(count,7)>0.42 && G(count,8)>=2.3)
            counttotal= counttotal+1;
        end
        count = count +1;
    end
end
count = 1;
for i = 1:p:r-p+1
    for j = 1:p:c-p+1
        matrix_gen = im_5(i:i+p-1,j:j+p-1);
        [G(count,9),G(count,10)] = complexity(matrix_gen);
        if(G(count,9)>0.42 && G(count,10)>=2.3)
            counttotal= counttotal+1;
        end
        count = count +1;
    end
end
count = 1;
for i = 1:p:r-p+1
    for j = 1:p:c-p+1
        matrix_gen = im_6(i:i+p-1,j:j+p-1);
        [G(count,11),G(count,12)] = complexity(matrix_gen);
        if(G(count,11)>0.42 && G(count,12)>=2.3)
            counttotal= counttotal+1;
        end
        count = count +1;
    end
end

count = 1;
for i = 1:p:r-p+1
    for j = 1:p:c-p+1
        matrix_gen = im_7(i:i+p-1,j:j+p-1);
        [G(count,13),G(count,14)] = complexity(matrix_gen);
        if(G(count,13)>0.42 && G(count,14)>=2.3)
            counttotal= counttotal+1;
        end
        count = count +1;
    end
end
count = 1;
for i = 1:p:r-p+1
    for j = 1:p:c-p+1
        matrix_gen = im_8(i:i+p-1,j:j+p-1);
        [G(count,15),G(count,16)] = complexity(matrix_gen);
        if(G(count,15)>0.42 && G(count,16)>=2.3)
            counttotal= counttotal+1;
        end
        count = count +1;
    end
end
% m = mean(G(:,1))
% s = std(G(:,1))
% m1 = mean(G(:,2))
% s1 = std(G(:,2))
% x=1:(r*c)/64;
% figure()
% subplot(2,1,1),plot(sort(G(:,1)),x,sort(G(:,3)),x,sort(G(:,5)),x,sort(G(:,7)),x,sort(G(:,9)),x,sort(G(:,11)),x,sort(G(:,13)),x,sort(G(:,15)),x);
% legend('Bit plane 0','Bit plane 1','Bit plane 2','Bit plane 3','Bit plane 4','Bit plane 5','Bit plane 6','Bit plane 7');
% xlim([0,1]);
% xlabel('Complexity - \alpha')
% ylabel('No of Blocks in Plane')
% title('Complexity Plane Graph')
% subplot(2,1,2),plot(sort(G(:,2)),x,sort(G(:,4)),x,sort(G(:,6)),x,sort(G(:,8)),x,sort(G(:,10)),x,sort(G(:,12)),x,sort(G(:,14)),x,sort(G(:,16)),x);
% legend('Bit plane 0','Bit plane 1','Bit plane 2','Bit plane 3','Bit plane 4','Bit plane 5','Bit plane 6','Bit plane 7');
% xlim([0,4]);
% xlabel('Entropy - E')
% ylabel('No of Blocks in Plane')
% title('Entropy Plane Graph')
% pll = pll-1;
% if(pll>=1)
% a = im(:,:,pll);
% end
% end
histogram_personal2(G(:,1))

counttotal = counttotal*p*p;

% % 
% % p=8;
% % G = ones(r/8,4);
% % count = 1;
% % for i = 1:p:r-p+1
% %     for j = 1:p:c-p+1
% %         matrix_gen = im_8(i:i+p-1,j:j+p-1);
% %         [G(count,1),G(count,2)] = complexity(conj_n(matrix_gen));
% %         gg1 =G(count,1);
% %         gg2 = G(count,2);
% %         if(G(count,1)>0.55 || G(count,2)>2.7)
% %            count; 
% %         end
% %         count = count +1;
% %     end
% % end
% % count = 1;
% % for i = 1:p:r-p+1
% %     for j = 1:p:c-p+1
% %         matrix_gen = im_8(i:i+p-1,j:j+p-1);
% %         [G(count,3),G(count,4)] = complexity((matrix_gen));
% %         count = count +1;
% %     end
% % end
% % 
% % x=1:(r*c)/64;
% % figure()
% % subplot(2,1,1),plot(sort(G(:,1)),x,sort(G(:,3)),x);
% % legend('Bit plane 7 Conjugate','Bit plane 7-Non Conjugate');
% % xlim([0,1]);
% % xlabel('Complexity - \alpha')
% % ylabel('No of Blocks in Plane')
% % title('Complexity Plane Graph')
% % subplot(2,1,2),plot(sort(G(:,2)),x,sort(G(:,4)),x);
% % legend('Bit plane 7 Conjugate','Bit plane 7-Non Conjugate');
% % xlim([0,4]);
% % xlabel('Entropy - E')
% % ylabel('No of Blocks in Plane')
% % title('Entropy Plane Graph')



% comp = [0,1,1,0,0,0,0,0;0,0,0,0,0,0,0,1;0,0,0,1,1,0,0,1;1,0,0,1,0,0,0,0;1,0,0,0,1,0,0,1;0,0,1,0,0,0,0,0;0,1,1,0,0,0,0,1;1,0,0,1,1,0,0,1];
% 
% % comp1 = 1:64;
% % comp = ones(8,8);
% % comp(5,5) = 1;
% 
% a = ones(8,8);
% a(5,:) = 0;
% a(6,:) = 0;
% a(7,:) = 0;
% a(8,:) = 0;
% xsini(1,1)=0.42;
% for i = 2:1:(numel(a))+2
%     xsini(1,i) = mod(sin(pi * xsini(1,i-1)),1);
% end
% xsin = 1+floor(mod(xsini(3:end)*10^10,numel(a)));
% xsin_2 = mod(xsin,2);
% xsin_2 = reshape(xsin_2,[8,8]);
% ss = confusion_impl2((1:64)',xsin,1);
% comp1 = confusion_impl2(a(:),ss,1);
% a = reshape(comp1,[8,8]);
% a(1,1)=0;
% [complex1,E] = complexity(a);
% [complex2,E2] = complexity(bitxor(a,comp));

% % % 
% % % Mu = 3.99;
% % % xlog1= 20.1;
% % % ylog1= 22;
% % % zlog1= 19;
% % % k_5 = 34;
% % % k_6 = 40;
% % % k_7 = 36;
% % % for k=2:8+2
% % %     xlog1(1,k)=mod(Mu*k_5*ylog1(1,k-1)*(1-xlog1(1,k-1)+zlog1(1,k-1)),1);
% % %     ylog1(1,k)=mod(Mu*k_6*ylog1(1,k-1)+zlog1(1,k-1)*1/(1+(xlog1(1,k-1)^2)),1);
% % %     zlog1(1,k)=mod(Mu*(xlog1(1,k-1)+ylog1(1,k-1)+k_7)*sin(zlog1(1,k-1)),1);
% % % end
% % % 
% % % xlog = xlog1(1,3:end);
% % % ylog = ylog1(1,3:end);
% % % zlog = zlog1(1,3:end);
% % % xlog1 = 1+floor(mod(xlog(1:8)*10^6,8));
% % % ylog1 = 1+floor(mod(ylog(1:8)*10^6,8));
% % % zlog1 = 1+floor(mod(zlog(1:8)*10^6,8));
% % % 
% % % I_gr = 1:8;
% % % I_row = confusion_impl2(I_gr,1,xlog1);
% % % I_col = confusion_impl2(I_gr,1,ylog1);
% % % I_col2 = confusion_impl2(I_gr,1,zlog1);
% % % % 
% n=8;
% val1 = mod(bsxfun(@plus,1:n,(1:n)'),2);
% 
% % m = bitxor(a,comp);





% y = reshape(comp1, [8,8])';













% % comp2 = zeros(1,64);
% % comp2(2:40) = comp1(1:39);
% % add_val = de2bi(numel(comp1),24,'left-msb');
% % comp2(41:64) = add_val(:,:);
% % mat1 = comp1(40:end);
% % rem = mod(numel(mat1),63);
% % mat2 = mat1(end-rem+1:end);
% % mat3 = mat1(1:(numel(mat1)-rem));
% % msg_block = numel(mat3)/63;
% % msg = zeros(msg_block+2,64);
% % msg(1,1:64) = comp2(:,:);
% % for i = 0:1:msg_block-1
% %     val1 = mat3((i*63)+1:(i*63)+63);
% %     msg(i+2,2:64) = val1(:,:);
% % end
% % add_val = [0,mat2, zeros(1,64-numel(mat2)-1-8),de2bi(64-numel(mat2)-1-8,8,'left-msb')];
% % msg(msg_block+2,1:64) = add_val(:,:);
% % msg = msg';
% % co = msg(:)';
% % mat = reshape(co,[64,numel(co)/64])';
% % 
% % v1 = mat(1,2:40);
% % v2 = [];
% % for i = 1:1:(numel(co)/64)-2
% % v2 = [v2, mat(i+1,2:64)];
% % end
% % el = mat(numel(co)/64,2:64);
% % ze = el(1,63-7:63);
% % ze = 63-bi2de(ze,'left-msb')-8;
% % v3 = el(1,1:ze);
% % co = [v1,v2,v3];
% % 
% % 









% 
% num = comp2(end-23:end);
% num = bi2de(num,'left-msb');
% totalval = 1+39+24; 
% mat1 = num-39;
% rem = mod(mat1,63);
% mat2 = rem;
% mat3 = mat1-mat2;
% msg_block = (mat3)/63;
% msg = (msg_block+2)*64;
% 











% % if(numel(comp1)<=64)
% %     if(numel(comp1)==64)
% %         comp2 = comp1;
% %     else
% %         rem = 64-8-numel(comp1);
% %         add_val = [ zeros(1,rem),de2bi(numel(comp1),8,'left-msb')];
% %         comp2 = [comp1, add_val];
% %     end
% % else
% %     comp2 = zeros(1,numel(comp1)+24);
% %     comp2(1:40) = comp1(1:40);
% %     add_val = de2bi(numel(comp1),24,'left-msb');
% %     comp2(41:64) = add_val(:,:);
% %     comp2(65:end) = comp1(41:end);
% %     comp1 =  comp2(:,:);
% %     rem = mod(numel(comp1),64);
% %     add_val = [ zeros(1,64-rem-8),de2bi(64-rem-8,8,'left-msb')];
% %     mat1 = [comp1(end-rem+1:end), add_val];
% %     comp3 = comp1(1:(numel(comp1)-rem));
% %     comp2 = [comp3,mat1];
% % end