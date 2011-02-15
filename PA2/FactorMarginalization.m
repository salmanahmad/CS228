%FACTORMARGINALIZATION Sums a given variable out of a product.
%   B = FACTORMARGINALIZATION(A,V) computes the product with the variables
%   in V summed out. The factor data structure has the following fields:
%       .var    Vector of variables in the factor, e.g. [1 2 3]
%       .dim    Vector of dimensions corresponding to .var, e.g. [2 2 2]
%       .val    Value table of size prod(.dim)
%
%   See also FACTORPRODUCT, INDEXTOASSIGNMENT, ASSIGNMENTTOINDEX

% CS228 Probabilistic Models in AI (Winter 2007)
% Copyright (C) 2007, Stanford University

function [B] = FactorMarginalization(A, V)

% check for empty factor or variable list
if (isempty(A.var) || isempty(V)), B = A; return; end;

% construct the output factor over A.var \ V and mapping between
% variables in A and B
[B.var, mapB] = setdiff(A.var, V);
B.dim = A.dim(mapB);

B.val = zeros(1,prod(B.dim));

% Compute the factor values of B
assignments = IndexToAssignment(1:length(A.val), A.dim);
indxB = AssignmentToIndex(assignments(:, mapB), B.dim);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% YOUR CODE HERE
% Correctly populate the factor values of B
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = 1:length(A.val),
    B.val(indxB(i)) = B.val(indxB(i)) + A.val(i);
end;