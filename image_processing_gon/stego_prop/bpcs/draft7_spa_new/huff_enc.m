function [comp1, comp,G] = huff_enc(A)
B = A(:);

%% UNIQUE
a1 = A(:).';
a2 = sort(a1);
a3 = diff(a2);
a4 = a3 ~= 0;
a4 = [true, a4];
C = a2(a4);

%% BSXFUN ,  Calculating no of time a pixel is there in matrix
D = bsxfun(@eq, B,C);
F = sum(D);
G (1,:) = C;
prob = F/numel(A);
G (2,:) = prob;
%% huffman encoder
comp = huffmandict(G (1,:),G (2,:));
l = cell(numel(comp)/2,1);
for  i= 1:1:numel(comp)/2
    l{i} = comp{i};
end
B = A';
C = B(:);
comp1 = huffmanenco(C,comp);
end
