function code = symbol_huff(mat)
%% elements
el = mat(:,1);
prob = mat(:,2);
x = numel(el);
y= tree_creation(prob);
global co
co= cell(x,1);
code = code_gen(y,[]);


%% Code
% if( x>2)
%     z = mat(:,1);
%     siz = numel(mat(:,1));
%     z(siz-1) = z(siz-1)+z(siz);
%     z(siz) = [];
%     z = sort_personal(z,1);
%     z = symbol_huff(z);
%     
% else
%     a = {'0';'1'};
%     b = num2cell(mat);
%     code = cat(2,b,a);
% end

end

%%
function y = tree_creation(prob)
x = numel(prob);
c = cell(x,1);
for i=1:x				
   c{i}=i;		
end
z(:) = prob(:);
while x>2
    [z,i] = sort(z,'descend');
    siz = numel(z);
    z(siz-1) = z(siz-1)+z(siz);
    z(siz) = [];
    c = c(i);
    c{siz-1}={c{siz-1},c{siz}};c(siz)=[];
    [z,i] = sort(z,'descend');
    c = c(i);
    x=x-1;
end

y=c;
end

%%
function co1 = code_gen(a, dum)
global co
if isa(a,'cell')
         code_gen(a{1},[dum 0]);
         code_gen(a{2},[dum 1]);
else   
   co{a}=char(48+dum);   
end
co1=co;

end