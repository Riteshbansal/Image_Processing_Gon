clc
clear
% im = (imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/4.2.04.tiff'));
% % im = imresize(im,[1024,1024]);
% im1 = double((im));

im1 = double(imread('128_p.jpg'));
im = im1(:,:,3);
im2(:,:,:) = im1(:,:,:);

% data = 'ABCDEFABCDEFABCD';
% data = 'ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ';
fid=fopen('textprojectfile2.txt','r');
data=fread(fid);
A = double(int16(data'));
[comp1, comp, prob1] = huff_enc(A);
comp1 = mat_rev_diffussion4(comp1);

xsini(1,1)=0.1;
for i = 2:1:(numel(comp1))+2
    xsini(1,i) = mod(sin(pi * xsini(1,i-1)),1);
end
xsin = 1+floor(mod(xsini(3:end)*10^10,numel(comp1)));
comp1 = confusion_impl2(comp1,xsin,1);


comp1= comp1';
comp2 = zeros(1,64);
comp2(2:40) = comp1(1:39);
add_val = de2bi(numel(comp1),24,'left-msb');
comp2(41:64) = add_val(:,:);
mat1 = comp1(40:end);
rem = mod(numel(mat1),63);
mat2 = mat1(end-rem+1:end);
mat3 = mat1(1:(numel(mat1)-rem));
msg_block = numel(mat3)/63;
msg = zeros(msg_block+2,64);
msg(1,1:64) = comp2(:,:);
for i = 0:1:msg_block-1
    val1 = mat3((i*63)+1:(i*63)+63);
    msg(i+2,2:64) = val1(:,:);
end

add_val = [0,mat2, zeros(1,64-numel(mat2)-1-8),de2bi(64-numel(mat2)-1-8,8,'left-msb')];

msg(msg_block+2,1:64) = add_val(:,:);
msg = msg';
comp2 = msg(:)';
val = conf_n(comp2);

[LL,LH,HL,HH] = dwt2(im,'haar');
co = (LL(:,:));
p=8;
[r,c] = size(LL);
count = 0;
[m1,n1,z1] = size(val);
mode =1;
mode_val = numel(LL)/64;
rat = 1;
l=1;
count2=0;
for i = 1:p:r-p+1
    for j = 1:p:c-p+1
        matrix_gen = LL(i:i+p-1,j:j+p-1);
            val_v = (count2+1);
        [co(i:i+p-1,j:j+p-1),rat] = complexity_all(matrix_gen,val(:,:,val_v),mode);
        l=l+1;
        count = count+1;
        
        if(rat==-1)
            count =count-1;
        else
        count2=count2+1;
        end
        if(mod(l,mode_val)==0)
            mode = mode+1;
        end
        if(count>=z1&&rat==1)
            break;
        end
    end
    if(count>=z1&&rat==1)
        break;
    end
end
% im_10 = co;
[im_10] = idwt2(co,LH,HL,HH,'haar');


%% Inv

%Length Cal
[LL,LH,HL,HH] = dwt2(im_10,'haar');
co = zeros(8,8);
p=8;
[r,c] = size(LL);
count = 0;
mode =1;
rat =1;
for i = 1:p:r-p+1
    for j = 1:p:c-p+1
        matrix_gen = LL(i:i+p-1,j:j+p-1);
        [co(:,:),rat] = complexity_all_ex(matrix_gen,mode);
        count = count+1;
        if(rat==-1)
            count = count-1;
        end
        if(rat==1 && count>=1)
            break;
        end
    end
    if(rat==1 && count>=1)
        break;
    end
end
co = co(:)';
length_orignal = co(end-23:end);
length_orignal = bi2de(length_orignal,'left-msb');
totalval = 1+39+24;
mat1 = length_orignal-39;
rem = mod(mat1,63);
mat2 = rem;
mat3 = mat1-mat2;
msg_block = (mat3)/63;
msg_length = (msg_block+2)*64;
no_block = (msg_length)/64;
val_ex = zeros(8,8,no_block);

%% INFO EXTRACT
[LL,LH,HL,HH] = dwt2(im_10,'haar');
co = zeros(8,8);
p=8;
[r,c] = size(LL);
count = 0;
[m1,n1,z1] = size(val_ex);
mode = 1;
l=1;
count2=0;
for i = 1:p:r-p+1
    for j = 1:p:c-p+1
        matrix_gen = LL(i:i+p-1,j:j+p-1);
        [co(:,:),rat] = complexity_all_ex(matrix_gen,mode);
        l=l+1;
        if(mod(l,mode_val)==0)
            mode = mode+1;
        end
        count=count+1;
        if(rat==1)
            val_ex(:,:,count2+1) = co(:,:);
            count2=count2+1;
        else
            count=count-1;
        end
        if(count>=z1&&rat==1)
            break;
        end
    end
    if(count>=z1&&rat==1)
        break;
    end
end
mat = conf_n_rev(val_ex)';
mat = reshape(mat,[64,numel(mat)/64]);
mat = mat';
v1 = mat(1,2:40);
v2 = [];
for i = 1:1:(numel(mat)/64)-2
    v2 = [v2, mat(i+1,2:64)];
end
el = mat(numel(mat)/64,2:64);
ze = el(1,63-7:63);
ze = 63-bi2de(ze,'left-msb')-8;
v3 = el(1,1:ze);
ou = [v1,v2,v3];

xsini(1,1)=0.1;
for i = 2:1:(numel(ou))+2
    xsini(1,i) = mod(sin(pi * xsini(1,i-1)),1);
end
xsin = 1+floor(mod(xsini(3:end)*10^10,numel(ou)));
ou = confusion_impl_rev2(ou,1,xsin);

ou = mat_diffussion4(ou);

ou = huffmandeco(ou,comp);
dhsig=(ou);

dhsig = char(dhsig);
fid=fopen('TEXT_128_11kb.txt','w');
fwrite(fid,dhsig);

im_11= (im_10);

im2(:,:,3) = im_11(:,:);
psnr = PSNR_CAL(double(im1),double(im2));

[psnr1 mse1]=PSNRCal(im1,im2)
figure()
subplot(2,1,1),imshow(uint8(im1));
subplot(2,1,2),imshow(uint8(im2));
