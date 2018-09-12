clc
clear
imo = double(rgb2gray((imread('256_p.jpg'))));
c = (mode(mean(imo)));
b = bitxor(imo,c);

xsini(1,1)=0.1;
for i = 2:1:(256)+2
    xsini(1,i) = mod(sin(pi * xsini(1,i-1)),1);
end
xsin = 1+floor(mod(xsini(3:end)*10^10,256));

xsini(1,1)=0.4;
for i = 2:1:(256)+2
    xsini(1,i) = mod(sin(pi * xsini(1,i-1)),1);
end
xsin1 = 1+floor(mod(xsini(3:end)*10^10,256));

comp1 = confusion_impl2(b,xsin,xsin1);




corr2(comp1,imo);



