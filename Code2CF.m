function [CF,t] = Code2CF(C)
%----------------------------------------------------------------------
%Loops through intersecting ideals until we have the canonical form.

%C: set of codewords, number of codewords by number of neurons

%CF: canonical form represented by 0's (xi) 1's (1-xi) and 5's (nothing)

%t: the number of operations it performed, used for time complexity
%analysis

L=diag(C(1,:))+ones(size(C,2),size(C,2))*5-eye(size(C,2))*5;
[I,t]=FinalIntersectIdeals(L,C(2,:));

for i=3:size(C,1)
    r=C(i,:);
    [I,t0]=FinalIntersectIdeals(I,r);
    t=t+t0;
end
CF=I;

                

