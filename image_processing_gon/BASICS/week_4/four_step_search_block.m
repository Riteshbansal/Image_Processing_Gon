clc
clear all
vidObj = VideoReader('/Users/INNOCENTBOY/Desktop/1.mp4');
vidObj.CurrentTime = 520;

frame1 = readFrame(vidObj);
frame2 = readFrame(vidObj);
frame2 = readFrame(vidObj);
frame2 = readFrame(vidObj);
frame2 = readFrame(vidObj);


blocksize=16;

frame1 = double(rgb2gray(frame1));
frame2 = double(rgb2gray(frame2));


%
[row,col] = size(frame2);
%
vectors1 = zeros(4,(row*col)/(blocksize*blocksize));
%
error = ones(3, 3)*10^5;

Count = 1;
for i = 1:blocksize:row-blocksize+1
    for j = 1:blocksize:col-blocksize+1
        
        block_main = frame2(i:i+blocksize-1,j:j+blocksize-1);
        error = ones(3, 3)*10^5;
        for k_row = -1:1:1
            for k_col = -1:1:1
                row_start = i+(k_row*2);
                column_start = j+(k_col*2);
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
        level = 3;
        if(error(2,2)==error(x,y))
           x = 2; 
           y = 2;
           level = 1;
        end
        x_main = i;
        y_main = j;
        x_ref = (x-2)*2+i;
        y_ref = (y-2)*2+j;
        
        case_value = 1;
        if(level ~=1)
            while(level ~=1)
                if ((x_ref == x_main - 2 && y_ref == y_main) ...
                        || (x_ref == x_main && y_ref == y_main+2) ...
                        || (x_ref == x_main +2 && y_ref == y_main) ...
                         || (x_ref == x_main && y_ref == y_main-2))
                    case_value = 2;
                else
                    case_value = 1;
                end
                error = ones(3, 3)*10^5;
                block_main_new = frame2(x_ref:x_ref+blocksize-1,y_ref:y_ref+blocksize-1);
                
                switch(case_value)
                    case 1
                        
                        for k_row = -1:1:1
                            for k_col = -1:1:1
                                if(k_row==0 && k_col ~=1)
                                    break;
                                end
                                if(k_row==1 && k_col ~=1)
                                    break;
                                end
                                row_start = x_ref+(k_row*2);
                                column_start = y_ref+(k_col*2);
                                row_end = row_start+blocksize-1;
                                column_end = column_start+blocksize-1;
                                if ( row_start < 1 || row_end > row|| column_start < 1 || column_end > col)
                                else
                                    block_ref_new = frame1(row_start:row_end, column_start:column_end);
                                    err = sum(sum(abs(block_main_new - block_ref_new)));
                                    err = err/(size(block_main_new,1)*size(block_main_new,2));
                                    error(k_row+2,k_col+2) = err;
                                end
                            end
                        end
                        
                    case 2 
                        
                        for k_row = -1:1:1
                            for k_col = -1:1:1
                               if(k_col==1)
                                   row_start = x_ref+(k_row*2);
                                   column_start = y_ref+(k_col*2);
                                   row_end = row_start+blocksize-1;
                                   column_end = column_start+blocksize-1;
                                   if ( row_start < 1 || row_end > row|| column_start < 1 || column_end > col)
                                   else
                                       block_ref_new = frame1(row_start:row_end, column_start:column_end);
                                       err = sum(sum(abs(block_main_new - block_ref_new)));
                                       err = err/(size(block_main_new,1)*size(block_main_new,2));
                                       error(k_row+2,k_col+2) = err;
                                   end
                               end
                            end
                        end
                        
                end
                [x,y] = find(error==min(error(:)));
                x = x(1,1);
                y = y(1,1);
                level = level-1;
                if(error(2,2)==error(x,y))
                    x = 2;
                    y = 2;
                    level = 1;
                end
                x_ref = (x-2)*2+x_ref;
                y_ref = (y-2)*2+y_ref;

            end
        end

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
dd = frame1-im_cre;
imshow(mat2gray(frame1-im_cre));

