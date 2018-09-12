function im1 = enc_edgy_rev(im)

[row,col]=size(im);
im1 = zeros(size(im));
for i = 1:1:row
    for j = 1:1:col
        temp = im((i),(j));
        im1((i),(j)) = pix_mod_rev(temp);
        
    end
end

end