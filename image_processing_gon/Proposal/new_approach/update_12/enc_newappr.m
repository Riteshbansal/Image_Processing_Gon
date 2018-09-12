function enc =  enc_newappr(im,xlog,ylog,mea,p)
[r,c]=size(im);

new_mat = zeros(size(im));
val = mea;
count = 1;
for i = 1:p:r-p+1
    for j = 1:p:c-p+1

        matrix_gen = im(i:i+p-1,j:j+p-1);
        [linker,val] = encrypt_dwt(matrix_gen,val,xlog(count));
        new_mat(i:i+p-1,j:j+p-1) = linker(:,:);
        count = count+1;
    end
end

xlog_per_main = 1+floor(mod(xlog*10^6,r));
ylog_per_main = 1+floor(mod(ylog*10^6,c));

enc = confusion_impl(new_mat,xlog_per_main,ylog_per_main);



end