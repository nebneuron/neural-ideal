function[ D ] = Compress(D)

% Compress removes empty matrices from a 1xd cell array D. 

% INPUT
% D = a 1xd cell array

%OUTPUT
% D = a 1x c cell array with no empty slots.

d=size(D,2);
L=[];
for i=1:d
    if isempty(D{i})==1
        L=[L,i];
    end
end
D(L)=[];
end

        