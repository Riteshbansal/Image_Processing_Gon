function meshgrid_show(img)
[r,c] = size(img);
[k1,k2] = meshgrid(1:r,1:c);
figure(),mesh(k1,k2,img);
end