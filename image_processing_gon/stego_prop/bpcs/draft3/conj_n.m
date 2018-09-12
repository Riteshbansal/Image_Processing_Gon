function m = conj_n(comp2)

n=8;
val1 = mod(bsxfun(@plus,1:n,(1:n)'),2);
comp2 = reshape(comp2,[8,8]);
comp2 = bitxor(val1,comp2);
m = comp2(:)';

end