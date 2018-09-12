function new_mat=enc_newappr(im,chaotic)
% [r,c]=size(im);
% new_mat = zeros(size(im));

% count = 1;

% chaotic = {xlog,ylog,zlog,mea,xsin,xlogarith,xsin_2,xlogarith_2, ...
%                         xlog_per_main,ylog_per_main ,xlog1,xsin1,xlog1_ex,p};

xlog = chaotic{1};
ylog = chaotic{2};
zlog = chaotic{3};
mea = chaotic{4};
xsin = chaotic{5};
xlogarith = chaotic{6};
xsin_2 = chaotic{7};
xlogarith_2 = chaotic{8};
xlog_per_main = chaotic{9};
ylog_per_main = chaotic{10};
xlog1 = chaotic{11};
xsin1 = chaotic{12};
xlog1_ex = chaotic{13};
p = chaotic{14};


new_mat = im;
% toc
% enc(:,:) = im(:,:);
% mea = floor(mean2(im));
% enc (1,1) = bitxor(enc (1,1),mea);

new_mat = mat_diffussion2(new_mat,xsin1,xlog1,xlog1_ex(3:end),xsin_2,xlogarith_2);
% tic
% new_mat = mat_diffussion6(new_mat);
% new_mat = mat_diffussion4(new_mat);

% toc

% for i = 1:p:r-p+1
%     for j = 1:p:c-p+1
%         matrix_gen = enc(i:i+p-1,j:j+p-1);
%         [linker] = encrypt_dwt3(matrix_gen,xlog(count),mea,xlog,ylog);
%         new_mat(i:i+p-1,j:j+p-1) = linker(:,:);
%         count = count+1;
%     end
% end
% tic
[new_mat] = encrypt_dwt3(new_mat,mea,xsin,xlogarith,xlog,ylog);
% toc


%
% r_enc_dup_deci = abs(new_mat-floor(new_mat+0.000000000002));
% new_mat = floor(new_mat+0.000000000002);
% new_mat = mat_diffussion2(new_mat,xsin1,xlog1,xlog1_ex(3:end));
% new_mat = new_mat+r_enc_dup_deci;



% new_mat = confusion_impl(new_mat,xlog_per_main,ylog_per_main);

% new_mat = xor_operation(new_mat,mea);
% max_val = max(max(new_mat));
% min_val = min(min(new_mat));
% 
% % % if(max_val>255|| min_val<0)
%     max_val
%     min_val
% % % end

end