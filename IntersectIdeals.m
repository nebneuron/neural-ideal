function[ M ]=IntersectIdeals(L,R)


% See IdealDoc.
% IntersectIdeals takes two pseudo-monomial ideals L and R written as ternary 
% matrices and gives their intersection in the same form.  R is assumed
% to be a prime ideal, though L is not.  IntersectIdeals does not
% give the most reduced form of the intersection; it will almost certainly
% have multiples of several generators.

%INPUT
% L = a ternary matrix representing a pseudo-monomial ideal
% R = a ternary matrix representing a prime pseudo-monimial ideal; R will
%     have exactly one non-2 entry per row.

%OUTPUT

% M = a ternary matrix representing the pseudo-monomial ideal which is
%     the intersection of L and R


d=size(L,1);
r=size(R,1);

M=[];

for i=1:d
    for j=1:r
        v=find(R(j,:)~=2); 
        if L(i,v)==R(j,v)   % If the row in L is a multiple of the row in R
            M=[M;L(i,:)];   % keep that generator in L 
            break
        elseif L(i,v)==2    %If not, keep that generator of L but multiply it
            C=L(i,:);       % by that generator of R.
            C(v)=R(j,v); 
            M=[M;C];
        end
    end
end
end

               
             