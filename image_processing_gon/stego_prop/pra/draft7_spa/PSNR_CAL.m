function psnr = PSNR_CAL(im,im_11)

PSNR = sum(sum(sum(((im)-(im_11)).*((im)-(im_11)))));
PSNR = PSNR /(numel(im));
psnr = 20 * log10(255/ sqrt(PSNR));

end