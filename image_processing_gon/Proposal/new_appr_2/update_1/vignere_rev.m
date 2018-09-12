function [ Image_change_dec ] = vignere_rev( I_gr,xlog )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%matrix vignor 2
size_matrix = size(I_gr);

vig2 = zeros(256,256);
for i=1:1:256
vig2(1,i) =  i;
end

vig2(1,:) = confusion_impl2(vig2(1,:),xlog(1));
xlog = 1+floor(mod(xlog*10^6,255));
vig2(1,:) = circshift(vig2(1,:),-xlog(1),2);

for i = 2:1:256
    temp(1,:) = vig2(1,:);
    temp = circshift(temp,-xlog(i),2); 
    vig2(i,:) = temp(1,:); 
end

% %  count = 1;
% % for i = 2:1:256
% %     temp(1,:) = vig2(1,:);
% %     temp = circshift(temp,-count,2); 
% %     vig2(i,:) = temp(1,:); 
% %     count= count+1;
% % end
 
%  [xsin,xlog] = chaotic_map(0.6,I_gr);
% xsin = 1+floor(mod(xsin(3:end)*10^6,255));
xlog = reshape(xlog,size(I_gr,1),size(I_gr,2))';

I_gr = I_gr +1;

Image_change_dec(:,:) = I_gr(:,:);
    vig_arr =  vig2(xlog(1,1),:);
    Image_change_dec(1,1) = find(vig_arr== I_gr(1,1),1);
       

for i = 1:1:size_matrix(1);
    if(i~=1)
        vig_arr =  vig2(xlog(i,1),:);
        Image_change_dec(i,1) =  find(vig_arr==I_gr(i,1),1);
    end
   for j = 2:1:size_matrix(2)
       vig_arr =  vig2(xlog(i,j),:);
       x =  find(vig_arr==I_gr(i,j),1);
       Image_change_dec(i,j) = x;
   end    
end
Image_change_dec = Image_change_dec-1;


end

