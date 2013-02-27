function[P] = RemoveRedundancy(P)

% See IdealDoc.

% RemoveRedundancy takes a collection of prime ideals and removes
% those that properly contain others, (and hence are unnecessary in a primary
% decomposition) as well as those that are 
% repeated.  This is based solely on the given generators and thus is 
% possibly not a complete process.
% 

%INPUT
% P = a 1 x c cell array of ternary matrices with exactly one non-2 entry per row.

%OUTPUT
% P = a 1 x d cell array of ternary matrices with exactly one non-2 entry per
%     row, with no duplicates or unnecessary matrices for the intersection.


P=RemoveRepeat(P); % remove simple multiples

p=size(P,2);

for i=1:p            %this part removes prime ideals with both
    M=P{i};             % x_i and 1-x_i as generators (i.e., not proper!)
    m=size(M);
    for j=1:m(2)
        if isempty(find(M(:,j)==1))~=1 && isempty(find(M(:,j)==0))~=1
                P{i}=[];
                break
        end
    end
end

P=Compress(P); %remove empty slots



p=size(P,2);                            % this part removes ideals which are
for i=1:p                         % unnecessary as they contain others
    if isempty(P{i})~=1               % and thus don't add anything to the
    for j=1:p                      % intersection.
        if i~=j && isempty(P{j})~=1
            if isempty(setdiff(P{i},P{j},'rows'))==1
                P{j}=[];
            end
        end
    end
    end
end
P=Compress(P);  % remove empty slots