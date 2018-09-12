function img = block_3_step_search(frame1,frame2,p,blocksize)
%
[row,col] = size(frame2);
%
vectors1 = zeros(4,(row*col)/(blocksize*blocksize));
%
error = ones(3, 3)*10^5;
L = floor(log10(p+1)/log10(2));
d = 2^(L-1);

Count = 1;
for i = 1:blocksize:row-blocksize+1
    for j = 1:blocksize:col-blocksize+1
        
        block_main = frame2(i:i+blocksize-1,j:j+blocksize-1);
        error = ones(3, 3)*10^5;
        length = d;
        x_ref = i;
        y_ref = j;
        while(length>=1)
            error = ones(3, 3)*10^5;

            for k_row = -1:1:1
                for k_col = -1:1:1
                    row_start = x_ref+(k_row*length);
                    column_start = y_ref+(k_col*length);
                    row_end = row_start+blocksize-1;
                    column_end = column_start+blocksize-1;
                    if ( row_start < 1 || row_end > row|| column_start < 1 || column_end > col)
                    else
                        block_ref = frame1(row_start:row_end, column_start:column_end);
                        err = sum(sum(abs(block_main - block_ref)));
                        err = err/(size(block_main,1)*size(block_main,2));
                        error(k_row+2,k_col+2) = err;
                    end
                end
            end
            [x,y] = find(error==min(error(:)));
            x = x(1,1);
            y = y(1,1);
            
            x_ref = (x-2)*length+x_ref;
            y_ref = (y-2)*length+y_ref;
            length = length / 2;
        end
        x_main = i;
        y_main = j;
        vectors1(1,Count) = x_main;
        vectors1(2,Count) = y_main;
        vectors1(3,Count) = x_ref;
        vectors1(4,Count) = y_ref;
        Count = Count+1;
    end
end

for Count=1:1:(row*col)/(blocksize*blocksize)
    x = vectors1(3,Count);
    y = vectors1(4,Count);
    x1 = vectors1(1,Count);
    y1 = vectors1(2,Count);
    im_cre(x1:x1+blocksize-1, y1:y1+blocksize-1) = frame1(x:x+blocksize-1, y:y+blocksize-1);
end
img = im_cre;
end
