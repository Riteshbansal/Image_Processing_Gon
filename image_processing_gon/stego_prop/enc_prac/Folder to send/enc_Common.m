function enc = enc_Common(orig,xlog1,ylog1,zlog1)


twicw_Psudo_random = RC4Psudono(zlog1, 2*numel(orig));
% % tic
% % stream_rc6=rc6_stream(zlog1,2*numel(orig));
% % toc
% % diffusion stage


% 2(M * N) pseudorandom numbers
R1 = twicw_Psudo_random(1,1:numel(orig));
R2 = twicw_Psudo_random(1,numel(orig)+1:numel(twicw_Psudo_random));


% % Scan the image row-wise in alternate orientations
I_Row = [];
length = size(orig);
for i = 1:1:length(1)
    row_vector = orig(i,:);
    if(mod(i,2)==0)
        row_vector = flip(row_vector);
    end
    
    I_Row = [I_Row row_vector];
end

%9

% % forward diffusion
length = numel(I_Row);
Diffused_row_for = zeros(1,numel(orig));
for i = 1:1:length
    P = I_Row(i);
    if(i-1 == 0 && i-2 == -1)
        E2 = 2;
        E1 = 1;
    elseif(i-2 ==0)
        E2 = 1;
        E1 = Diffused_row_for(i-1);
    else  
    E2 = Diffused_row_for(i-2);
    E1 = Diffused_row_for(i-1);
    end
    R1_num = R1(i);
    R2_num = R2(i);
    
     Diffused_row_for(i)= forward_diffusion(P,E2,E1,R1_num,R2_num);
    
end

%10

% % Backward diffusion
length = numel(Diffused_row_for);
Diffused_row_bac = zeros(1,numel(orig));
for i = length:-1:1
    E = Diffused_row_for(i);
    if(i+1 == length+1 && i+2 == length+2)
        F2 = 2;
        F1 = 1;
    elseif(i+2 ==length+1)
        F2 = 1;
        F1 = Diffused_row_bac(i+1);
    else  
    F2 = Diffused_row_bac(i+2);
    F1 = Diffused_row_bac(i+1);
    end
    R1_num = R1(i);
    R2_num = R2(i);
    Diffused_row_bac(i) = backward_diffusion(E,F2,F1,R1_num,R2_num);
end

%11

% % Turning back to M*N image from an array for next stage 
length = size(orig);
I_reformed = zeros(length(1),length(2));
for i = 0:1:length(1)-1
     row = Diffused_row_bac(i*length(2)+1:(i+1)*length(2)); 
     if(mod(i+1, 2)==1)
        I_reformed(i+1,:) = row(:,:);
     else
         row = flip(row);
         I_reformed(i+1,:) = row(:,:);
     end
end

%12

% % Scan the image column-wise in alternate orientations
Psudo_counter = 1;
I_column = [];
length = size(I_reformed);
for i = 1:1:length(2)
    column_vector = I_reformed(:, i);
    if(mod(i,2)==0)
        column_vector = flip(column_vector);
    end
    I_column = [I_column column_vector];
end

%13

% % forward diffusion
length = numel(I_column);
Diffused_row_for = zeros(1,numel(I_reformed));
for i = 1:1:length
    P = I_column(i);
    if(i-1 == 0 && i-2 == -1)
        E2 = 2;
        E1 = 1;
    elseif(i-2 ==0)
        E2 = 1;
        E1 = Diffused_row_for(i-1);
    else  
    E2 = Diffused_row_for(i-2);
    E1 = Diffused_row_for(i-1);
    end
    R1_num = R1(i);
    R2_num = R2(i);
    
     Diffused_row_for(i)= forward_diffusion(P,E2,E1,R1_num,R2_num);
    
end

%14

% % Backward diffusion
length = numel(Diffused_row_for);
Diffused_column_bac = zeros(1,numel(I_reformed));
for i = length:-1:1
    E = Diffused_row_for(i);
    if(i+1 == length+1 && i+2 == length+2)
        F2 = 2;
        F1 = 1;
    elseif(i+2 ==length+1)
        F2 = 1;
        F1 = Diffused_column_bac(i+1);
    else  
    F2 = Diffused_column_bac(i+2);
    F1 = Diffused_column_bac(i+1);
    end
    R1_num = R1(i);
    R2_num = R2(i);
    Diffused_column_bac(i) = backward_diffusion(E,F2,F1,R1_num,R2_num);
end

%15

% % Now turn back to image



length = size(orig);
I_reformed_again = zeros(length(1),length(2));
for i = 0:1:length(2)-1
     column = Diffused_column_bac(i*length(1)+1:(i+1)*length(1)); 
     if(mod(i+1, 2)==1)
        I_reformed_again(:,i+1) = column;
     else
         column = flip(column);
         I_reformed_again(:, i+1) = column;
     end
end

enc = confusion_impl2(I_reformed_again,xlog1,ylog1);

end