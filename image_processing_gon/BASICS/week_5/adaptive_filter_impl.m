clc
clear

im = (rgb2gray(imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/256/4.1.01.tiff')));
noisyRGB = imnoise(im,'salt & pepper', 0.05);

noisyRGB = double(noisyRGB);

h = ones(3,3);
h = h/9;
[row,col] = size(im);
im2 = zeros(row,col);
for i = 1:1:row
    for j = 1:1:col
        zz = noisyRGB(i,j);
        if(zz==0)
            zz;
        end
        str_row = i-1;
        end_row = i+1;
        if(str_row<=0)
            str_row = i;
            end_row = i+2;
        end
        
        if(end_row>row)
            str_row = row-2;
            end_row = row;
        end
        
        str_col = j-1;
        end_col = j+1;
        if(str_col<=0)
            str_col = i;
            end_col = i+2;
        end
        
        if(end_col>row)
            str_col = col-2;
            end_col = col;
        end
        x_block =  noisyRGB(str_row:end_row,str_col:end_col);
        n = numel(x_block);
        x_block_bar = x_block/n;
        sigma_var_xl = sum(sum((x_block-x_block_bar).^2));
        sigma_var_noise= sum(sum((h-(h/numel(h))).^2));
        k= (1-(sigma_var_noise/sigma_var_xl))*zz + (sigma_var_noise/sigma_var_xl)*(zz/n);
        im2(i,j) = k;

    end
end
redMF = medfilt2((noisyRGB), [3 3]);

figure
subplot(2, 2, 1),imshow(im);
subplot(2, 2, 2),imshow(uint8(noisyRGB));
subplot(2, 2, 3),imshow(uint8(im2));
subplot(2, 2, 4),imshow(uint8(redMF));

