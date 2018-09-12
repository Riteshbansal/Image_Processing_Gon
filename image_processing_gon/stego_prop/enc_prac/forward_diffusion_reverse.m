function P = forward_diffusion_reverse(E, E2, E1, R1 , R2)
   a = mod(E-R2,256);
   b = bitxor(a, R1);
   c = b -E1;
   d = mod(c,256);
   e = d-E2;
   P = mod(e,256);
end