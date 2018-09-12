function [comp1_1, comp_1,prob] = huff_enc2(A)
rem = mod(numel(A),8);
add_val = [ zeros(1,8-rem),de2bi(8-rem,8,'left-msb')];
comp2 = [A;add_val'];
y = reshape(comp2,[8,numel(comp2)/8]);
y = bi2de(y','left-msb');
yG = prob_find(y);
prob = yG (2,:);
comp_1 = huffmandict(yG (1,:),yG (2,:));
l = cell(numel(comp_1)/2,1);
for  i= 1:1:numel(comp_1)/2
    l{i} = comp_1{i};
end
B = y';
C = B(:);
comp1_1 = huffmanenco(C,comp_1);

end
