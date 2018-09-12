% function enco = huffman_encoder(sig, dict)
clc
clear
% im = imread('/Users/INNOCENTBOY/Documents/MATLAB/pic/256/4.1.01.tiff');
% im = rgb2gray(im);


A = [1,2,3;3,5,9];
B = A(:);

%% UNIQUE
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

g1 = G';
% g2 = sortrows(g1,3);
% [g11,j] = sort(g1(:,3))
% [~,idx]=sort(g1(:,3),'descend');
% g2=g1(idx,:);

g2 = sort_personal(g1, 2);

%% huffman encoder
prob = g2(:,2);
% x=huffman5(prob);
% [M,N] = size(prob);
% prob_cell = num2cell(prob);
a = symbol_huff(g2);

% end
