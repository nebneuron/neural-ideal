function[] = DisplayCanonicalForm(savename)

% takes the name savename of a file from the CanonicalForms folder and displays the
% polynomials of the canonical form found therein.

savename2=['CanonicalForms/',savename];

load(savename2, 'CF', 'sigma')

Prettify(CF, sigma)

end


