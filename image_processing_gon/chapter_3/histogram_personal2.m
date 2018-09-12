% function histogram_personal(im)
clc
clear
A = [1,2,7;3,2,1];
% im = imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/256/4.1.01.tiff');
% A = rgb2gray(im);
B = A(:);

%% Unique value in matrix Calculation
a1 = A(:).';
a2 = sort(a1);
a3 = diff(a2);
a4 = a3 ~= 0;
a4 = [true, a4];
C = a2(a4);

%% BSXFUN ,  Calculating no of time a pixel is there in matrix
% C = unique();
D = bsxfun(@eq, B,C);
F = sum(D);
G (2,:) = F;
G (1,:) = C;
f2 = F/(numel(A));
%
% %% PLoting hist
% figure;
% subplot(2,2,1),histogram(A),title('Histogram orig');
% subplot(2,2,2),plot(C,F)
% xlabel('Pixels Values');
% ylabel('Pixels Count');
% title('Created histogram');
% subplot(2,2,3),plot(C,f2)
% xlabel('Pixels Values');
% ylabel('Pixels Count probability');
% title('Created histogram 2');
%%
% val = find(histc(A(:), min(A(:)):max(A(:)))==1) + min(A(:)) - 1;
% end