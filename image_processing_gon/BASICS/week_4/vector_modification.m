function vec_out = vector_modification(frame1,frame2,vector,blocksize)
[row1,col1] = size(frame1);
[row , col] = size(vector);

vec_out = zeros(row , col);

for Count = 1:1:col    
    x = vector(3,Count);
    y = vector(4,Count);
    x1 = vector(1,Count);
    y1 = vector(2,Count);
%     fprintf('%d \n',Count);
%     if(Count == 520)
%        Count; 
%     end
    
    
    if(x+blocksize-1 >row1)
        x = row1 - blocksize;
    end
     if(y+blocksize-1 >col1)
        y = col1 - blocksize;
    end
     if(x1+blocksize-1 >row1)
        x2 = row1 - blocksize;
     else
         x2 = x1;
    end
     if(y1+blocksize-1 >col1)
        y2 = col1 - blocksize;
     else
         y2 = y1;
    end
    
    block_main = frame1(x:x+blocksize-1, y:y+blocksize-1);
    block_ref = frame2(x2:x2+blocksize-1, y2:y2+blocksize-1);
    err = abs(block_main - block_ref);
    [x_new,y_new] = find(err==min(err(:)));
    x_new = x_new(1,1)-1;
    y_new = y_new(1,1)-1;
    x_main = x1;
    y_main = y1;
    x_ref = x1+x_new;
    y_ref = y1+y_new;
    vec_out(1,Count) = x_main;
    vec_out(2,Count) = y_main;
    vec_out(3,Count) = x_ref;
    vec_out(4,Count) = y_ref;

end


end