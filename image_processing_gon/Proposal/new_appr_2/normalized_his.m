function out = normalized_his(A)

% % % A = [1,2,7;3,2,1];
% im = imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/256/4.1.01.tiff');

% A = rgb2gray(im);
[rol,col] = size(A);
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
%% Normalized Hist
f3=zeros(1,1);

for i=1:1:numel(f2)
 
        k = f2(1,1:i);
        f3(1,i) = sum(k);
end
I4 = zeros(rol,col);
for i = 1:1:rol
   for j = 1:1:col
       pix= A(i,j);
       x = find(C ==pix);
       I4(i,j) =  f3(1,x);
   end
end

out = (255*I4);
%
% % %% PLoting hist
% % figure;
% % subplot(2,2,1),imshow((A));
% % subplot(2,2,2),imshow(mat2gray(I5));
% % subplot(2,2,3),imhist((A));
% % subplot(2,2,4),imhist(uint8(I5));

%%
% val = find(histc(A(:), min(A(:)):max(A(:)))==1) + min(A(:)) - 1;
end