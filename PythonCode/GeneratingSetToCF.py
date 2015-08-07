################################################################################
# The code here takes as input a generating set of pseudomonomials             #
# for $J_\C$ and returns the canonical form.                                   #
#                                                                              #
# Throughout we represent pseudomonomials as vectors over ${0,1,2}^n$          #
# where the correspondence is                                                  #
#                 v -> \prod_{v_i = 0} x_i \prod_{v_i = 1}(1-x_i)              #
# Note that this correspondence associates the complement of a                 #
# codeword to its indicator polynomial.                                        #
################################################################################

# A function which takes a canonical form, along with a new codeword to remove
# and attempts to compute the canonical form of the new code. Pass the optional
# verbose parameter as true if you want output at each step.
def remove_codeword(CF, codeword, verbose = False):
    ind = indicator(codeword)
    if is_redundant_to(ind, CF):
        # In this case you're not actually removing a codeword
        print("The codeword "+str(codeword)+" is not in your code to begin with!")
        return CF

    M = CF + [ind]
    new = len(CF)  # Maintain the index at which old things end and
                   # new things start in the list
    if verbose:
        print("################################################################################")
        print("################################################################################")
        print("################################################################################")
        print("STARTING REDUCTIONS. Old CF is " + format_pseudomonomial_list(CF)
                      +" and new indicator is " + format_pseudomonomial(ind))
    while new < len(M):
        currentpm = M[new]
        foundcomb = False
        # look for something old to combine current with
        for i in range(new):
            # attempt to combine with each old thing
            (result, comb) = combine(currentpm, M[i])
            if result == True and not is_redundant_to(comb, M):
                foundcomb = True
                if verbose:
                    print("WE COMBINE " + format_pseudomonomial(currentpm)
                          + " WITH " + format_pseudomonomial(M[i]))
                # remove all multiples of comb, maintaining "new" correctly
                Mprime = []
                for j in range(new):
                    if not divides(comb, M[j]):
                        Mprime = Mprime + [M[j]]
                newprime = len(Mprime)
                for j in range(new, len(M)):
                    if not divides(comb, M[j]):
                        Mprime = Mprime + [M[j]]
                M = Mprime+[comb]
                new = newprime
                break
        if foundcomb == False:
            new = new + 1
        if verbose:
            print("CURRENT SET OF OLD PMs IS: "
                  + format_pseudomonomial_list(M[:new])
                  + ".\nCURRENT SET OF NEW PMs IS: "
                  + format_pseudomonomial_list(M[new:]))
            print("################################################################################")

    return M

# A function that turns generating set into the canonical
# form. You may pass the optional verbose parameter as True if you want output
# at each step in the iteration. 
def generating_set_to_CF(GS, verbose = False):
    iterating_set = GS
    iterating_set = remove_redundancies(iterating_set)
    
    new_polynomials_added = True
    iterations = 0

    # This loop runs until we have added no new polynomials
    while new_polynomials_added:
        iterations = iterations + 1       
        # Give some output if debug is on.
        if verbose == True:
            print("################################################################################")
            print("Starting iteration "+str(iterations)+
                  ". Current generating set is:")
            print(format_pseudomonomial_list(iterating_set))
            
        new_polynomials_added = False
        for i in range(len(iterating_set)):
            for j in range(len(iterating_set)):
                # Attempt to pairwise combine all pseudomonomials in our set
                (result, comb) = combine(iterating_set[i],iterating_set[j])
                # If combination is successful and new pseudomonomial is
                # not a multiple of something we already have, we add it
                # and set the loop to perform another iteration
                if result == True and not is_redundant_to(comb,iterating_set):
                    iterating_set = iterating_set + [comb]
                    new_polynomials_added = True
        iterating_set = remove_redundancies(iterating_set)
    if verbose:
        print("################################################################################")       
            

    return iterating_set

# Function which removes redundant polynomials with respect to division,
# leaving only the minimal ones
def remove_redundancies(GS):
    newGS = []
    for i in range(len(GS)):
        keep = True
        for j in range(len(GS)):
            if i != j and divides(GS[j],GS[i]):
                keep = False
        if keep == True:
            newGS = newGS + [GS[i]]
    return newGS

