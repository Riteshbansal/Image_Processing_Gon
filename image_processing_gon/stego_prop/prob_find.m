function G = prob_find(A)
B = A(:);

%% UNIQUE
a1 = A(:).';
a2 = sort(a1);
a3 = diff(a2);
a4 = a3 ~= 0;
a4 = [true, a4];
C = a2(a4);
D = bsxfun(@eq, B,C);
F = sum(D);
G (1,:) = C;
prob = F/numel(A);
G (2,:) = prob;
end