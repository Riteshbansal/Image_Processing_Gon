% function mat_o = pbc_to_cgc4(carr)
clc
clear
carr = double(imread('256_p.jpg'));

[m,n,c] = size(carr);
mat_o = zeros(size(carr));
for k = 1:1:c
    for i=1:m
        for j=1:n
            %         for k=1:p
            m1=de2bi(carr(i,j,k),8,'left-msb');
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


% end