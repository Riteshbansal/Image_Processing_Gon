function x=rl_dec(c)
x1=[];
for i=1:length(c)
    if(mod(i,2)==1)
        x1 = [x1 zeros(1,c(i))];
    else
        x1 = [x1 ones(1,c(i))];
        
    end
end
x1 = x1';
l = numel(x1)/8;
x1 = reshape(x1,[8,l]);
x1 = x1';
x1 = bi2de(x1,'left-msb');
x = x1';
end