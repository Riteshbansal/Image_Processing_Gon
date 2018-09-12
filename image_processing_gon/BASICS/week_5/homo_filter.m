clc
clear all
I = double(imread('AT3_1m4_01.tif'));
% imshow(I);
[M, N] = size(I);
I1 = log(1+I);

%% LPF
fil = ones(3,3);
fil = fil/9;
[m, n] = size(fil);
I_fft = fft2(I1,M+m-1,N+n-1);
H_fft = fft2(fil,M+m-1,N+n-1);
Iout_lpf = real(ifft2(I_fft.*H_fft));
sigma = 0.5;
Iout_lpf_si = Iout_lpf.^sigma;
imshowpair((I), (real(exp(Iout_lpf_si) - 1)), 'montage')

%% HPF
fil_2 = [-1,-1,-1;-1,9,-1;-1,-1,-1];

[m, n] = size(fil_2);
I_fft_1 = fft2(I1,M+m-1,N+n-1);
H_fft_1 = fft2(fil_2,M+m-1,N+n-1);

Iout_hpf = real(ifft2(I_fft_1.*H_fft_1));
sigma = 2;
Iout_hpf_si = Iout_hpf.^sigma;
imshowpair((I), (real(exp(Iout_hpf_si) - 1)), 'montage')

%% adding
I_re = Iout_hpf_si + Iout_lpf_si;
Ihmf_2 = real(exp(I_re) - 1);

imshowpair((I), im2uint8(Ihmf_2), 'montage')
