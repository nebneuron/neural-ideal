function [CF,MAT] = Code2CF(C)
%----------------------------------------------------------------------
%Loops through intersecting ideals until we have the canonical form.
%
%INPUT: 
%C: a binary matrix whose rows are codewords, of length n

%OUTPUT:
%CF: canonical form  in pseudo-monomial format (Automatic)

%MAT: the matrix form storing canonical form information. (Optional)
%       Each row represents a pseudo-monomial;  1 in the ith position 
%       (for i <= n) indicates x_i is a factor; 1 in the ith position 
%       (for i>n) indicates (1-x_{i-n}) is a factor.
%
%t: the number of operations it performed, used for time complexity
%analysis (Not Currently Used)

L=diag(C(1,:))+ones(size(C,2),size(C,2))*5-eye(size(C,2))*5;
[I,t]=FinalIntersectIdeals(L,C(2,:));

for i=3:size(C,1)  
    r=C(i,:);
    [I,t0]=FinalIntersectIdeals(I,r); %compute repeated intersections
    t=t+t0;
end

[a,b]=size(I);  % Here we rewrite the final information to
M=zeros(a,2*b); % an easier-to-read matrix format 
for i=1:a
    for j=1:b
        if I(i,j)==1
            M(i,j+b)=1;
        elseif I(i,j)==0
            M(i,j)=1;
        end
    end
end
    

CF=Prettify(M);
MAT=M;



