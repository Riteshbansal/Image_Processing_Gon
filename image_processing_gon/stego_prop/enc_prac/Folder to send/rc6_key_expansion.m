function S=rc6_key_expansion(L) % L stands for the key(in documentation)

% key expansion

% L='de37a1fd8492d8efe714f1b7cc783aad'; %key

%magic constants
P_w='B7E15163';
Q_w='9e3779b9';

w=32;
r=20;
b=16;

u=4; % u=w/8

c=ceil(b/u);

t=2*r+4;


% doing L[i/u] = (L[i/u] <<< 8) + K[i] , where K is the key
pntr=1;
j=5;
for i=size(L,2):-2:1
    if mod(i,8)==0 
        j=j-1;
        pntr=1;
    end
    L1(j,pntr:pntr+1)=L(1,i-1:i);
    pntr=pntr+2;
end

S(1,:)=P_w;

for i=2:t
    
    m=sprintf('%08x',mod(sscanf(S(i-1,:),'%x')+sscanf(Q_w,'%x'),2^32)); % addition of two hex modulo 2^w    
    S(i,:)=m;
end

i=1;
j=1;
A='0';
B='0';
for pntr=1:3*44
    
    m=sprintf('%08x',mod(sscanf(S(i,:),'%x')+sscanf(A,'%x')+sscanf(B,'%x'),2^32));  
    m=circshift(dec2bin(sscanf(m,'%x'),32),[0,-3]);
    
    S(i,:)=sprintf('%08x',bin2dec(m));
    A=S(i,:);
    
    n=sprintf('%08x',mod(sscanf(L1(j,:),'%x')+sscanf(A,'%x')+sscanf(B,'%x'),2^32));
    n=circshift(dec2bin(sscanf(n,'%x'),32),[0,-(sscanf(A,'%x')+sscanf(B,'%x'))]);

    L1(j,:)=sprintf('%08x',bin2dec(n));
    B=L1(j,:);
    
    i=mod(i,44)+1;
    j=mod(j,4)+1;
    
end
