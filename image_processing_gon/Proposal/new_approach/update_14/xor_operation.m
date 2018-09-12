function [ r_enc_dup ] = xor_operation( r_enc )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

m1 = zeros(size(r_enc));
m1(r_enc<0) = 1;

r_enc_dup = abs(r_enc);

r_enc_dup_deci = abs(r_enc_dup-floor(r_enc_dup+0.002));
r_enc_dup = floor(r_enc_dup+0.002);
% r_enc_dup = r_enc_dup-1;
r_enc_dup = bitxor(r_enc_dup,255);
r_enc_dup = r_enc_dup + r_enc_dup_deci;
r_enc_dup(m1==1) = r_enc_dup(m1==1).*-1;
end

