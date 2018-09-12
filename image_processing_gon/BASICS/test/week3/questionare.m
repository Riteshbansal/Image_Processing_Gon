clc
clear all

%%



%% ANS 5

% a = ones(3,3);
% for n1=0:1:2
%     for n2=0:1:2
%         k = (-1)^(n1+n2);
%         a(n1+1,n2+1)= k* a(n1+1,n2+1);
%     end
% end
% 
% b = fft2(a);

%% ANS 6
% a = 1:16;
% a = reshape(a,4,4);
% a =a';
% 
% b = fft2(a);
% c = real(b(1,1));

%% ANS 7
% 
% x = [2,1,0,1;1,0,0,0;1,0,0,0];
% y = fft2(x);


%% ANS 8

% 
% x = imread('/Users/INNOCENTBOY/Downloads/videos/Imageprocessing/week3/digital-images-week3_quizzes-original_quiz.jpg');
% x = double(x);
% 
% fil = ones(3,3);
% fil = fil/9;
% b = imfilter(x,fil,'replicate');
% 
% c(:,:) = b(1:2:359,1:2:479);
% 
% % % %%%% c is down sample image
% % % imshow(mat2gray(x));
% % % imshow(mat2gray(c));
% 
% %%%
% 
% up_sam = zeros(359,479);
% 
% up_sam(1:2:359,1:2:479) = c(:,:) ;
% fil_2 = [0.25,0.5,0.25;0.5,1,0.5;0.25,0.5,0.25];
% im_upsam = imfilter(up_sam,fil_2);
% % 
% % imshow(mat2gray(x));
% % imshow(mat2gray(im_upsam));
% size_matrix = size(x);
% 
% 
% PSNR = (sum(sum(((x-im_upsam).*(x- im_upsam)))));
% PSNR = PSNR/(size_matrix(1)*size_matrix(2));
% PSNR = 20 * log10(255/ sqrt(PSNR));
% 
% 
