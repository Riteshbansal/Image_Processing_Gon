function dec =  dec_newappr(enc_mg,xlog,ylog,mea,p)
[r,c]=size(enc_mg);
dec = zeros(size(enc_mg));
xlog_per_main = 1+floor(mod(xlog*10^6,r));
ylog_per_main = 1+floor(mod(ylog*10^6,c));

new_mat_fordec = confusion_impl_rev(enc_mg,xlog_per_main,ylog_per_main);


mat = [mea];
for i = 1:p:r-p+1
    for j = 1:p:c-p+1
        matrix_gen = new_mat_fordec(i:i+p-1,j:j+p-1);
        enc = matrix_diff(matrix_gen);
        mat = [mat,enc];
        
    end
end
mat = ceil(abs(mat));
mat (mat<=0) = 0;
count = numel(mat)-1;
for i = r-p+1:-p:1
    for j = c-p+1:-p:1     
        matrix_gen2 = new_mat_fordec(i:i+p-1,j:j+p-1);
        linker = decrypt_dwt(matrix_gen2,mat(count)+1,xlog(count));
        dec(i:i+p-1,j:j+p-1) = linker(:,:);
        count = count -1;
    end
end


end