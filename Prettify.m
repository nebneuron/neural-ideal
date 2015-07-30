function[D] = Prettify(C)

% Given a canonical form in matrix form C
%where the first half of the digits are x_i's and
%the second half are 1-x_i's,
%this now returns the set of polynomials which correspond to that matrix
%written as strings.  

%INPUT
% C = a binary matrix representing a pseudo-monomial ideal.

% OUTPUT
% D = a list of strings giving the pseudo-monomials that C encodes.

c=size(C);
d=c(2)/2;

%if nargin < 2,
%    sigma = 1:c(2);  % set the default sigma to be [1,...,n]
% end


D=[];
for s=1:c(1)   % for each row         
    var=[];
    for j=1:d,  %consider the first half
        if C(s,j)==1   %write 1's  as corresponding x_i
          var = [var,'x',num2str(j)];  
        end
        
    end
    
    for i=d+1:c(2)      %consider the second half
        if C(s,i)==1    %write 1's as corresponiding (1-x_i)
            var = [var, '(1-x',num2str(i-d),')'];
        end                                 
    end
    D=char(D,var);
end
end
