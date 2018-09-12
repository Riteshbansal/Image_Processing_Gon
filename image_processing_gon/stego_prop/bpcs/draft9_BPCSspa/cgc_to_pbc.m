function mat_o = cgc_to_pbc(carr)

[m,n] = size(carr);
mat_o = zeros(size(carr));
for i=1:m
    for j=1:n
        %         for k=1:p
        gry=de2bi(carr(i,j),8,'left-msb');
        for s=1:7
            gry(1,s)=bitxor(gry(1,s+1),gry(1,s));          % conversion from pbc to cgc
        end
        mat_o(i,j)=bi2de(gry,'left-msb');               % bit plane formation
        %         end
    end
end



end