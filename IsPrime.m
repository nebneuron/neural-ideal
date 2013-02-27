function[n] = IsPrime(D)
   
% See IdealDoc.  
% IsPrime takes a matrix D representing an ideal and tests if it is prime,
% returning 1 if so and 0 if not. (It tests this only by looking to see if 
% each generator polynomial has degree 1 which is not equivalent to the
% usual definition of prime.  Nor does it test if the ideal is proper.)

%INPUT
% D = a ternary matrix D representing a pseudo-monomial ideal.

%OUTPUT
% n = an indicator variable which takes value 1 if D is prime (has only
%     linear generators) and 0 otherwise.

[r,c]=size(D);
n=1;

%check each row to see if the number of 2's is exactly the number of
%columns minus 1.
for i=1:r
    M=find(D(i,:)==2);
    m=size(M,2);
    if m ~= c-1
        n=0;
        break
    end
end
end
