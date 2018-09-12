clc
clear
% %  pix = 4;
% %  pix_bin = de2bi(pix,8,'left-msb');
% 
% i = [0,0,1,1];
% i2 = im2uint8(i);
% i3 = uint8(i);
%% groupsSortA = dSortA ~= 0;

% a= [1,2,3,4,5];
% g= a~=0;

%% c = sortA(groupsSortA);         % Create unique list by indexing into sorted list.
%  Here "groupsSortA" is a array of logical 1 and 0 and "sortA" is an
%  array, elements whose corrosponding value is 1, will be copied to "c"
%% ROW SORT
% a= [2,2,3;2,1,3];
% b= sortrows(a);

%% Comparing Rows elements of a same matrix with out loops
%     groupsSortA = sortA(1:numRows-1,:) ~= sortA(2:numRows,:);
% numRows  = 3;
% a= [1,2,3;1,5,6;7,8,9];
% groupsSortA = a(1:numRows-1,:) ~= a(2:numRows,:);
