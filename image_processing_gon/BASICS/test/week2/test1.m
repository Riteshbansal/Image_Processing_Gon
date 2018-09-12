clc
clear

x = double((imread('/Users/INNOCENTBOY/Downloads/videos/Imageprocessing/week3/digital-images-week2_quizzes-lena.gif')));
fil = ones(5,5);
fil = fil/25;
% y = imfilter (x,fil,'replicate');
y = imfilter (x,fil,'conv');
size_matrix = size(x);

PSNR = (sum(sum(((y- x).*(y-x)))));
PSNR = PSNR/(size_matrix(1)*size_matrix(2));
PSNR = 20 * log10(255/ sqrt(PSNR));