clc
clear all
vidObj = VideoReader('/Users/INNOCENTBOY/Desktop/1.mp4');
vidObj.CurrentTime = 520;

frame1 = readFrame(vidObj);
frame2 = readFrame(vidObj);
frame2 = readFrame(vidObj);
frame2 = readFrame(vidObj);
frame2 = readFrame(vidObj);


p = 10;
blocksize = 16;


frame1 = double(rgb2gray(frame1));
frame2 = double(rgb2gray(frame2));



[row col] = size(frame1);

vectors = zeros(2,row*col/blocksize^2);
error = ones(3, 3) * 10^4;


L = floor(log10(p+1)/log10(2));
d = 2^(L-1);
mbCount = 1;
for i = 1 : blocksize : row-blocksize+1
    for j = 1 : blocksize : col-blocksize+1
        
        x = j;
        y = i;
        block_main = frame2(i:i+blocksize-1,j:j+blocksize-1);
        block_ref = frame1(i:i+blocksize-1,j:j+blocksize-1);
        error(2,2) = Erro_cal(block_main,block_ref,blocksize);
        
        length = d;
        
        while(length >= 1)
            
            for m = -length : length : length
                for n = -length : length : length
                    row_value = y + m;
                    col_value = x + n;
                    if ( row_value < 1 ||row_value+blocksize-1 > row|| col_value < 1 || col_value+blocksize-1 > col)
                        continue;
                    end
                    error_row = m/length + 2;
                    error_col = n/length + 2;
                    if (error_row == 2 && error_col == 2)
                        continue;
                    end
                    error(error_row, error_col ) = Erro_cal(block_main,frame1(row_value:row_value+blocksize-1, col_value:col_value+blocksize-1), blocksize);
                    
                end
            end
            
            [dx, dy, min] = minCost(error);
            x = x + (dx-2)*length;
            y = y + (dy-2)*length;
            
            length = length / 2;
            error(2,2) = error(dy,dx);   
        end
        vectors(1,mbCount) = y - i;
        vectors(2,mbCount) = x - j;
        mbCount = mbCount + 1;
        error = ones(3,3) * 10^4;
    end
end

mbCount = 1;
for i = 1:blocksize:row-blocksize+1
    for j = 1:blocksize:col-blocksize+1
        
        y = vectors(1,mbCount);
        x = vectors(2,mbCount);
        row_value = i + y;
        col_value = j + x;
        im_cre(i:i+blocksize-1,j:j+blocksize-1) = frame1(row_value:row_value+blocksize-1, col_value:col_value+blocksize-1);
        
        mbCount = mbCount + 1;
    end
end

dd = frame1-im_cre;
imshow(mat2gray(frame1-im_cre));
