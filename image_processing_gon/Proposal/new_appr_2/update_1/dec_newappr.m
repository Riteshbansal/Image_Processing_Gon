function new_mat_dec =  dec_newappr(enc_mg,xlog,ylog,mea,p)
[r,c]=size(enc_mg);
xlog_per_main = 1+floor(mod(xlog*10^6,r));
ylog_per_main = 1+floor(mod(ylog*10^6,c));
new_mat_dec = zeros(size(enc_mg));
% enc_mg = xor_operation(enc_mg,mea);
[xsin,xlog1_ex] = chaotic_map(xlog(1),512);
xsin1 = 1+floor(mod(xsin(3:end)*10^6,255));
xlog1 = 1+floor(mod(xlog1_ex(3:end)*10^6,255));
xsin1 = reshape(xsin1,size(enc_mg,1),size(enc_mg,2))';
xlog1 = reshape(xlog1,size(enc_mg,1),size(enc_mg,2))';

% new_mat_fordec(:,:) = new_mat(:,:);
enc_mg = confusion_impl_rev(enc_mg,xlog_per_main,ylog_per_main);


% r_enc_dup_deci = abs(enc_mg-floor(enc_mg+0.000000000002));
% enc_mg = floor(enc_mg+0.000000000002);
% enc_mg = mat_rev_diffussion2(enc_mg,xsin1,xlog1,xlog1_ex(3:end));
% enc_mg = enc_mg+r_enc_dup_deci;


count =((r*c)/(p^2));
for i = r-p+1:-p:1
    for j = c-p+1:-p:1
        matrix_gen2 = enc_mg(i:i+p-1,j:j+p-1);
        linker = decrypt_dwt3(matrix_gen2,xlog(count),mea,xlog,ylog);
        new_mat_dec(i:i+p-1,j:j+p-1) = linker(:,:);
        count = count -1;
    end
end
% 

new_mat_dec = mat_rev_diffussion2(new_mat_dec,xsin1,xlog1,xlog1_ex(3:end));

end