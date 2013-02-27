function[n]= SameRows(A,B)

% SameRows compares matrices A and B with the same number of columns
% to see if they have the same set of rows, 
% (i.e., the same set of generators: see IdealDoc)

% Input:
% A, B  = two matrices with the same number of columns

% Output: 
% n = 1 if A,B have the same set of rows in some order
%   = 0 if A, B do not have the same set of rows in any order.

n=0;

C=[isempty(setdiff(A,B,'rows')),isempty(setdiff(B,A,'rows'))];
if C==ones(1,2);
    n=1;
end
end
