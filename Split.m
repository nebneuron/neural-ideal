function[C] = Split(D)
 
% See IdealDoc.  Split performs steps 2.1-3.3 in the Primary Decomposition
% algorithm from the Neural Ring paper.  
% Split takes a pseudo-monomial ideal and splits it along its first
% nonlinear generator into several ideals, which are put in a cell array.


% INPUT
% D = p-m ideal which is not prime (has at least one nonlinear generator)
%      in ternary matrix form (i.e. at least one row has two non-2
%      entries.)

% OUTPUT
% C = a cell array of the matrices D was split into.

d=size(D);
C={};


% Pick a row of D with at least two non-2 entries (a generator
% with at least degree 2)

for i=1:d(1)
    F=find(D(i,:)==2);
    f=size(F,2);
    if f < (d(2)-1)
        n=i;
        break
    end
    
end

% Split D along that generator:

for i=1:d(2)
    if D(n,i)~=2
        l=D(n,i);
        E=D;
        M = E(:,i)==l; 
        E(M,:)=[];      %sets z_i=0;(removes multiples of z_i)
        N = E(:,i)==1-l; 
        E(N,i)=2;       %sets z_i=0 (sets 1-z_i=1)
        
        e=size(E);
        E=[E;2*ones(1,e(2))]; 
        E(e(1)+1,i)=l;         %puts z_i as the last generator
        
        E=Reduce(E); % Reduce E by removing multiples of generators
        if NotProper(E)~=1 % Check for proper here by checking if 1 is a generator now
            C=[C,{E}];  % Append to C if it's proper (D_I in the paper)
        end 
    end
end   


end
