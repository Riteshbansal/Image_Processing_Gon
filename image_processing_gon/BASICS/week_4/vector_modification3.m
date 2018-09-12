function vec_out = vector_modification3(frame1,frame2,vector,blocksize)
% vec_out =vector;
[row,col] = size(frame1);
[row1 , col1] = size(vector);

vec_out = zeros(row1 , col1);

for Count = 1:1:col1
    x1 = vector(3,Count);
    y1 = vector(4,Count);
    x = vector(1,Count);
    y = vector(2,Count);
    
    for i = 0:1
        for j = 0:1
            
        end
    end
    
    vec_out(1,Count) = x_main;
    vec_out(2,Count) = y_main;
    vec_out(3,Count) = x_ref;
    vec_out(4,Count) = y_ref;
    
end


end