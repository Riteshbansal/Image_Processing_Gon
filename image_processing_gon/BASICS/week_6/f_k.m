function [R,f] = f_k(k,h_fft,Y_fft,beta)
R = zeros(size(Y_fft,1),size(Y_fft,2));
for i = 1:1:size(Y_fft,1)
    for j = 1:1:size(Y_fft,2)
        if(abs(h_fft(i,j)~=0))
            
            R(i,j) = 1/h_fft(i,j);
        else
            R(i,j) = beta*k;
            
        end
    end
    
end


f = R.*Y_fft;
% im2 = ifft2(fftshift(f));
% imshow(mat2gray(abs(im2)));
% k1 = 1:1:size(Y_fft,1);
% k2 = 1:1:size(Y_fft,2);
% [k1,k2] = meshgrid(k1,k2);
% l1 = abs(R);
% l2 = abs(h_fft);
% mesh(k1,k2,(mat2gray(abs(R))));
% mesh(k1,k2,(mat2gray(abs(h_fft))));

end