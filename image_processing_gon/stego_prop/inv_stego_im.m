function mat2 = inv_stego_im(im2,Mu,xlog1,ylog1,zlog1,k_5,k_6,k_7,k)

R = im2(:,:,1);
G = im2(:,:,2);
B = im2(:,:,3);

[LL,LH,HL,HH] = dwt2(B,'haar');
[LL1,LH1,HL1,HH1] = dwt2(G,'haar');
[LL2,LH2,HL2,HH2] = dwt2(R,'haar');
[xlog2,ylog2,zlog2] = keyset(HH,Mu,xlog1,ylog1,zlog1,k_5,k_6,k_7);

[row,col]=size(LL);


I_gr = 1:row;
I_row = confusion_impl2(I_gr,1,xlog2);
I_col = confusion_impl2(I_gr,1,ylog2);
I_col2 = confusion_impl2(I_gr,1,zlog2);

count = 1;
mat = zeros(k,1);
mat1 = zeros(k,1);
mat2 = zeros(k,1);
for i = 1:1:row
    for j = 1:1:col
        temp = HH(I_row(i),I_col(j));
        mat(count,1) = pix_mod_rev(temp);
        temp = HH1(I_col(i),I_col2(j));
        mat1(count,1) = pix_mod_rev(temp);
        temp = HH2(I_col2(i),I_row(j));
        mat2(count,1) = pix_mod_rev(temp);
        count = count+1;
        if(count>k)
            break;
        end
    end
    if(count>k)
        break;
        
    end
end


mat2 = join_3parts(mat,mat1,mat2);


end