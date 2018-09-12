clc
clear all
close all

im = (rgb2gray(imread('/Users/INNOCENTBOY/Downloads/videos/Imageprocessing/week6/original_cameraman.jpg')));

Mu=3.999; % Parameter of map
xlog1= 20;
ylog1= 22;
zlog1= 19;
k_5 = 316;
k_6 = 160;
k_7 = 36;
for k=2:512+2
    xlog1(1,k)=mod(Mu*k_5*ylog1(1,k-1)*(1-xlog1(1,k-1)+zlog1(1,k-1)),1);
    ylog1(1,k)=mod(Mu*k_6*ylog1(1,k-1)+zlog1(1,k-1)*1/(1+(xlog1(1,k-1)^2)),1);
    zlog1(1,k)=mod(Mu*(xlog1(1,k-1)+ylog1(1,k-1)+k_7)*sin(zlog1(1,k-1)),1);
end

xlog = xlog1(1,3:end);
ylog = ylog1(1,3:end);
zlog = zlog1(1,3:end);



clearvars -except xlog zlog ylog

xlog_per = 1+floor(mod(xlog*10^6,8));
ylog_per = 1+floor(mod(ylog*10^6,8));


im =double (rgb2gray(imread('/Users/INNOCENTBOY/Downloads/videos/Imageprocessing/week6/original_cameraman.jpg')));
% im = double(imresize(im1,[256,256]));
% im = 1:256;
% im = reshape(im,16,16)';
tic
%% ENC
[r,c]=size(im);
new_mat = zeros(size(im));
pix = [0];
val = 0;
for i = 1:16:r-16+1
    for j = 1:16:c-16+1
        if(i==305 && j==241)
           val; 
        end
        matrix_gen = im(i:i+16-1,j:j+16-1);
        linker = encrypt_dwt(matrix_gen,xlog_per,ylog_per,val);
        val = linker(16,16);
        pix = [pix, linker(16,16)];
        new_mat(i:i+16-1,j:j+16-1) = linker(:,:);
    end
end

xlog_per_main = 1+floor(mod(xlog*10^6,r));
ylog_per_main = 1+floor(mod(ylog*10^6,c));

new_mat = confusion_impl(new_mat,xlog_per_main,ylog_per_main);
toc


%% ENC 2
[r,c]=size(im);
new_mat_2 = zeros(size(im));
pix = [0];
val = 0;
im(1,1) = im(1,1)+1;
for i = 1:16:r-16+1
    for j = 1:16:c-16+1
        if(i==305 && j==241)
           val; 
        end
        matrix_gen = im(i:i+16-1,j:j+16-1);
        linker = encrypt_dwt(matrix_gen,xlog_per,ylog_per,val);
        val = linker(16,16);
        pix = [pix, linker(16,16)];
        new_mat_2(i:i+16-1,j:j+16-1) = linker(:,:);
    end
end

xlog_per_main = 1+floor(mod(xlog*10^6,r));
ylog_per_main = 1+floor(mod(ylog*10^6,c));

new_mat_2 = confusion_impl(new_mat_2,xlog_per_main,ylog_per_main);
toc

%% DEC

[r,c]=size(im);
new_mat_dec = zeros(size(im));
new_mat_fordec = confusion_impl_rev(new_mat,xlog_per_main,ylog_per_main);
pix2 = [];
for i = r-16+1:-16:1
    for j = c-16+1:-16:1
         if(i==497 && j==337)
           val; 
        end
        if(j-1 <=0 && i ==1)
            pix2= [pix2 255];
            val = 255;
        else
            if(j-1<=0)
                pix2 =[pix2, new_mat_fordec(i-1,c)];
                val = new_mat_fordec(i-1,c);
                
            else
                pix2 =[pix2, new_mat_fordec(i+16-1,j-1)];
                val = new_mat_fordec(i+16-1,j-1);
            end
        end
        matrix_gen2 = new_mat_fordec(i:i+16-1,j:j+16-1);
        linker = decrypt_dwt(matrix_gen2,xlog_per,ylog_per,val);
        new_mat_dec(i:i+16-1,j:j+16-1) = linker(:,:);
    end
end
new_mat_dec = floor(new_mat_dec);
[x,y] = corelation(im,floor(abs(new_mat)));

res = NPCR_and_UACI(floor(abs(new_mat)),floor(abs(new_mat_2)),1,255);
