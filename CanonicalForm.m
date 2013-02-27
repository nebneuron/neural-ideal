function[ M ] = CanonicalForm(P)

% See IdealDoc. This function takes the primary decomposition of an ideal
% written as a cell array  (e.g. the output of PrimaryDecomp)
% and returns the canonical form of the ideal in matrix form. See the
% Neural Ring paper for the definition of canonical form. It is assumed
% that all ideals in the input are prime.

% INPUT
% P = a cell array representing the primary decomposition of
%       pseudo-monomial ideal (all matrices ternary, each row has exactly
%       one non-2 entry

%OUTPUT
% M = a ternary matrix representing the canonical form of a pseudo-monomial
%        ideal

p=size(P);
M=P{1};

for i=2:p(2)
	M=IntersectIdeals(M,P{i}); % take all the possible products
    M=Reduce(M);                % remove multiples
end
end


    
