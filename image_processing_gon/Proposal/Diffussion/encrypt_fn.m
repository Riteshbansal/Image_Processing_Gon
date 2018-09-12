function e = encrypt_fn (forth,pix)
N = numel(forth);
e = size(forth);
forth = bitxor(forth,pix);
while(N>=1)
    stream_cipher = forth';
    stream_cipher = stream_cipher(:);
    pix = pix';
    pix = pix(:);
    e = [stream_cipher,pix];
    e = circshift(e,-shift_count,2);
    N=N-1;
end
end