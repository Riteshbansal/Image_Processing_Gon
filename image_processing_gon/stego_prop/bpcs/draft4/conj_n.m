function m = conj_n(comp2)

n=8;
val1 = mod(bsxfun(@plus,1:n,(1:n)'),2);
m = bitxor(val1,comp2);

end