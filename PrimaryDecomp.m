function[P] = PrimaryDecomp(J)

% See IdealDoc.
% PrimaryDecomp takes an pseudo-monomial ideal J written in matrix form
% and returns its primary decomposition in the form of a cell
% array of matrices.  Each matrix in the primary decomposition ought 
% to be prime. See the Primary Decomposition algorithm in the
% Neura Rings paper for more information. 
% Though some redundancies are removed, it is not yet certain that every
% possible redundancy is removed, so care must be taken.

% INPUT
% J = a ternary matrix representing a pseduo-monomila ideal.

% OUTPUT
% P = a cell array of prime ideals P_i such that J is their intersection.

J=Reduce(J);  %remove multiples of generators
D={J};
P={};

if IsPrime(J)==0; % if it's not prime,
    
    while isempty(D)~=1
        d=size(D,2);
        for i=1:d
            M=Split(D{1,i});   %Create D_I's
            m=size(M);
            for j=1:m(2)
                D{j,i}=M{j};
            end
        end
        
        r=size(D);
        D=reshape(D,1,r(1)*r(2));   %Write D as the union of D_I
        D=Compress(D);         % remove empty slots
        D=RemoveRepeat(D);    %Remove copies of any matrices with
        d=size(D,2);                  %the same set of generators
        
        for i=1:d
            if IsPrime(D{i})==1 %apppends prime ideals to P
                P=[P,{D{i}}];
                D{i}=[];
            end
        end
        D=Compress(D); % remove empty slots
    end
    
    P=RemoveRedundancy(P);  %removes any repeats or redundancy in P
     
else P={J};
end
end
