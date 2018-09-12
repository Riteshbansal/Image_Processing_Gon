function mat2 = inv_stego_im2(im2,Mu,xlog1,ylog1,zlog1,k_5,k_6,k_7,k)

R = im2(:,:,1);
G = im2(:,:,2);
B = im2(:,:,3);

[LL,LH,HL,HH] = dwt2(B,'haar');
[LL1,LH1,HL1,HH1] = dwt2(G,'haar');
[LL2,LH2,HL2,HH2] = dwt2(R,'haar');
[xlog2,ylog2,zlog2] = keyset(LL,Mu,xlog1,ylog1,zlog1,k_5,k_6,k_7);
[xlog3,ylog3,zlog3] = keyset(LL,Mu,xlog1,ylog1,zlog1,k_7,k_5,k_6);
[xlog4,ylog4,zlog4] = keyset(LL,Mu,xlog1,ylog1,zlog1,k_6,k_7,k_5);


[row,col]=size(LL);

I_gr = 1:row;
I_row = confusion_impl2(I_gr,1,xlog2);
I_col = confusion_impl2(I_gr,1,ylog2);
I_col2 = confusion_impl2(I_gr,1,zlog2);

I_row_1 = confusion_impl2(I_gr,1,xlog3);
I_col_1 = confusion_impl2(I_gr,1,ylog3);
I_col2_1 = confusion_impl2(I_gr,1,zlog3);

I_row_2 = confusion_impl2(I_gr,1,xlog4);
I_col_2 = confusion_impl2(I_gr,1,ylog4);
I_col2_2 = confusion_impl2(I_gr,1,zlog4);

count = 1;
mat = zeros(k,1);
mat1 = zeros(k,1);
mat2 = zeros(k,1);

mat_1 = zeros(k,1);
mat1_1 = zeros(k,1);
mat2_1 = zeros(k,1);

mat_2 = zeros(k,1);
mat1_2 = zeros(k,1);
mat2_2 = zeros(k,1);




for i = 1:1:row
    for j = 1:1:col
        
        
        temp = HH(I_row(i),I_col(j));
        mat(count,1) = pix_mod_rev(temp);
        temp = HH1(I_col(i),I_col2(j));
        mat1(count,1) = pix_mod_rev(temp);
        temp = HH2(I_col2(i),I_row(j));
        mat2(count,1) = pix_mod_rev(temp);
        
        
        temp = HL(I_row_1(i),I_col_1(j));
        mat_1(count,1) = pix_mod_rev(temp);
        temp = HL1(I_col_1(i),I_col2_1(j));
        mat1_1(count,1) = pix_mod_rev(temp);
        temp = HL2(I_col2_1(i),I_row_1(j));
        mat2_1(count,1) = pix_mod_rev(temp);
        
        
        temp = LH(I_row_2(i),I_col_2(j));
        mat_2(count,1) = pix_mod_rev(temp);
        temp = LH1(I_col_2(i),I_col2_2(j));
        mat1_2(count,1) = pix_mod_rev(temp);
        temp = LH2(I_col2_2(i),I_row_2(j));
        mat2_2(count,1) = pix_mod_rev(temp);
        
        
        count = count+1;
        if(count>k)
            break;
        end
    end
    if(count>k)
        break;
        
    end
end

% [mat,mat_1,mat_2] = divide_3parts(s1);
% [mat1,mat1_1,mat1_2] = divide_3parts(s2);
% [mat2,mat2_1,mat2_2] = divide_3parts(s3);

mat = join_3parts(mat,mat_1,mat_2);
mat1 = join_3parts(mat1,mat1_1,mat1_2);
mat2 = join_3parts(mat2,mat2_1,mat2_2);


mat2 = join_3parts(mat,mat1,mat2);


end