function vec_out = vector_modification2(frame1,frame2,vector,blocksize)
% vec_out =vector;
[row,col] = size(frame1);
[row1 , col1] = size(vector);

vec_out = zeros(row1 , col1);

for Count = 1:1:col1
    x1 = vector(3,Count);
    y1 = vector(4,Count);
    x = vector(1,Count);
    y = vector(2,Count);
%     fprintf('%d \n',Count);
    
    main_row_s = x-(ceil(blocksize/2)-1);
    main_row_e = x+ceil(blocksize/2);
    main_col_s = y-(ceil(blocksize/2)-1);
    main_col_e = y+ceil(blocksize/2);
    
    ref_row_s = x1-(ceil(blocksize/2)-1);
    ref_row_e = x1+ceil(blocksize/2);
    ref_col_s = y1-(ceil(blocksize/2)-1);
    ref_col_e = y1+ceil(blocksize/2);
    if(main_row_s<1)
        main_row_s = 1;
        main_row_e = main_row_e+blocksize-1;
    elseif(main_row_e>row)
        main_row_s = row-blocksize;
        main_row_e = row;
    end
    
    if(main_col_s<1)
        main_col_s = 1;
        main_col_e = main_col_s+blocksize-1;
    elseif(main_col_e>col)
        main_col_s = col-blocksize;
        main_col_e = col;
    end
    block_main = frame2(main_row_s:main_row_e, main_col_s:main_col_e);
    
    if(ref_row_s<1)
        ref_row_s = 1;
        ref_row_e = ref_row_s+blocksize-1;
    elseif(ref_row_e>row)
        ref_row_s = row-blocksize;
        ref_row_e = row;
    end
    
    if(ref_col_s<1)
        ref_col_s = 1;
        ref_col_e = ref_col_s+blocksize-1;
    elseif(ref_col_e>col)
        ref_col_s = col-blocksize;
        ref_col_e = col;
    end
    block_ref =  frame1(ref_row_s:ref_row_e, ref_col_s:ref_col_e);
    %     error = ones(2*p+1, 2*p+1)*10^4;
    %     for k_row = -p:1:p
    %         for k_col = -p:1:p
    %             row_start = x1+k_row;
    %             column_start = y1+k_col;
    %             row_end = x1+blocksize-1+k_row;
    %             column_end = y1+blocksize-1+k_col;
    %             if ( row_start < 1 || row_end > row|| column_start < 1 || column_end > col)
    %             else
    %                 block_ref = frame1(row_start:row_end, column_start:column_end);
    %                 err = sum(sum(abs(block_main - block_ref)));
    %                 err = err/(size(block_main,1)*size(block_main,2));
    %                 error(k_row+p+1,k_col+p+1) = err;
    %             end
    %         end
    %     end
    %     [x,y] = find(error==min(error(:)));
    err = abs(block_main - block_ref);
    [x_new,y_new] = find(err==min(err(:)));
    
    %     [x_new,y_new] = find(error==min(error(:)));
    x_new = x_new(1,1)-1;
    y_new = y_new(1,1)-1;
    x_main = main_row_s+(ceil(blocksize/2)-1);
    y_main = main_col_s+(ceil(blocksize/2)-1);
    x_ref = ref_row_s+x_new;
    y_ref = ref_col_s+y_new;
    
    %     x_ref = x1+x_new;
    %     y_ref = y1+y_new;
    vec_out(1,Count) = x_main;
    vec_out(2,Count) = y_main;
    vec_out(3,Count) = x_ref;
    vec_out(4,Count) = y_ref;
    
end


end