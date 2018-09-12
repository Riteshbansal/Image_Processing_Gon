function [l] = huff_enc3(A,pix)
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
C = 0:255;

 xsini(1,1)=pix;
for i = 2:1:(numel(C))+2
    xsini(1,i) = mod(sin(pi * xsini(1,i-1)),1);
end
xsin = 1+floor(mod(xsini(3:end)*10^10,numel(C)));
C = confusion_impl2(C,1,xsin);


G (1,:) = C;
prob = F/numel(A);
prob = zeros(1,256);
prob(:,:) = 1/256;
G (2,:) = prob;
%% huffman encoder
comp = huffmandict(G (1,:),G (2,:));
l = ones(numel(comp)/2,2);
for  i= 1:1:numel(comp)/2
    l(i,1) = comp{i};
    l(i,2) = bi2de(comp{i+numel(comp)/2},'left-msb');
end
[~,idx]=sort(l(:,1),'ascend');
l=l(idx,:);

% B = A';
% C = B(:);
% comp1 = huffmanenco(C,comp);
end
