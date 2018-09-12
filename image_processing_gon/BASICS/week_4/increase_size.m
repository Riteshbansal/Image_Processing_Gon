function out_pic = increase_size(img,row,col)
% [row, col] = size (img);
up_sam = zeros(row,col);
up_sam(1:2:row,1:2:col) = img(:,:) ;
fil_2 = [0.25,0.5,0.25;0.5,1,0.5;0.25,0.5,0.25];
out_pic = imfilter(up_sam,fil_2);

end