function [PSNR_Value mse] = PSNRCal(Ix,Ihat)


% Read the dimensions of the image.
[rows columns] = size(Ix);

% Calculate mean square error of R, G, B.
mseRImage = ((Ix(:,:,1)) - (Ihat(:,:,1))) .^ 2;
mseGImage = ((Ix(:,:,2)) - (Ihat(:,:,2))) .^ 2;
mseBImage = ((Ix(:,:,3)) - (Ihat(:,:,3))) .^ 2;
mseR = sum(sum(mseRImage)) / (rows * columns);
mseG = sum(sum(mseGImage)) / (rows * columns);
mseB = sum(sum(mseBImage)) / (rows * columns);

% Average mean square error of R, G, B.
mse = (mseR + mseG + mseB);

% Calculate PSNR (Peak Signal to noise ratio).
PSNR_Value = 10 * log10( 255^2 / mse);
end