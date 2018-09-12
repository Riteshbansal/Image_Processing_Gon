function im1 = enc_edgy(im,val)

[row,col]=size(im);

for i = 1:1:row
    for j = 1:1:col
        temp = im((i),(j));
        im((i),(j)) = pix_mod(temp,val(i,j));
        
    end
end

im1 = im;

end