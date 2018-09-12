function dec = dec_Common(enc,xlog1,ylog1,zlog1)

enc = confusion_impl_rev2(enc,xlog1,ylog1);

twicw_Psudo_random = RC4Psudono(zlog1, 2*numel(enc));


% % diffusion stage


% 2(M * N) pseudorandom numbers
R1_DEC = twicw_Psudo_random(1,1:numel(enc));
R2_DEC = twicw_Psudo_random(1,numel(enc)+1:numel(twicw_Psudo_random));

%Scan the image column-wise in alternate orienctations decryption
Psudo_counter = 1;
I_column_dec = zeros(1,numel(enc));
lencgth = size(enc);
for i = 1:1:lencgth(2)
    column_vector = enc(:, i);
    if(mod(i,2)==1)
        for j = 1:1: numel(column_vector)
        I_column_dec(Psudo_counter) = column_vector(j);
        Psudo_counter = Psudo_counter+1;
        end
    else
        column_vector = flip(column_vector);
        for j = 1:1: numel(column_vector)
        I_column_dec(Psudo_counter) = column_vector(j);
        Psudo_counter = Psudo_counter +1;
        end
    end
    
end

%Backward diffusion reverse
lencgth = numel(I_column_dec);
Diffused_column_bac_dec = zeros(1,numel(enc));
for i = 1:1:lencgth
    E = I_column_dec(i);
    if(i+1 == lencgth+1 && i+2 == lencgth+2)
        F2 = 2;
        F1 = 1;
    elseif(i+2 ==lencgth+1)
        F2 = 1;
        F1 = I_column_dec(i+1);
    else  
    F2 = I_column_dec(i+2);
    F1 = I_column_dec(i+1);
    end
    R1_num = R1_DEC(i);
    R2_num = R2_DEC(i);
    Diffused_column_bac_dec(i) = backward_diffusion_reverse(E,F2,F1,R1_num,R2_num);
end


%forward diffusion reverse
lencgth = numel(Diffused_column_bac_dec);
Diffused_column_for_dec = zeros(1,numel(enc));
for i = lencgth:-1:1
    E = Diffused_column_bac_dec(i);
    if(i-1 == 0 && i-2 == -1)
        E2 = 2;
        E1 = 1;
    elseif(i-2 ==0)
        E2 = 1;
        E1 = Diffused_column_bac_dec(i-1);
    else  
    E2 = Diffused_column_bac_dec(i-2);
    E1 = Diffused_column_bac_dec(i-1);
    end
    R1_num = R1_DEC(i);
    R2_num = R2_DEC(i);
    
     Diffused_column_for_dec(i)= forward_diffusion_reverse(E,E2,E1,R1_num,R2_num);
    
end




%Now turn back to image
lencgth = size(enc);
I_reformed_again_dec= zeros(lencgth(1),lencgth(2));
for i = 0:1:lencgth(2)-1
     column = Diffused_column_for_dec(i*lencgth(1)+1:(i+1)*lencgth(1)); 
     if(mod(i+1, 2)==1)
        I_reformed_again_dec(:,i+1) = column;
     else
         column = flip(column);
         I_reformed_again_dec(:, i+1) = column;
     end
end


%DEcrypt Scan the image row-wise in alternate orienctations
Psudo_counter = 1;
I_Row_dec = zeros(1,numel(I_reformed_again_dec));
lencgth = size(I_reformed_again_dec);
for i = 1:1:lencgth(1)
    row_vector = I_reformed_again_dec(i,:);
    if(mod(i,2)==1)
        for j = 1:1: numel(row_vector)
        I_Row_dec(Psudo_counter) = row_vector(j);
        Psudo_counter = Psudo_counter+1;
        end
    else
        row_vector = flip(row_vector);
        for j = 1:1: numel(row_vector)
        I_Row_dec(Psudo_counter) = row_vector(j);
        Psudo_counter = Psudo_counter +1;
        end
    end
    
end


%Backward diffusion reverse
lencgth = numel(I_Row_dec);
Diffused_row_bac_dec = zeros(1,numel(enc));
for i = 1:1:lencgth
    E = I_Row_dec(i);
    if(i+1 == lencgth+1 && i+2 == lencgth+2)
        F2 = 2;
        F1 = 1;
    elseif(i+2 ==lencgth+1)
        F2 = 1;
        F1 = I_Row_dec(i+1);
    else  
    F2 = I_Row_dec(i+2);
    F1 = I_Row_dec(i+1);
    end
    R1_num = R1_DEC(i);
    R2_num = R2_DEC(i);
    Diffused_row_bac_dec(i) = backward_diffusion_reverse(E,F2,F1,R1_num,R2_num);
end

%forward diffusion reverse
lencgth = numel(Diffused_row_bac_dec);
Diffused_row_for_dec = zeros(1,numel(enc));
for i = lencgth:-1:1
    E = Diffused_row_bac_dec(i);
    if(i-1 == 0 && i-2 == -1)
        E2 = 2;
        E1 = 1;
    elseif(i-2 ==0)
        E2 = 1;
        E1 = Diffused_row_bac_dec(i-1);
    else  
    E2 = Diffused_row_bac_dec(i-2);
    E1 = Diffused_row_bac_dec(i-1);
    end
    R1_num = R1_DEC(i);
    R2_num = R2_DEC(i);
    
     Diffused_row_for_dec(i)= forward_diffusion_reverse(E,E2,E1,R1_num,R2_num);
    
end

%DECRYPTION Turning back to M*N image from an array for next stage 
lencgth = size(enc);
I_reformed_DEC = zeros(lencgth(1),lencgth(2));
for i = 0:1:lencgth(1)-1
     row = Diffused_row_for_dec(i*lencgth(2)+1:(i+1)*lencgth(2)); 
     if(mod(i+1, 2)==1)
        I_reformed_DEC(i+1,:) = row;
     else
         row = flip(row);
         I_reformed_DEC(i+1,:) = row;
     end
end


dec = I_reformed_DEC;

end