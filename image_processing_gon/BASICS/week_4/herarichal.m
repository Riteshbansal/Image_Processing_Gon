clc
clear all
vidObj = VideoReader('/Users/INNOCENTBOY/Desktop/1.mp4');
vidObj.CurrentTime = 520;

frame1 = readFrame(vidObj);
frame2 = readFrame(vidObj);
frame2 = readFrame(vidObj);
frame2 = readFrame(vidObj);
frame2 = readFrame(vidObj);

p=7;
blocksize=16;

frame1 = double(rgb2gray(frame1));
frame2 = double(rgb2gray(frame2));

level = 3;
% vect = Exhaustive_search_function(frame1,frame2,p,blocksize);

vectors1 = herarichal_function(frame1,frame2,level,p,blocksize);
[row1 , col1] = size(vectors1);
[row,col] = size(frame1);

for Count=1:1:col1
    x1 = vectors1(3,Count);
    y1 = vectors1(4,Count);
    x = vectors1(1,Count);
    y = vectors1(2,Count);
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
        k = frame1(ref_row_s:ref_row_e, ref_col_s:ref_col_e);
        im_cre(main_row_s:main_row_e, main_col_s:main_col_e)= k(:,:); 
end
dd = frame1-im_cre;
imshow(mat2gray(frame1-im_cre));
