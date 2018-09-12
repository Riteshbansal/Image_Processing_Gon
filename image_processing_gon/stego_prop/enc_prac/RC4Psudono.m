function out = RC4Psudono( k, I )

%generating M*N RC4 pseudo random numbers
s = zeros(1,256);
t = zeros(1,256);

%Encryption

for i=0:255
    %initiating s
    s(i+1)=i+1;
    t(i+1)=k(mod(i,numel(k))+1); 
end

j=0;
for i=1:256
    %permutation
    j=mod((j+s(i)+t(i)),256);
    if(j~=0)
    [s(i) , s(j)] = swap(s(i), s(j));
    else
        j=mod((j+s(i)+t(i)),256);
        [s(i) , s(j)] = swap(s(i), s(j));
    end
end

i=0; j=0;


Psudo_random=zeros(1,I);
for ii=1:I
    i=mod((i+1),256);
    j=mod((j+s(i+1)),256);
    [s(i+1),s(j+1)] = swap(s(i+1),s(j+1));
    
    Psudo_random(ii)=(mod((s(i+1)+s(j+1)),256)+1);
end
out = Psudo_random;



end
