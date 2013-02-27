function RC = RestrictCode(C,sigma)

%Given a code C and a subset sigma of indices, RestrictCode returns the code
%restricted to those indices, with multiples removed.

%INPUT
% C = a code of vectors of the same length
% sigma = a subset of indices

%OUTPUT
% RC = the code C with the entries corresponding to indices in sigma only.
%      RC will have length equal to that of sigma.  No vectors will be
%      repeated.

RC = unique(C(:,sigma),'rows');