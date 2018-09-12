clc
clear 
% close all

% im = (imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/4.2.04.tiff'));
% % im = imresize(im,[1024,1024]);
% im1 = double((im));

% imo = double(imread('256_p.jpg'));
imo = double(imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/4.1.01.tiff'));

im1(:,:,:) = imo(:,:,:);
im = im1(:,:,3);
im2(:,:,:) = im1(:,:,:);
% data = 'ABCDEFABCDEFABCD';
% data = 'ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ';
fid=fopen('textprojectfile1.txt','r');
data=fread(fid);
A = double(int16(data'));
% % si = size(imo);
% % % si = (si(1)*si(2))/8*(26/32);
% % si = (si(1)*si(2))/8*3;

% encr = (double(A(1:(si))));
encr = (double(A));

[comp1, comp, prob1] = huff_enc(encr);
rate = numel(comp1)/(numel(A)*8)
tic


% toc
siz_app= size(imo);
siz_app = (siz_app(1)*siz_app(2)*3)*8*(1/2);
% siz_app = (siz_app/8)*4;
if(numel(comp1)>=(siz_app))
    siz_enc = comp1(1:siz_app);
    siz_con = comp1(siz_app+1:end);
    comp1 = zeros(size(siz_enc));
    comp1(:,:) = siz_enc(:,:);
else
    siz_con=[];
end
[xlog1,ylog1,zlog1] = keyset(comp1);

comp1 = mat_diffussion4(comp1,xlog1,ylog1);


% % xsini(1,1)=0.1;
% % for i = 2:1:(numel(comp1))+2
% %     xsini(1,i) = mod(sin(pi * xsini(1,i-1)),1);
% % end
xsin = 1+floor(mod(zlog1*10^10,numel(comp1)));
comp1 = confusion_impl2(comp1,xsin,1);


comp1= comp1';
comp2 = zeros(1,64);

ev = 39;
if(numel(comp1)<39)
    ev =  numel(comp1);
end


comp2(2:ev+2-1) = comp1(1:ev);
add_val = de2bi(numel(comp1),24,'left-msb');
comp2(41:64) = add_val(:,:);
mat1 = comp1(40:end);
rem = mod(numel(mat1),63);
mat2 = mat1(end-rem+1:end);
mat3 = mat1(1:(numel(mat1)-rem));
msg_block = numel(mat3)/63;
if(numel(mat2)~=0)
    msg = zeros(msg_block+2,64);
else
    msg = zeros(msg_block+1,64);
end
msg(1,1:64) = comp2(:,:);

for i = 0:1:msg_block-1
    val1 = mat3((i*63)+1:(i*63)+63);
    msg(i+2,2:64) = val1(:,:);
end
if(numel(mat2)~=0)
    add_val = [0,mat2, zeros(1,64-numel(mat2)-1)];
    msg(msg_block+2,1:64) = add_val(:,:);
    %     end
end
msg = msg';
comp2 = msg(:)';
val = conf_n(comp2);

% [LL,LH,HL,HH] = dwt2(im,'haar');
co = (im(:,:));
p=8;
[r,c] = size(im);
count = 0;
[m1,n1,z1] = size(val);
mode_val = numel(im)/64;
rat = 1;
l=1;
count2=0;
plane =1;
dim=3;
co_o= (im1(:,:,:));
% co_o= (zeros(size(im)));
toc
p = 8;
while(plane<=8)
    while(dim>=1)
        for i = 1:p:r-p+1
            for j = 1:p:c-p+1
                matrix_gen = im(i:i+p-1,j:j+p-1);
                val_v = (count2+1);
                if(count2==14)
                   count; 
                end
                [co(i:i+p-1,j:j+p-1),rat] = complexity_all(matrix_gen,val(:,:,val_v),plane);
                l=l+1;
                count = count+1;
                
                if(rat==-1)
                    count =count-1;
                else
                    count2=count2+1;
                end
                %                 if(mod(l,mode_val)==0)
                %                     mode = mode+1;
                %                 end
                if(count>=z1)
                    break;
                end
            end
            if(count>=z1)
                break;
            end
        end
        
        co_o(:,:,dim) =co(:,:);
        if(count>=z1)
            break;
        end
        dim=dim-1;
        if(dim>=1)
            im(:,:) = im1(:,:,dim);
            co(:,:) = im(:,:);
        end
    end
    dim =3;
    if(count>=z1)
        break;
    end
    plane = plane+1;
    im1(:,:,:) = co_o(:,:,:);
    im(:,:) = im1(:,:,dim);
end
toc
im_10(:,:,:) = co_o(:,:,:);
% [im_10] = idwt2(co,LH,HL,HH,'haar');


% %% Inv
% 
% %Length Cal
% % [LL,LH,HL,HH] = dwt2(im_10,'haar');
% co = zeros(8,8);
% p=8;
% im_1_1 = im_10(:,:,3);
% [r,c] = size(im_1_1);
% count = 0;
% mode =1;
% rat =1;
% for i = 1:p:r-p+1
%     for j = 1:p:c-p+1
%         matrix_gen = im_1_1(i:i+p-1,j:j+p-1);
%         [co(:,:),rat] = complexity_all_ex(matrix_gen,mode);
%         count = count+1;
%         if(rat==-1)
%             count = count-1;
%         end
%         if(rat==1 && count>=1)
%             break;
%         end
%     end
%     if(rat==1 && count>=1)
%         break;
%     end
% end
% co = co(:)';
% length_orignal = co(end-23:end);
% length_orignal = bi2de(length_orignal,'left-msb');
% totalval = 64;
% mat1 = length_orignal-39;
% if(mat1>=1)
%     rem = mod(mat1,63);
%     mat2 = rem;
%     mat3 = mat1-mat2;
%     msg_block = (mat3)/63;
%     msg_length = (msg_block+2)*64;
%     no_block = (msg_length)/64;
%     val_ex = zeros(8,8,no_block);
% else
%     val_ex = zeros(8,8,1);
%     
% end
% 
% %% INFO EXTRACT
% % [LL,LH,HL,HH] = dwt2(im_10,'haar');
% co2 = zeros(8,8);
% p=8;
% [r,c] = size(im_1_1);
% count = 0;
% [m1,n1,z1] = size(val_ex);
% mode = 1;
% l=1;
% count2=0;
% dim =3;
% plane=1;
% while(plane <=8)
%     while(dim>=1)
%         for i = 1:p:r-p+1
%             for j = 1:p:c-p+1
%                 matrix_gen = im_1_1(i:i+p-1,j:j+p-1);
%                 if(count2==14)
%                    count; 
%                 end
%                 [co2(:,:),rat] = complexity_all_ex(matrix_gen,plane);
%                 l=l+1;
%                 %                 if(mod(l,mode_val)==0)
%                 %                     mode = mode+1;
%                 %                 end
%                 count=count+1;
%                 if(rat==1)
%                     val_ex(:,:,count2+1) = co2(:,:);
%                     count2=count2+1;
%                 else
%                     count=count-1;
%                 end
%                 if(count>=z1)
%                     break;
%                 end
%             end
%             if(count>=z1)
%                 break;
%             end
%         end
%         if(count>=z1)
%             break;
%         end
%         dim=dim-1;
%         if(dim>=1)
%             im_1_1(:,:) = im_10(:,:,dim);
%         end
%     end
%     dim =3;
%     if(count>=z1)
%         break;
%     end
%     plane = plane+1;
%     im_1_1(:,:) = im_10(:,:,dim);
% end
% mat = conf_n_rev(val_ex)';
% mat = reshape(mat,[64,numel(mat)/64]);
% mat = mat';
% if(length_orignal<39)
%     v1 = mat(1,2:length_orignal+1);
% else
%     v1 = mat(1,2:40);
%     
% end
% v2 = [];
% for i = 1:1:(numel(mat)/64)-2
%     v2 = [v2, mat(i+1,2:64)];
% end
% if(numel(mat)>64)
%     el = mat(numel(mat)/64,2:64);
%     ze = mod(length_orignal+24,63);
%     v3 = el(1,1:ze);
% else
%     v3=[];
% end
% ou = [v1,v2,v3];
% 
% % % xsini(1,1)=0.1;
% % % for i = 2:1:(numel(ou))+2
% % %     xsini(1,i) = mod(sin(pi * xsini(1,i-1)),1);
% % % end
% xsin = 1+floor(mod(zlog1*10^10,numel(ou)));
% ou = confusion_impl_rev2(ou,1,xsin);
% 
% % ou = mat_diffussion4(ou);
% % ou = [ou];
% ou = mat_rev_diffussion4(ou,xlog1,ylog1);
% ou = [ou,siz_con'];
% ou = huffmandeco(ou,comp);
% 
% dhsig=(ou);
% % dhsig = mat_diffussion4(dhsig);
% 
% dhsig = char(dhsig);
% fid=fopen('TEXT_128_11kb.txt','w');
% fwrite(fid,dhsig);

clearvars -except imo im_10 data siz_con comp1 plane val_ex val siz_app dim encr si count
entropy_orig = entropy(uint8(imo))
entropy_steg = entropy(uint8(im_10))
psnr = PSNR_CAL(uint8(imo),uint8(im_10))

% [psnr1 mse1]=PSNRCal(imo,im_10);
figure()
subplot(2,1,1),imshow(uint8(imo));
subplot(2,1,2),imshow(uint8(im_10));

[qs, qm, qmaps] = imageQualityIndex (imo, im_10);
qm
correl = corr2(imo(:),im_10(:))
% [M ,N,pll] = size(im_10);
% a2 = im_10(:,:,pll);
% % counttotal= 0;
% % while (pll>=1)
% im_1= zeros(M,N);
% im_2= zeros(M,N);
% im_3= zeros(M,N);
% im_4= zeros(M,N);
% im_5= zeros(M,N);
% im_6= zeros(M,N);
% im_7= zeros(M,N);
% im_8= zeros(M,N);

% a = pbc_to_cgc3(a);
% for j = 1:1:M
%     for k = 1:1:N
%         pix = a2(j,k);
%         pix_bin = de2bi(pix,8,'left-msb');
%         im_1(j,k) = pix_bin(8);
%         im_2(j,k) = pix_bin(7);
%         im_3(j,k) = pix_bin(6);
%         im_4(j,k) = pix_bin(5);
%         im_5(j,k) = pix_bin(4);
%         im_6(j,k) = pix_bin(3);
%         im_7(j,k) = pix_bin(2);
%         im_8(j,k) = pix_bin(1);
%     end
% end
% figure(), imshow(mat2gray(im_1))