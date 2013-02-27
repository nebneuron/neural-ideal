function [D] = Complement( C )

% Complement takes a code C of length n as a k x n binary matri
% and returns its complement as a 2^n - k x n binary matrix.

%INPUT
%C = a binary matrix with n columns

%OUTPUT
% D = a binary matrix with all possible binary rows of length n which don't
%       appear in C

c=size(C);

n=c(2);

B=[0:2^n-1]';
D=rem(floor(B*pow2(-(n-1):0)),2);  % list all binary vectors of length n

d=2^n;
for i=1:c(1)
    for j=1:d
        if C(i,:)==D(j,:)   %remove those that are in C.
            D(j,:)=[];
            d=d-1;
            break
        end
    end
end

            
end

