function mat_o = pbc_to_cgc(carr)

[m,n] = size(carr);
mat_o = zeros(size(carr));
for i=1:m
    for j=1:n
        %         for k=1:p
        m1=de2bi(carr(i,j),9,'left-msb');
        gry = zeros(1,9);
        gry(1)=m1(1);
        for s=2:9
            gry(1,s)=bitxor(m1(1,s-1),m1(1,s));          % conversion from pbc to cgc
        end
        mat_o(i,j)=bi2de(gry,'left-msb');               % bit plane formation
        %         end
    end
end



end