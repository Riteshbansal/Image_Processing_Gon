clc
clear

%% Ans 3
% x = [1,1,2,2;1,1,2,2;2,2,3,4;2,2,5,6];
% y = [2,2,1,1;2,2,2,2;2,2,6,4;2,2,5,3];
% 
% c = x-y;
% c = c.^2;
% c= sum(sum(c));
% c = c/(4*4);


%%  Ans 7

I1 = double(imread('/Users/INNOCENTBOY/Downloads/videos/Imageprocessing/week4/motion1.jpg'));
I2 = double(imread('/Users/INNOCENTBOY/Downloads/videos/Imageprocessing/week4/motion2.jpg'));
[row, col]=size(I1);
b_target = I2(65:96,81:112);


p =7;
error = ones(2*p+1, 2*p+1)*10^6;
blocksize = 32;
i =65;
j = 81;

for k_row = -p:1:p
    for k_col = -p:1:p
        row_start = i+k_row;
        column_start = j+k_col;
        row_end = i+blocksize-1+k_row;
        column_end = j+blocksize-1+k_col;
        if ( row_start < 1 || row_end > row|| column_start < 1 || column_end > col)
        else
            b_ref = I1(row_start:row_end, column_start:column_end);
            err = sum(sum(abs(b_target - b_ref)));
            err = err/(size(b_target,1)*size(b_target,2));
            error(k_row+p+1,k_col+p+1) = err;
        end
    end
end

[x,y] = find(error==min(error(:)));
x = x(1,1);
y = y(1,1);
x_ref = x-p-1+i;
y_ref = y-p-1+j;



