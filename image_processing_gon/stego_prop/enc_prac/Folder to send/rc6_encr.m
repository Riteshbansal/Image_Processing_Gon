function encr_data=rc6_encr(data,S)

% encryption
w=32;
r=20; %rounds
data=sprintf('%02x',data);

A=data(1:8);
B=data(9:16);
C=data(17:24);
D=data(25:32);

B=sprintf('%08x',mod(sscanf(B,'%x')+sscanf(S(1,:),'%x'),2^32));
D=sprintf('%08x',mod(sscanf(D,'%x')+sscanf(S(2,:),'%x'),2^32));

for i=2:r+1
    B_dec=sscanf(B,'%x');
    D_dec=sscanf(D,'%x');    

    t=mod(B_dec*(2*B_dec+1),2^32);
    t=bin2dec(circshift(dec2bin(t,32),[0 -log2(w)])); %lgw in documentation means log2(w)

    u=mod(D_dec*(2*D_dec+1),2^32);
    u=bin2dec(circshift(dec2bin(u,32),[0 -log2(w)]));
    
    A = bitxor(sscanf(A,'%x'),(t));
    A=circshift(dec2bin(A,32),[0 -(u)]);
    A=sprintf('%08x',mod(bin2dec(A)+ sscanf(S(2*i-1,:),'%x'),2^32));
    
    C = bitxor(sscanf(C,'%x'),(u));
    C=circshift(dec2bin(C,32),[0 -(t)]);
    C=sprintf('%08x',mod(bin2dec(C)+ sscanf(S(2*i,:),'%x'),2^32));
    
    % executing (A;B;C;D) = (B;C;D;A)
    temp=A;
    A=B;
    B=C;
    C=D;
    D=temp;
end

A=sprintf('%08x',mod(sscanf(A,'%x')+sscanf(S(2*r+3,:),'%x'),2^32));
C=sprintf('%08x',mod(sscanf(C,'%x')+sscanf(S(2*r+4,:),'%x'),2^32));

encr_data=(sscanf(strcat(A,B,C,D),'%2x'))';