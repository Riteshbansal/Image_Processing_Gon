function [q, q_map] = q_fs(img1, img2, block_size, p, o1, o2, o3)

% Q_FS
% Calculates Q (UIQI) index, locally between 2 images (img1,img2).

% Inputs
% ------
% img1: Reference or test image
% img2: Reference or test image
% block_size: Size of the neighborhood in the image in which the Q index
%             will be evaluated.
% p: precision (1 for single, 2 for double)
% o1: option1 = Boundary option of imfilter function 
% o2: option2 = Output Size Options of imfilter function
% o3: option3 = Correlation and Convolution Options of imfilter function

% The last 5 input arguments can be skipped and the defaults are:
% 8, 1, 'replicate', 'same' and 'corr' respectively

% The block size (neighborhood size) is usually between 3-15 and mostly
% between 7-9.

% Outputs
% -------
% q: The mean value of the Q index of the images img1, img2
% q_map: A new image the size of img1 (and img2) which has Q values in
%        every pixel. You can show this image by writing:
% imshow(q_map,[-1 1]) or imshow(q_map,[]).
% That way, you can see locally, where you have high or low quality between
% the 2 images.

% Notice
% ------
% q is not exactly mean2(q_map). We have to exclude the borders (first and 
% last rows and columns) which have taken invalid Q values due to missing 
% data. This problem is merely tackled by replicating the data of the
% borders (default o1 value) - instead of filling them with zeros, 
% but perhaps a more correct (and strict) solution, is to exlude completely
% the border data of q_map in the calculation of q. This can be seen in the 
% last 2 lines of code.

% Example
% -------
% a = imread('mandi.tif');
% mf = fspecial('average',11);
% b = imfilter( a, mf );
% [q, qm] = q_fs(a, b, 7);
% figure(1), imshow(a); figure(2), imshow(b); figure(3), imshow(qm,[-1 1]);

% Authors
% -------
% Author:                           Zhou Wang (2001)
% Aknowledgement (Original Author): Umesh Rajashekar (2001)

% Modified and Corrected by:        Aristidis Vaiopoulos (2012-13)

% xx/10/2012 - Version 1.0 / Corrected the original function by Zhou Wang
% 27/01/2013 - Version 2.0 / Added p and o1-3 optional arguments

if nargin < 2
   error('This function needs at least two inputs.')
end

if (size(img1) ~= size(img2))
   error('Image 1 and 2 must have the excact same size.')
end

% Default Values
if nargin == 2
   block_size = 8;
   p  = 1;
   o1 = 'replicate';
   o2 = 'same';
   o3 = 'corr';
end

if nargin == 3
   p = 1;
   o1 = 'replicate';
   o2 = 'same';
   o3 = 'corr';
end

if nargin == 4
   o1 = 'replicate';
   o2 = 'same';
   o3 = 'corr';
end

if nargin == 5
   o2 = 'same';
   o3 = 'corr';
end

if nargin == 6
   o3 = 'corr';
end

N = block_size.^2;
sum2_filter = ones(block_size);

if p == 1;
    img1 = single(img1);
    img2 = single(img2);
end
if p == 2;
    img1 = double(img1);
    img2 = double(img2);
end

img1_sq   = img1.*img1;
img2_sq   = img2.*img2;
img12 = img1.*img2;

img1_sum   =    imfilter( img1, sum2_filter, o1, o2, o3);      %уч
img2_sum   =    imfilter( img2, sum2_filter, o1, o2, o3);      %уш
img1_sq_sum =   imfilter( img1_sq, sum2_filter, o1, o2, o3);   %уч^2
img2_sq_sum =   imfilter( img2_sq, sum2_filter, o1, o2, o3);   %уш^2
img12_sum =     imfilter( img12, sum2_filter, o1, o2, o3);     %учш

img12_sum_mul = img1_sum.*img2_sum;                                 %уч*уш
img12_sq_sum_mul = img1_sum.*img1_sum + img2_sum.*img2_sum;         %ч^2 + ш^2 
numerator = 4*(N*img12_sum - img12_sum_mul).*img12_sum_mul;         %4(Нучш - уч*уш)*учш
denominator1 = N*(img1_sq_sum + img2_sq_sum) - img12_sq_sum_mul;    %Нуч^2 + Нуш^2 - ч^2 + ш^2 = Р
denominator = denominator1.*img12_sq_sum_mul;                       %Р * (ч^2 + ш^2)

q_map = ones(size(denominator));
index = (denominator1 == 0) & (img12_sq_sum_mul ~= 0);
q_map(index) = 2*img12_sum_mul(index)./img12_sq_sum_mul(index);
index = (denominator ~= 0);
q_map(index) = numerator(index)./denominator(index);

% q: quality from valid filtered area
s = round(block_size/2);
q = mean2( q_map(s:end-s,s:end-s) );
