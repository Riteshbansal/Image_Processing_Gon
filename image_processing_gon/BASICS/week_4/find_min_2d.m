function min_out = find_min_2d(block_ref, error,d,x1,y1)
if(d==1)
    error_ref = zeros(3,3);
    for i = -1:1:1
        for j = -1:1:1
            error_ref(i+2,j+2) = block_ref(x1+(i*d),y1+(j*d));
        end
    end
    
    error_diff = error-error_ref;
    error_diff = abs(error_diff);
    
    [x,y] = find(error_diff==min(error_diff(:)));
    if(error_diff(2,2)<=error_diff(x(1,1),y(1,1)))
        x(1,1) = 2;
        y(1,1) = 2;
        
    end
    x = x1 + ((x(1,1)-2)*d);
    y = y1 + ((y(1,1)-2)*d);
    min_out = [x,y];
else
    error_ref = zeros(3,3);
    error1 = zeros(3,3);
    
    for i = -1:1:1
        for j = -1:1:1
            error_ref(i+2,j+2) = block_ref(x1+(i*d),y1+(j*d));
        end
    end
    
    error_diff = error-error_ref;
    error_diff = abs(error_diff);
    [x,y] = find(error_diff==min(error_diff(:)));
    if(error_diff(2,2)<=error_diff(x(1,1),y(1,1)))
        x(1,1) = 2;
        y(1,1) = 2;
        
    end
    x = x1 + ((x(1,1)-2)*d);
    y = y1 + ((y(1,1)-2)*d);
    d1 = floor(d/2);
    error1(:,:) = block_ref(x,y);
    
    min_out = find_min_2d(block_ref,error1,d1,x,y);
end
end
