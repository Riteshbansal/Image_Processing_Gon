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
        x_main = i;
        y_main = j;
        x_ref = x-p-1+i;
        y_ref = y-p-1+j;
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

% % fil = ones(7,7);
% % fil = fil*-1;
% % fil(4,4) = 16;
% % b =  imfilter(frame1,fil,'replicate');
% % % b = uint8(b);
% %
% % b2 = imfilter(frame2,fil,'replicate');
% % % b2 = uint8(b2);
% % b3= uint8(b2-b);
% % imshow(b3);
% % imshow(mat2gray(b2-b));



% % x_dft = fft2(frame1-frame2);
% % % y_dft = fft2(frame2);
% %
% %
% % z1 = abs(x_dft);
% % % z2 = abs(y_dft);
% %
% % z7 = mat2gray(log(1+z1));
% % % z8 = mat2gray(log(1+z2));
% %
% % % k1 = 1:1:size(frame1,1);
% % % k2 = 1:1:size(frame1,2);
% % % [k1,k2] = meshgrid(k2,k1);
% fil = ones(5,5);
% fil = fil/9;
% b =  imfilter(frame2-frame1,fil,'replicate');
% b = uint8(b);
% imshow(b);
% fil = ones(3,3);
% fil = fil*-1;
% fil(2,2) = 9;
% b =  imfilter(b,fil,'replicate');
% b = uint8(b);
% imshow(b);
% % b = mod(b,2);
% %
% figure
% % subplot(2,2,1),mesh(k1,k2,z7);
% % subplot(2,2,2),mesh(k1,k2,z8);
% % subplot(2,2,3),mesh(k1,k2,z8-z7);
%  subplot(2,2,1),imshow(b);
%  subplot(2,2,2),imshow(mat2gray(frame2-frame1));
%
%  % d1 = (ifft2(b));
% % imshow((d1));
%
% z = imshow(mat2gray(ifft2(conj(x_dft))));
%
% a = y_dft.*(conj(x_dft));
% b = abs(a);
%
% c = a./b;
%
% d = ifft2(c);
%
% imshow(mat2gray(d));
