function E = backward_diffusion_reverse(F, F2, F1, R1 , R2)
   a = mod(F-R2,256);
   b = bitxor(a, R1);
   c = b -F1;
   d = mod(c,256);
   e = d-F2;
   E = mod(e,256);

end