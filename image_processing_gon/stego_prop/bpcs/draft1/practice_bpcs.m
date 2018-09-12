clc
clear
im1 = double(imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/4.2.04.tiff'));

% im1 = double(imread('256_p.jpg'));
im = im1(:,:,3);
im2(:,:,:) = im1(:,:,:);

data = 'ABCDEFABCDEFABCD';
A = double(int16(data));

% c=rl_enc(A);

[comp1, comp, prob1] = huff_enc(A);
comp1 = mat_rev_diffussion4(comp1);
comp1= comp1';
rem = 64-8-numel(comp1);
add_val = [ zeros(1,rem),de2bi(numel(comp1),8,'left-msb')];
comp2 = [comp1, add_val];
% n=8;
% val1 = mod(bsxfun(@plus,1:n,(1:n)'),2);
% comp2 = reshape(comp2,[8,8]);
% comp2 = bitxor(val1,comp2);
% comp2 = comp2(:)';

xsini(1,1)=0.1;
for i = 2:1:(numel(comp2))+2
    xsini(1,i) = mod(sin(pi * xsini(1,i-1)),1);
end

xsin = 1+floor(mod(xsini(3:end)*10^10,numel(comp2)));
comp2 = confusion_impl2(comp2,1,xsin);
val = reshape(comp2,[8,8]);


% val1 = confusion_impl2(val1(:)',1,xsin);
% val = reshape(val,[8,8]);
% val = val';
% comp3 = val(:);

[LL,LH,HL,HH] = dwt2(im,'haar');
co = (LL(:,:));
p=8;
[r,c] = size(LL);
count = 0;
l=1;
for i = 1:p:r-p+1
    for j = 1:p:c-p+1
        matrix_gen = LL(i:i+p-1,j:j+p-1);
        co(i:i+p-1,j:j+p-1) = complexity_all(matrix_gen,val);
        count = count+1;
        if(count>=l)
            break;
        end
    end
    if(count>=l)
        break;
    end
end
[im_10] = idwt2(co,LH,HL,HH,'haar');


%% Inv

[LL,LH,HL,HH] = dwt2(im_10,'haar');
co = zeros(8,8);
p=8;
[r,c] = size(LL);
count = 0;
for i = 1:p:r-p+1
    for j = 1:p:c-p+1
        matrix_gen = LL(i:i+p-1,j:j+p-1);
        co(i:i+p-1,j:j+p-1) = complexity_all_ex(matrix_gen);
        count = count+1;
        if(count>=l)
            break;
        end
    end
    if(count>=l)
        break;
    end
end

co= co(:)';
xsini(1,1)=0.1;
for i = 2:1:(numel(co))+2
    xsini(1,i) = mod(sin(pi * xsini(1,i-1)),1);
end
xsin = 1+floor(mod(xsini(3:end)*10^10,numel(co)));
co = confusion_impl_rev2(co,1,xsin);
co = reshape(co,[8,8]);
% n=8;
% val1 = mod(bsxfun(@plus,1:n,(1:n)'),2);
% co = bitxor(val1,co);
% co = co(:)';
num = co(end-7:end);
num = bi2de(num,'left-msb');
ou = co(1:num)';

ou = mat_diffussion4(ou);

ou = huffmandeco(ou,comp);
dhsig=(ou');

dhsig = char(dhsig);

im_11= (im_10);
im2(:,:,3) = im_11(:,:);
psnr = PSNR_CAL(double(im1),double(im2));



% [LL,LH,HL,HH] = dwt2(im_1,'haar');
% Mu = 3.99;
% xlog1= 20.1;
% ylog1= 22;
% zlog1= 19;
% k_5 = 34;
% k_6 = 40;
% k_7 = 36;
% [xlog2,ylog2,zlog2] = keyset(LL,Mu,xlog1,ylog1,zlog1,k_5,k_6,k_7);
% [row,col]=size(LL);
% I_gr = 1:row;
% I_row = confusion_impl2(I_gr,1,xlog2);
% I_col = confusion_impl2(I_gr,1,ylog2);
% 
% k = numel(comp1);
% 
% count = 1;
% for i = 1:1:row
%     for j = 1:1:col
%         temp = LL(I_row(i),I_col(j));
%         LL(I_row(i),I_col(j)) = pix_mod(temp,comp1(count,1));
%         count = count+1;
%         if(count>k)
%             break;
%         end
%     end
%     if(count>k)
%         break;
%     end
% end
% 
% [im_1_] = idwt2(LL,LH,HL,HH,'haar');
% im_10 = im_8*128 + im_7*64 +im_6*32+im_5*16+im_4*8+im_3*4+im_2*2+im_1*1;
% im_10 = im_8*128 + im_7*64 +im_6*32+im_5*16+im_4*8+im_3*4+im_2*2+im_1_*1;



