
function psnr = PSNR_calculation(img1, img2)
[row, col] = size(img1);
psnr = sum(sum(((double(img2)-double(img1)).*(double(img2)-double(img1)))));
psnr = psnr/(row*col);

end