% Neural-ideal package
% README
% 
% Neural ideal is a MATLAB package which computes the canonical form 
% of the neural ideal. For more information about the neural ideal
% and its uses, see the paper about the neural ring 
%   http://arxiv.org/abs/1212.4201
% 
% To use this package, the essential files are
% 
% Code2CF.m
% FinalIntersectIdeals.m
% Prettify.m
% 
% Usage------------------------------------
% 
% The primary interface for computation is
% 
%      Code2CF(C)
% 
% where C is a binary matrix whose rows are codewords. 
% 
% 
% The default output will be a list of polynomials representing 
% the canonical form; these are strings.
% 
% A second optional output is available in matrix form. The polynomials
% of the canonical form are represented as rows in a binary matrix and should 
% be read as follows: the row has length 2n where in the first n entries 
% a 1 in place i indicates an x_i, and in the second n entries, a 1 in place
% i indicates a (1-x_j) where j = i-n.  For example, the row
%  [0 1 0 0 1 0 1 1] 
% corresponds to the polynomial x2(1-x1)(1-x3)(1-x4).
% 
