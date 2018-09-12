clc
clear

image = (rgb2gray(imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/512/4.2.04.tiff')));
% image = imresize(image,[128,128]);

% noisyRGB = imnoise(image,'gaussian');
noisyRGB = imnoise(noisyRGB,'salt & pepper', 0.2);

% noisyRGB = imnoise(image,'speckle',0.04);
im(:,:) =double( noisyRGB(:,:));
noisyRGB = double(noisyRGB);
blocksize_row = 2;
blocksize_col = 2;

p_row = floor(blocksize_row/2);
p_col = floor(blocksize_col/2);

% h = h/9;
[row,col] = size(image);
im2 = zeros(row,col);
count_repl = 2;
while(count_repl >1)
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
            x_block =  im(row_start_ref:row_end_ref,column_start_ref:column_end_ref);
            k = filter_cal5(x_block,zz);
            xx = 100*abs((k-zz)/k);
            count = 1;
            %             while(k==255||k==0)
            while(k==255||k==0 ||(xx>=35 && xx <= 60))
                
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
                x_block =  im(row_start_ref:row_end_ref,column_start_ref:column_end_ref);
                k = filter_cal5(x_block,zz);
                xx = 100*abs((k-zz)/k);
                count = count+1;
                if(count>5)
                    break;
                end
            end
                        xx = 100*abs((k-zz)/zz);
            
                        if(xx<=15)
                            k = zz;
                        end
            %             if(xx>15 && xx<50)
            %                 k ;
            %             end
            %             if(xx<-2 || xx>2)
            %                 k;
            %             end
            
            %             if(k==255)
            %                 k;
            %             end
            im2(i,j) = k;
            
        end
    end
    count_repl = count_repl-1;
    im(:,:) = im2(:,:);
end

%% Inbuilt filter

redMF = medfilt2((noisyRGB), [2 2]);
% redMF = medfilt2((redMF), [3 3]);

% redMF = imgaussfilt((redMF), [3 3]);

% im2 = imfilter(im2, (1/9)*ones(3, 3), 'symmetric');

%% PSNR
kk = double(im2)  -double(image);
MSE1 = sum(sum(((double(im2)  -double(image)).*(double(im2)  -double(image)))));
PSNR1 = MSE1/(row*col);

MSE2 = sum(sum(((redMF-double(image)).*(redMF-double(image)))));
PSNR2 = MSE2/(row*col);

%% Image_shrpening
% h=(1/9)*ones(3, 3);
% x_low = imfilter(image, h, 'symmetric');
% y_mask = image - x_low;
% a =2;
% y_main = image+ a*y_mask;

%% Plotting
figure
subplot(2, 3, 1),imshow(image);
subplot(2, 3, 2),imshow(uint8(noisyRGB));
subplot(2, 3, 3),imshow(uint8(im2));
subplot(2, 3, 4),imshow(uint8(redMF));
% subplot(2, 3, 5),imshow(uint8(y_main));

