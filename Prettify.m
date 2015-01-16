function[D] = Prettify(C,sigma)

% Given an ideal in matrix form C and (optionally) a set of indices,
%Prettify returns the set of polynomials which correspond to that matrix
%written as strings.  sigma gives the appropriate set of indices so sigma
%should have the same length as there are columns in C.

%INPUT
% C = a ternary matrix representing a pseudo-monomial idea
% sigma = a set of indices we want the matrix to correspond to.

% OUTPUT
% D = a list of strings giving the pseudo-monomials that C encodes.

c=size(C);

if nargin < 2,
    sigma = 1:c(2);  % set the default sigma to be [1,...,n]
end


D=[];
for s=1:c(1)   % for each row
    k=C(s,:);         
    var=[];
    M=find(k==1);   % find the 1's
    m=size(M); 
    N=find(k==0);  % find the 0's
    for j=1:m(2),                                %write them as 1-x_i
          var = [var,' (1-x',num2str(sigma(M(j))),')'];  % with the appropriate index from sigma
    end
    
    n=size(N);
    for i=1:n(2)                                    % write them as x_i
	  var = [var, ' x',num2str(sigma(N(i)))]; % with the appropriate index from sigma
    end
    D=char(D,var);
end
end
