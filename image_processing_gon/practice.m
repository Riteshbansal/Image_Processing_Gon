clc
clear
uO=1;
vO=1;
A=1;
c= [1,2,3];
r = [4,5,6,7];
[C, R]= meshgrid(c, r );
g = A*sin(uO*R + vO*C);
pmax = max(g(:));
