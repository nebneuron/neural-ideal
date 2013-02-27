function[m] = NotProper(D)

%See IdealDoc.  
% NotProper tests the ideal represented by the matrix D to see if
% it has 1 as a generator.  It returns 1 if it has 1 as a generator and
% thus is not proper.  It otherwise returns 0, though it should be noted
% that a return of 0 doesn't necessarily mean the ideal is proper.

%INPUT
% D = a ternary matrix representing a pseudo monomial ideal

%OUTPUT

% m = an indicator variable which will take value 0 if D has 1 as a
%     generator, 0 otherwise.

[r,c]=size(D);
m=0;

for i=1:r;
    if D(i,:)==2*ones(1,c)   %check for a row of 2's
        m=1;
        break
    end
end
end
