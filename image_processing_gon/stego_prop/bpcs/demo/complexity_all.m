function [g,rat] = complexity_all(a,val,mode)
ll = val;
[M ,N] = size(a);
im_1= zeros(M,N);
im_2= zeros(M,N);
im_3= zeros(M,N);
im_4= zeros(M,N);
im_5= zeros(M,N);
im_6= zeros(M,N);
im_7= zeros(M,N);
im_8= zeros(M,N);
% a_dec = a-floor(a+0.002);
% a = floor(a+0.002);
% a = pbc_to_cgc(a);
for j = 1:1:M
    for k = 1:1:N
        pix = a(j,k);
        pix_bin = de2bi(pix,8,'left-msb');
        im_1(j,k) = pix_bin(8);
        im_2(j,k) = pix_bin(7);
        im_3(j,k) = pix_bin(6);
        im_4(j,k) = pix_bin(5);
        im_5(j,k) = pix_bin(4);
        im_6(j,k) = pix_bin(3);
        im_7(j,k) = pix_bin(2);
        im_8(j,k) = pix_bin(1);
    end
end

G = zeros(3,8);
[G(1,1),G(2,1)] = complexity(im_1);
[G(1,2),G(2,2)] = complexity(im_2);
[G(1,3),G(2,3)] = complexity(im_3);
[G(1,4),G(2,4)] = complexity(im_4);
[G(1,5),G(2,5)] = complexity(im_5);
[G(1,6),G(2,6)] = complexity(im_6);
[G(1,7),G(2,7)] = complexity(im_7);
[G(1,8),G(2,8)] = complexity(im_8);

for i = 1:8
    if( G(1,i) >= 0.42 && G(2,i) >=2.2)
        G(3,i) = 1;
    end
end
% count = 9;
% while(count>1)
%     [x,y] = find(G==max(G(1,:))) ;
%     count = count-1;
%     if(G(3,y(1,1))==1)
%         break;
%     else
%         G(x,y(1,1))=0;
%     end
% end
[g1,g2] = complexity(val);
if( g1 < 0.42 || g2 <2.2)
    val = conj_n(val);
    val(1,1) = 1;
%     val = mat_diff5(val);    
    [g1,g2] = complexity(val);
end

if( g1 < 0.42 || g2 <2.2)
    g1;
end

y = -1;
rat = -1;
if(G(3,mode)==1)
   y = mode; 
   rat = 1;
end

switch y(1,1)
    case 1
        im_1 = val;
    case 2
        im_2 = val;
    case 3
        im_3 = val;
    case 4
        im_4 = val;
    case 5
        im_5 = val;
    case 6
        im_6 = val;
    case 7
        im_7 = val;
    case 8
        im_8 = val;

end
im_10 = im_8*128 + im_7*64 +im_6*32+im_5*16+im_4*8+im_3*4+im_2*2+im_1*1;
 im_10 = cgc_to_pbc(im_10);

g = im_10;
end