# GeneratingSetToCF

Code for converting a set of pseudomonomials to the canonical form of the ideal
that they generate.

# Overview

The code represents a pseudomonomial in n variables as an array of length n 
with entries from {0, 1, 2}. The value at index i corresponds to the factor 
of the pseudmonomial as follows:
 * 0 means x_i is a factor
 * 1 means (1-x_i) is a factor
 * 2 means the pseudomonomial does not depend on x_i

# Documentation of functions

The code provides several overarching functions as well as many smaller tools
which may be of general use. All are documented below, as well as within the 
code itself.


##### `remove_codeword(CF, codeword, verbose = False)`

Takes a canonical form `CF` for some code C, and uses it to 
compute the canonical form for C without `codeword`. It does this by attempting
to combine the indicator polynomial for `codeword` with the various polynomials
in `CF` until no further reductions/combinations can be made. You can pass the 
verbose parameter as True to receive output at each step in the process.


##### `generating_set_to_CF(GS, verbose = False)`

Takes a generating set `GS` of pseudomonomials and computes the
canonical form of the ideal they generate. It does so by pairwise combining
the pseudomonomials in `GS` and removing redundancies with respect to 
divisibility until no further reductions/combinations can be made. You can pass
the verbose parameter as True to receive output at each step in the process.


##### `remove_redundancies(GS)`

Removes all redundancies with respect to division from a set of
pseudomonomials `GS` and returns the resulting redundancy-free set.


##### `is_redundant_to(f, GS)`

Checks if `f` is a multiple of any pseudmonomial in `GS`. Returns
True of `f` is, and False otherwise.


##### `divides(f, g)`

Returns True if `f` divides `g` and False otherwise. Both `f` and
`g` must be pseudomonomials. 


##### `combine(f1, f2)`

Attempts to add two pseudomonomials (or possibly their multiples) to yield
a new pseudomonomial which is not a multiple of either `f1` or `f2`. For
example we can combine `x1(1-x2)` and `x2(1-x3)` to obtain `x1(1-x3)`, since
`x1(1-x2)(1-x3) + x1x2(1-x3) = x1(1-x3)`.


##### `format_pseudomonomial_list(pseudomonomials)`

Converts a list of pseudomonomials to a readable string for printing.


##### `format_pseudomonomial(pseudomonomial)`

Converts a single pseudomonomial to a readable string for printing.


##### `indicator(c)`

Returns the indicator pseudomonomial for a codeword `c`.


##### `indicators(C)`

Returns a set that contains the indicator pseudomonomials for every vector
which is *not* in the code `C`. Note that this is a generating set for the
neural ideal of `C`.


##### `complete_code(n)`

Returns the complete code on `n` bits. Used for computing complements of codes.