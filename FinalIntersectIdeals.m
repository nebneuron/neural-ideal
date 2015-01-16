function [Ideal,t] = FinalIntersectIdeals(L,r)
%-------------------------------------------------------------------------
%This function takes a L, a matrix with rows representing
%the pseudo-monomials of an ideal and r, a vector representing the prime ideal
%for one codeword,
%and intersects them assuming the ideals are binary. In the matrices
%xi is represented by 0, (1-xi) is represented by 1,
%and if neither term appears, that is represented with a 5.

%Ideal is the resulting intersected ideal, and t is the number of
%operations that occurred.
%-------------------------------------------------------------------------


n = size(L,2);
m = size(L,1);
I = ones(m*n,n)*5;
k=1;
w=1;
L0=ones(0,n);

%if any element in any row of L matches a monomial in r, put that row in I
%otherwise, multiply it by each monomial in r in the next step
for i=1:m
    if (size(find((L(i,:)+r)==2),2)>0 || size(find((L(i,:)+r)==0),2)>0)
        I(k,:)=L(i,:);
        k=k+1;  
    else
        L0(w,:)=L(i,:);
        w=w+1;
    end    
end

k1=k-1; %number of ideals in L to keep in I
w=w-1; %number of ideals to intersect
t=0; %operation tracker

%go through and multiply each pseudomon in L0 by each prime in r
%unless it is a multiple of a prime already in I
for i=1:w
    for j=1:n
        if L0(i,j)==5   %otherwise, we get xi(1-xi)
            I(k,:)=L0(i,:); %put the i’th row of L0 in the new ideal
            I(k,j)=r(j);    %multiply it by the j’th monomial of r
            if k>1
                M=0; %is it a multiple of something?
                for l=1:k1;
                    t=t+1; %operation tracker
                    diff = I(l,:)-I(k,:);
                    if size(find(abs(diff)==1),2)==0 %if we do not have xi and 1-xi
                        if size(find(diff<-1),2)==0 %and there are no extra terms in the old ideal
                            M=1; % then yes, this is a multiple of something in our list
                            break; %definitely not going to put it in, so just stop
                        end
                    end
                end
                if M==0 %no multiples, move on
                    k=k+1;
                end
            else % if k is 1 or 2, 
                k=k+1;
            end
        end
    end
end
Ideal = I(1:k-1,:);

            
           
        
    
        
        
