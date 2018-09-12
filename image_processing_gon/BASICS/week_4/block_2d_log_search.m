clc
clear all
vidObj = VideoReader('/Users/INNOCENTBOY/Desktop/1.mp4');
vidObj.CurrentTime = 520;

frame1 = readFrame(vidObj);
frame2 = readFrame(vidObj);
frame2 = readFrame(vidObj);
frame2 = readFrame(vidObj);
frame2 = readFrame(vidObj);


p = 3;
blocksize = 8;


frame1 = double(rgb2gray(frame1));
frame2 = double(rgb2gray(frame2));

error = ones(3,3)*10^4;

%
tic
[row,col] = size(frame2);
%
vectors = zeros(4,(row*col)/(blocksize*blocksize));
%

Count = 1;
for i = 1:blocksize:row-blocksize+1
    for j = 1:blocksize:col-blocksize+1
        
        block_main = frame2(i:i+blocksize-1,j:j+blocksize-1);
        error = ones(3,3)*10^4;
        for k_row = -p:1:p
            for k_col = -p:1:p
                row_start = i+k_row;
                column_start = j+k_col;
                row_end = i+blocksize-1+k_row;
                column_end = j+blocksize-1+k_col;
                if ( row_start < 1 || row_end > row|| column_start < 1 || column_end > col)
                else
                    
                    row_start_ref = row_start;
                    column_start_ref = column_start;
                    row_end_ref = row_end+p-k_row;
                    column_end_ref = column_end+p-k_col;
                    if(row_end_ref>row)
                        row_end_ref=row;
                    end
                    if(column_end_ref>col)
                        column_end_ref=col;
                    end
                    break;
                end
            end
            if ( row_start < 1 || row_end > row|| column_start < 1 || column_end > col)
            else
                break;
            end
        end
        
        block_ref = frame1(row_start_ref:row_end_ref, column_start_ref:column_end_ref);
        [row_ref, col_ref] = size(block_ref);
        pix = block_main(floor(blocksize/2),floor(blocksize/2));
        
        [row1,col1] = size(block_ref);
        x1=ceil(row1/2);
        y1 = ceil(col1/2);
        error(:,:) = pix;
        k = ceil(log2(p));
        d = 2^k-1;
        min = find_min_2d(block_ref,error,d,x1,y1);
        x_main = i;
        y_main = j;
        
        x_ref = min(1,1)-(blocksize);
        if(x_ref>0)
            x_ref = row_start_ref+x_ref;
            
        else
            x_ref = row_start_ref;
        end
        
        y_ref = min(1,2)-(blocksize);
        if(y_ref>0)
            y_ref = column_start_ref+y_ref;
            
        else
            y_ref = column_start_ref;
            
        end
        
        %         x_ref = min(1,1)-ceil(blocksize/2);
        %         if(row_start_ref>x_ref)
        %             x_ref = row_start_ref;
        %         end
        %         y_ref = min(1,2)-ceil(blocksize/2);
        %          if(column_start_ref>y_ref)
        %             y_ref = column_start_ref;
        %         end
        
        
        vectors(1,Count) = x_main;
        vectors(2,Count) = y_main;
        vectors(3,Count) = x_ref;
        vectors(4,Count) = y_ref;
        Count = Count+1;
    end
end

toc
%
for Count=1:1:(row*col)/(blocksize*blocksize)
    x = vectors(3,Count);
    y = vectors(4,Count);
    x1 = vectors(1,Count);
    y1 = vectors(2,Count);
    im_cre(x1:x1+blocksize-1, y1:y1+blocksize-1) = frame1(x:x+blocksize-1, y:y+blocksize-1);
end
dd = frame1-im_cre;
imshow(mat2gray(frame1-im_cre));