# Function for checking if a pseudomonomial is a multiple of something
# already in your generating set
def is_redundant_to(f, GS):
    for g in GS:
        if divides(g,f):
            return True
    return False

# Function for checking if pseudomonomials divide each other. Returns
# True if f divides g
def divides(f, g):
    assert len(f) == len(g)
    for i in range(len(f)):
        if f[i] <= 1:
            if f[i] != g[i]:
               return False
    return True

# Function for comparing and possibly combining two pseudomonomials
def combine(f1, f2):
    assert len(f1) == len(f2)
    
    differences = 0     # Counts indices where f1 and f2 differ
    combination = [0]*len(f1) # Combination of f1 and f2, if possible
    
    for i in range(len(f1)):
        if f1[i] == 0:
            if f2[i] == 1:
                differences = differences + 1
                combination[i] = 2
            else:
                combination[i] = 0
        elif f1[i] == 1:
            if f2[i] == 0:
                differences = differences + 1
                combination[i] = 2
            else:
                combination[i] = 1
        elif f1[i] == 2:
            combination[i] = f2[i]
        else:
            assert(False)

    return (differences == 1 and len(f1) != 1, combination)

# Function which makes a list of pseudomonomials formatted nicely for printing
def format_pseudomonomial_list(pseudomonomials):
    formatted = "{"
    for i in range(len(pseudomonomials)):
        formatted += format_pseudomonomial(pseudomonomials[i])
        if i != len(pseudomonomials) - 1:
            formatted = formatted + ", "
    return formatted + "}"

# Function which formats a single pseudomonomial for printing
def format_pseudomonomial(pseudomonomial):
    formatted = ""
    for i in range(len(pseudomonomial)):
        if pseudomonomial[i] == 0:
            formatted = formatted + "x" + str(i+1)
        elif pseudomonomial[i] == 1:
            formatted = formatted + "(1-x" + str(i+1) + ")"
    return formatted

################################################################################

# Returns the indicator pseudomonomial for a codeword c
def indicator(c):
    for i in range(len(c)):
        if c[i] == 1:
            c[i] = 0
        elif c[i] == 0:
            c[i] = 1
        else:
            assert(False)
    return c

# Returns all indicators for the complement of a code C
def indicators(C):
    assert len(C) != 0
    complement = []
    for c in complete_code(len(C[0])):
        if not c in C:
            complement = complement+[c]
    indicators = []
    for c in complement:
        indicators = indicators + [indicator(c)]
    return indicators
        

# Generates {0,1}^n. Stolen from Cha's code.
def complete_code(n):
    if n==1:
        return [[0],[1]]
    else:
        X=[]
        for i in complete_code(n-1):
            X=X+[i+[0]]
        for i in complete_code(n-1):
            X=X+[i+[1]]
        return X
        


# Some tests to see that we actually get what we want. The code below takes a
# code, computes its complement, and then runs generating_set_to_CF on the
# resulting indicator polynomials

codeA5 = [[0,0,0],
          [1,0,0],
          [0,1,0],
          [1,1,0],
          [1,1,1]]

codeA20 = [[0,0,0],[1,1,1]]

# Prints the CF for code A5
# print("CF of A5 is:", format_pseudomonomial_list(
                            # generating_set_to_CF(indicators(codeA5), True)
                                                 # ))

#testcode = [[0,0,0,0,0],
#            [0,1,0,0,1],
#            [1,0,0,0,0],
#            [1,0,1,0,1],
#            [1,1,1,1,0],
#            [0,1,1,1,0]]
#testcode_CF = generating_set_to_CF(indicators(testcode))
#print("Test code CF is " + format_pseudomonomial_list(testcode_CF))
#print(format_pseudomonomial_list(remove_codeword(testcode_CF,[1,1,1,1,0],True)))
#print(format_pseudomonomial_list(remove_codeword([[0,0,0]],[0,1,1],True)))

#generating_set = [[0,1,2,2],
#                  [2,0,1,2],
#                  [2,2,0,1],
#                  [1,2,2,0]]
generating_set = [[1,2,2,0,2,0,2,1],
                  [0,1,1,2,0,2,1,1],
                  [2,1,2,0,0,0,2,2]]
print(format_pseudomonomial_list(
                    generating_set_to_CF(generating_set, True)))
