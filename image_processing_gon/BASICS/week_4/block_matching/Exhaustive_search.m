function img = Exhaustive_search(frame1,frame2,p,blocksize)

%
[row,col] = size(frame2);
%
vectors1 = zeros(4,(row*col)/(blocksize*blocksize));
%
error = ones(2*p+1, 2*p+1)*10^4;

Count = 1;
for i = 1:blocksize:row-blocksize+1
    for j = 1:blocksize:col-blocksize+1
        
        block_main = frame2(i:i+blocksize-1,j:j+blocksize-1);
        error = ones(2*p+1, 2*p+1)*10^4;
        for k_row = -p:1:p
            for k_col = -p:1:p
                row_start = i+k_row;
                column_start = j+k_col;
                row_end = i+blocksize-1+k_row;
                column_end = j+blocksize-1+k_col;
                if ( row_start < 1 || row_end > row|| column_start < 1 || column_end > col)
                else
                    block_ref = frame1(row_start:row_end, column_start:column_end);
                    err = sum(sum(abs(block_main - block_ref)));
                    err = err/(size(block_main,1)*size(block_main,2));
                    error(k_row+p+1,k_col+p+1) = err;
                end
            end
        end
        [x,y] = find(error==min(error(:)));
        x = x(1,1);
        y = y(1,1);
        %         x_main = i;
        %         y_main = j;
        %         x_ref = x-p-1+i;
        %         y_ref = y-p-1+j;
        x_main = i+ceil(blocksize/2)-1;
        y_main = j+ceil(blocksize/2)-1;
        x_ref = x-p-1+i+ceil(blocksize/2)-1;
        y_ref = y-p-1+j+ceil(blocksize/2)-1;
        vectors1(1,Count) = x_main;
        vectors1(2,Count) = y_main;
        vectors1(3,Count) = x_ref;
        vectors1(4,Count) = y_ref;
        Count = Count+1;
    end
end

for Count=1:1:(row*col)/(blocksize*blocksize)
    %         x = vectors1(3,Count);
    %         y = vectors1(4,Count);
    %         x1 = vectors1(1,Count);
    %         y1 = vectors1(2,Count);
    %     im_cre(x1:x1+blocksize-1, y1:y1+blocksize-1) = frame1(x:x+blocksize-1, y:y+blocksize-1);
    x1 = vectors1(3,Count);
    y1 = vectors1(4,Count);
    x = vectors1(1,Count);
    y = vectors1(2,Count);
    main_row_s = x-(ceil(blocksize/2)-1);
    main_row_e = x+ceil(blocksize/2);
    main_col_s = y-(ceil(blocksize/2)-1);
    main_col_e = y+ceil(blocksize/2);
    
    ref_row_s = x1-(ceil(blocksize/2)-1);
    ref_row_e = x1+ceil(blocksize/2);
    ref_col_s = y1-(ceil(blocksize/2)-1);
    ref_col_e = y1+ceil(blocksize/2);
    
    k = frame1(ref_row_s:ref_row_e, ref_col_s:ref_col_e);
    im_cre(main_row_s:main_row_e, main_col_s:main_col_e)= k(:,:);
end
img = im_cre;

end
