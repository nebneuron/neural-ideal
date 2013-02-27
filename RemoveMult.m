function [ A ] = RemoveMult(A)

% See IdealDoc.
% RemoveMult searches for one single generator (row) which is superfluous as it is
% the multiple of another generator, and removes it.

%INPUT
% A = a ternary matrix representing a pseudo-monomial ideal

%OUTPUT
% A = the same matrix, with one multiple removed if there were any
%      multiples at all.  (if none, returns the original matrix.)

r=size(A,1);
flag = 0;

for i=1:r-1
    for j=i+1:r
        M=A(i,:);
        N=A(j,:);
        c=find(M~=N);  %find where the two rows are different
        b=size(c,2);
        if N(c) == 2*ones(1,b)   % if row N is all 2's on those places
           A(i,:)= [ ];           % then row M is a multiple of N;
           flag = 1;              % remove it
           break
        elseif M(c)== 2* ones(1,b)  % similar check for row M
            A(j,:)=[ ];
            flag = 1;
            break
        end
        if flag == 1       % if we removed any row
            break          % quit
        end
    end
    if flag ==1
        break
    end
end
                       
            
end

