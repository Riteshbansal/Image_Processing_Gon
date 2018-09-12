function F = backward_diffusion(E, F2, F1, R1 , R2)
    i = E+F2;
    a = mod(i,256);
    b = a +F1;
    c = mod(b,256);
    d = bitxor(c,R1);
    e = d+R2;
    F = mod(e,256);

end