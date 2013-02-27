function CF = PMideal2CanonicalForm(P)

% takes a pseudo-monomial ideal in ternary matrix form and returns the canonical
% form of that matrix, also in ternary matrix form.

%INPUT
% P = pseudo-monomial ideal, in ternary vector form

%OUTPUT
% CF = canonical form pseudo-monomial ideal, as a list of
%      polynomials in ternary vector form (rows)
%      each column corresponds to a variable/neuron in the ring

% first, compute the primary decomposition
PD=PrimaryDecomp(P);

% next, compute canonical form
CF=CanonicalForm(PD);    

    