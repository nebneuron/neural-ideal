function[B] = Reduce(A)

% See IdealDoc.
% Reduce take a pseudo-monomial ideal written in matrix form and removes
% generators which are multiples of other generators.

% INPUT
% A = a ternary matrix representing a pseudo-monomial ideal


% OUTPUT
% B = a ternary matrix representing the same pseudo-monimial ideal with all
%     generators which are multiples of other generators removed.

a=size(A,1);

B=RemoveMult(A);  % remove a multiple, return B
b=size(B,1);

while a > b     % and do it again until the matrix you get back does not change
    A = B;
    a=size(A,1);
    B = RemoveMult(A);
    b=size(B,1);
end

end

