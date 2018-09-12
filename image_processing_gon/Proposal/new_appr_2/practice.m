clc
clear all
src = '/Users/INNOCENTBOY/Documents/MATLAB/pic/512/4.2.04.tiff';
im = double(rgb2gray(imread(src)));




% count = 1;
% [xsin,xlog] = chaotic_map(0.6,512);
% xsin1 = 1+floor(mod(xsin(3:end)*10^6,255));
% xlog1 = 1+floor(mod(xlog(3:end)*10^6,255));
% xsin1 = reshape(xsin1,size(im,1),size(im,2))';
% xlog1 = reshape(xlog1,size(im,1),size(im,2))';
% % tic
% % im1 = mat_diffussion4(im);
% % im(1,1) = 0;
% % 
% % im2 = mat_diffussion4(im);
% % im1_dec = mat_rev_diffussion4(im1);

% im2 = mat_diffussion2(im,xsin1,xlog1,xlog(3:end));
% 
% % res = NPCR_and_UACI((((im1))),(((im2))),1,255);

% % % im = 1:16;
% % % im = reshape(im,4,4)';
% % % % % m1 = bin_arr(im);
% % % % % m2 = bin_arr_dec(m1,im);
% % p=2;
% % 
% % [xsin,xlog] = chaotic_map(0.6,p);
% % xsin = 1+floor(mod(xsin(3:end)*10^6,255));
% % xlog = 1+floor(mod(xlog(3:end)*10^6,255));
% % 
% % xsin = reshape(xsin,p,p)';
% % xlog = reshape(xlog,p,p)';
% % [r,c]=size(im);
% % new_mat = zeros(size(im));
% % mat_diff(:,:) = xlog(:,:);
% % tic
% % for i = 1:p:r-p+1
% %     for j = 1:p:c-p+1
% % 
% %         matrix_gen = im(i:i+p-1,j:j+p-1);
% %         [linker,mat_diff] = new_diff(matrix_gen,mat_diff);
% %         new_mat(i:i+p-1,j:j+p-1) = linker(:,:);
% %     end
% % end
% % toc
% % new_mat_Dec = zeros(size(new_mat));
% % mat_diff(:,:) = xlog(:,:);
% % 
% % for i = 1:p:r-p+1
% %     for j = 1:p:c-p+1
% % 
% %         matrix_gen = new_mat(i:i+p-1,j:j+p-1);
% %         [linker,mat_diff] = new_diff_reverse(matrix_gen,mat_diff);
% %         new_mat_Dec(i:i+p-1,j:j+p-1) = linker(:,:);
% %     end
% % end
