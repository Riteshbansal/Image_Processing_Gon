function E = forward_diffusion(P, E2, E1, R1 , R2)
    
  E =   mod(((bitxor(mod(((mod((P+E2),256))+E1),256),R1))+R2),256);

end