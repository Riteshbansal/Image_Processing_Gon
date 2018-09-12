function[xsin,xlog] = chaotic_map(pix,I_gr)


xsin(1,1)=pix;
for i = 2:1:(I_gr*I_gr)+2
    xsin(1,i) = mod(sin(pi * xsin(1,i-1)),1);
end
 xlog(1,1) = pix;

for k=2: (I_gr*I_gr)+2
    Alog=4; % Parameter of map
    xlog(1,k)=mod(Alog*xlog(1,k-1)*(1-xlog(1,k-1)),1);
end

end