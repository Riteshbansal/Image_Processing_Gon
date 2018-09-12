
function cost = Erro_cal(current,ref, n)
cost = sum(sum(abs(current-ref)))/(n*n);
end

