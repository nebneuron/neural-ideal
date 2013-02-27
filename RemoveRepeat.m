function[ D ] = RemoveRepeat(D)

% This function takes a cell array D and removes those matrices which are
% duplicates of others, leaving only one copy of each.

%INPUT
% D = a cell array of size 1 x n for some n.

%OUTPUT
% D = the cell array containing the  unique matrices in the original D.

d=size(D,2);
for i=1:d-1;
    if isempty(D{i})~=1 
        for j=i+1:d     
            if isempty(D{j})~=1
                if SameRows(D{i},D{j})==1
                D{j}=[];  
                end
            end
        end
        
    end
end
D=Compress(D); % remove the empty slots
end


