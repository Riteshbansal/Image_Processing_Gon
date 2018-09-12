function [ r_enc_dup ] = xor_operation( r_enc,mea)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% m1 = zeros(size(r_enc));
% m1(r_enc<0) = 1;
% r_enc_dup = abs(r_enc);

min_val  = min(min(r_enc)) ;
if(min_val<0)
r_enc_dup = r_enc+min_val;
else
   r_enc_dup = r_enc+0;
 
end

r_enc_dup_deci = abs(r_enc_dup-floor(r_enc_dup+0.002));
r_enc_dup = floor(r_enc_dup+0.002);
% r_enc_dup = r_enc_dup-1;
% if(max(max(r_enc_dup))>255)
%     max_val = max(max(r_enc_dup));
%     [x,y] = find(r_enc_dup==max(max(r_enc_dup)));
% end
% r_enc_dup = vignere(r_enc_dup,xlog);
r_enc_dup = bitxor(r_enc_dup,(256/(mea))-1);
% r_enc_dup = vignere(r_enc_dup,xlog);
r_enc_dup = r_enc_dup + r_enc_dup_deci-min_val;
% r_enc_dup=r_enc_dup-min_val;

% r_enc_dup(m1==1) = r_enc_dup(m1==1).*-1;
% r_enc_dup =confusion_impl2( r_enc_dup,ylog(1));
end

