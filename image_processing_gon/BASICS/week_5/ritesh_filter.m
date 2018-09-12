clc
clear

im = (rgb2gray(imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/256/4.1.01.tiff')));
noisyRGB = imnoise(im,'gaussian');

noisyRGB = double(noisyRGB);

h = ones(3,3);
% h = h/9;
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
        x = x_block(:);
        x = floor(mean2(x));
        
        h(:,:) = x;
        y = x_block- h;
        y = abs(y);
        %                y1 = y(:);
        %                y1 = floor(mean2(y1));
        %                y = y1-y;
        %                 y = abs(y);
        [xk,yk] = find(y==min(y(:)));
%         [x_min, y_min] = minCost(y);
        
        k = x_block(xk(1,1), yk(1,1));
        if(k==255)
            k;
        end
        im2(i,j) = k;
        %         n = numel(x_block);
        %         x_block_bar = x_block/n;
        %         var_xl = sum(sum((x_block-x_block_bar).^2));
    end
end

redMF = medfilt2((noisyRGB), [3 3]);

figure
subplot(2, 2, 1),imshow(im);
subplot(2, 2, 2),imshow(uint8(noisyRGB));
subplot(2, 2, 3),imshow(uint8(im2));
subplot(2, 2, 4),imshow(uint8(redMF));

