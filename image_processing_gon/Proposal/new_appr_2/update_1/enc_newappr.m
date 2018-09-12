function new_mat =  enc_newappr(im,xlog,ylog,mea,p)
[r,c]=size(im);
new_mat = zeros(size(im));

count = 1;
[xsin,xlog1_ex] = chaotic_map(xlog(1),512);
xsin1 = 1+floor(mod(xsin(3:end)*10^6,255));
xlog1 = 1+floor(mod(xlog1_ex(3:end)*10^6,255));
xsin1 = reshape(xsin1,size(im,1),size(im,2))';
xlog1 = reshape(xlog1,size(im,1),size(im,2))';
enc(:,:) = im(:,:);
% mea = floor(mean2(im));
% enc (1,1) = bitxor(enc (1,1),mea);
tic
enc = mat_diffussion2(enc,xsin1,xlog1,xlog1_ex(3:end));

for i = 1:p:r-p+1
    for j = 1:p:c-p+1

        matrix_gen = enc(i:i+p-1,j:j+p-1);
        [linker] = encrypt_dwt3(matrix_gen,xlog(count),mea,xlog,ylog);
        new_mat(i:i+p-1,j:j+p-1) = linker(:,:);
        count = count+1;
    end
end
% 
% r_enc_dup_deci = abs(new_mat-floor(new_mat+0.000000000002));
% new_mat = floor(new_mat+0.000000000002);
% new_mat = mat_diffussion2(new_mat,xsin1,xlog1,xlog1_ex(3:end));
% new_mat = new_mat+r_enc_dup_deci;


xlog_per_main = 1+floor(mod(xlog*10^6,r));
ylog_per_main = 1+floor(mod(ylog*10^6,c));
new_mat = confusion_impl(new_mat,xlog_per_main,ylog_per_main);
% new_mat = xor_operation(new_mat,mea);
max_val = max(max(new_mat));
min_val = min(min(new_mat));

% if(max_val>255|| min_val<0)
    max_val
    min_val
% end

end