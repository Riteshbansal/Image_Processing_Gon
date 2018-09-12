function mat_o = pbc_to_cgc(carr)

[m,n] = size(carr);
mat_o = zeros(size(carr));
for i=1:m
    for j=1:n
        %         for k=1:p
        m1=de2bi(carr(i,j),8,'left-msb');
%         m1=de2bi(carr(i,j),9);
        gry = zeros(1,8);
        gry(1)=m1(1);
        for s=2:8
            gry(1,s)=bitxor(m1(1,s-1),m1(1,s));          % conversion from pbc to cgc
        end
        mat_o(i,j)=bi2de(gry,'left-msb');               % bit plane formation
%         mat_o(i,j)=bi2de(gry);               % bit plane formation
        %         end
    end
end



end