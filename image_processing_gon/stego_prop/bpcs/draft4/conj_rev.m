function m = conj_rev(co)

n=8;
val1 = mod(bsxfun(@plus,1:n,(1:n)'),2);
m = bitxor(val1,co);

% n=8;
% val1 = mod(bsxfun(@plus,1:n,(1:n)'),2);
% co = bitxor(val1,co);
% co = co(:)';

end