function psnr = PSNR_CAL(im,im_11)

PSNR = sum(sum(sum((double(im)-double(im_11)).*(double(im)-double(im_11)))));
PSNR = PSNR /(numel(im));
psnr = 20 * log10(255/ sqrt(PSNR));

end