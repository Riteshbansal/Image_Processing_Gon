function out_pic = decrese_size(img,row,col)
% [row, col] = size (img);
fil = ones(3,3);
fil = fil/9;
b = imfilter(img,fil,'replicate');
out_pic(:,:) = b(1:2:row,1:2:col);
out_pic = floor(out_pic);
end