function[CF, sigma, savename] = Code2CanonicalForm(filename, tag, sigma)

% Code2CanonicalForm takes a file containing a binary code C and saves
% a file containing the canonical form of the ideal corresponding to that
% code.

%INPUT
%filename  = the name of the .mat file containing the code C - this file 
%            should live in the NeuralCodes folder.
%tag = an optional input to name the code if it's nonstandard.
%sigma = a row vector of indices to which we wish to restrict;
%           the indices should not exceed the length of C

%OUTPUT
%CF = the canonical form of C in ternary matrix form.
%sigma = the same set of indices as were input.  If no sigma was input,
%      this will be the vector [1,...,n]
%savename = the name of the file in the CanonicalForms folder where the
%           .mat file contianing the canonical form will be found.

filename2 = ['NeuralCodes/',filename];
load(filename2, 'C')

c = size(C,2); % total number of variables/indices for code

if nargin<2 || isempty(tag)==1
    tag = '';
end

if nargin<3
    sigma = 1:c;
end

% restrict code, if needed
if length(sigma) < c
    C = RestrictCode(C,sigma);
end;

P=Complement(C);
CF = PMideal2CanonicalForm(P);

% save results
savename = ['CanonicalForms/' filename '_' tag '_CF'];
save(savename,'CF','C','sigma','filename')