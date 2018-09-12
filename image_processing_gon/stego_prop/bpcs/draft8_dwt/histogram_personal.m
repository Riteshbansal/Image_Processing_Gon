function G =  histogram_personal(A)

% % % A = [1,2,7;3,2,1];
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
G (1,:) = C;
prob = F/numel(A);
G (2,:) = prob;
%
%%
% val = find(histc(A(:), min(A(:)):max(A(:)))==1) + min(A(:)) - 1;
end