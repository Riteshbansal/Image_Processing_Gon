clc
clear

im = (rgb2gray(imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/512/4.2.04.tiff')));
% noisyRGB = imnoise(im,'salt & pepper', 0.9);
noisyRGB = imnoise(im,'gaussian',0,0.05);
% noisyRGB = imnoise(im,'speckle',0.04);

noisyRGB = double(noisyRGB);
blocksize_row = 3;
blocksize_col = 3;

p_row = floor(blocksize_row/2);
p_col = floor(blocksize_col/2);

% h = h/9;
[row,col] = size(im);
im2 = zeros(row,col);
for i = 1:1:row
    for j = 1:1:col
        zz = noisyRGB(i,j);
        
        for k_row = -p_row:1:p_row
            for k_col = -p_col:1:p_col
                row_start = i+k_row;
                column_start = j+k_col;
                row_end = i+blocksize_row-1+k_row;
                column_end = j+blocksize_col-1+k_col;
                if ( row_start < 1 || row_start > row|| column_start < 1 || column_start > col)
                else
                    
                    row_start_ref = row_start;
                    column_start_ref = column_start;
                    row_end_ref = row_end;
                    column_end_ref = column_end;
                    
                    if(row_end_ref>row)
                        diff_1 = row_end_ref-row;
                        row_end_ref=row;
                        row_start_ref = row_start_ref-diff_1;
                    end
                    if(column_end_ref>col)
                        diff_1 = column_end_ref-col;
                        column_end_ref=col;
                        column_start_ref = column_start_ref-diff_1;
                    end
                    break;
                end
            end
            if ( row_start < 1 || row_end > row|| column_start < 1 || column_end > col)
            else
                break;
            end
        end
        
        
        x_block =  noisyRGB(row_start_ref:row_end_ref,column_start_ref:column_end_ref);
        [k m] = filter_cal3(x_block,zz);
        
        xx = 100*abs((k-zz)/k);
        count = 1;
        while(k==255||k==0 ||(xx>15&& xx <= 60) )
            if(row_end_ref>=row)
                row_start_ref= row_start_ref-1;
                
            else
                row_end_ref = row_end_ref+1;
            end
            
            if(column_end_ref>=col)
                column_start_ref= column_start_ref-1;
            else
                column_end_ref = column_end_ref+1;
            end
            x_block =  noisyRGB(row_start_ref:row_end_ref,column_start_ref:column_end_ref);
            [k,m] = filter_cal3(x_block,zz);
            xx = 100*abs((k-zz)/k);
            count = count+1;
            if(count>5)
                break;
            end
        end
        %                 xx = 100*abs((k-zz)/k);
        %
        %                 if(xx<25)
        %                     k = zz;
        %                 end
        %         if(xx>50 && xx<70)
        %             k = zz;
        %         end
        %         if(xx<-2 || xx>2)
        %             k;
        %         end
        
%         k = floor(1-(((m-k)/(zz-k)).^2)*k + (((m-k)/(zz-k)).^2)*zz);
        if(k==255)
            k;
        end
        im2(i,j) = k;
        
    end
end

% redMF = medfilt2((noisyRGB), [3 3]);
redMF = imgaussfilt((noisyRGB), [3 3]);


figure
subplot(2, 2, 1),imshow(im);
subplot(2, 2, 2),imshow(uint8(noisyRGB));
subplot(2, 2, 3),imshow(uint8(im2));
subplot(2, 2, 4),imshow(uint8(redMF));

PSNR1 = sum(sum(((double(im2)  -double(im)).*(double(im2)  -double(im)))));
PSNR1 = PSNR1/(row*col);

PSNR2 = sum(sum(((redMF-double(im)).*(redMF-double(im)))));
PSNR2 = PSNR2/(row*col);


