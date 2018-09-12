function [im2,k] = stego_im(im,comp1,Mu,xlog1,ylog1,zlog1,k_5,k_6,k_7)



[s1,s2,s3] = divide_3parts(comp1);
k = numel(s1);

R = im(:,:,1);
G = im(:,:,2);
B = im(:,:,3);
[LL,LH,HL,HH] = dwt2(B,'haar');
[LL1,LH1,HL1,HH1] = dwt2(G,'haar');
[LL2,LH2,HL2,HH2] = dwt2(R,'haar');
[xlog2,ylog2,zlog2] = keyset(LL,Mu,xlog1,ylog1,zlog1,k_5,k_6,k_7);


[row,col]=size(LL);


I_gr = 1:row;
I_row = confusion_impl2(I_gr,1,xlog2);
I_col = confusion_impl2(I_gr,1,ylog2);
I_col2 = confusion_impl2(I_gr,1,zlog2);

count = 1;
for i = 1:1:row
    for j = 1:1:col
        temp = HH(I_row(i),I_col(j));
        HH(I_row(i),I_col(j)) = pix_mod(temp,s1(count,1));
        temp = HH1(I_col(i),I_col2(j));
        HH1(I_col(i),I_col2(j)) = pix_mod(temp,s2(count,1));
        temp = HH2(I_col2(i),I_row(j));
        HH2(I_col2(i),I_row(j)) = pix_mod(temp,s3(count,1));
        count = count+1;
        if(count>k)
            break;
        end
    end
    if(count>k)
        break;
    end
end

[B] = idwt2(LL,LH,HL,HH,'haar');
[G] = idwt2(LL1,LH1,HL1,HH1,'haar');
[R] = idwt2(LL2,LH2,HL2,HH2,'haar');

im2 = cat(3,R,G,B);

end