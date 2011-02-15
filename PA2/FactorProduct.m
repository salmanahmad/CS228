%FACTORPRODUCT Computes the product of two factors.
%   C = FACTORPRODUCT(A,B) computes the product between two factors, A and B,
%   where each factor is defined over a set of variables with given dimension.
%   The factor data structure has the following fields:
%       .var    Vector of variables in the factor, e.g. [1 2 3]
%       .dim    Vector of dimensions corresponding to .var, e.g. [2 2 2]
%       .val    Value table of size prod(.dim)
%
%   See also FACTORMARGINALIZATION, INDEXTOASSIGNMENT, ASSIGNMENTTOINDEX

% CS228 Probabilistic Models in AI (Winter 2007)
% Copyright (C) 2007, Stanford University

function [C] = FactorProduct(A, B)

% check for empty factors
if (isempty(A.var)), C = B; return; end;
if (isempty(B.var)), C = A; return; end;

% construct the output factor over all variables and mapping between
% variables in A and B and variables in C
mapA = zeros(1, length(A.var));
mapB = zeros(1, length(B.var));

C.var = unique([A.var, B.var]);
C.dim = zeros(1, length(C.var));
for i = 1:length(C.var),
    indxA = find(A.var == C.var(i));
    indxB = find(B.var == C.var(i));
    if (isempty(indxA)),
        C.dim(i) = B.dim(indxB);
        mapB(indxB) = i;
    elseif (isempty(indxB)),
        C.dim(i) = A.dim(indxA);
        mapA(indxA) = i;
    elseif (A.dim(indxA) == B.dim(indxB)),
        C.dim(i) = A.dim(indxA);
        mapA(indxA) = i;
        mapB(indxB) = i;
    else
        error('dimensionality mismatch in factors');
    end;
end;

C.val = zeros(1,prod(C.dim));

% Compute the factor values of C
assignments = IndexToAssignment(1:prod(C.dim), C.dim);
indxA = AssignmentToIndex(assignments(:, mapA), A.dim);
indxB = AssignmentToIndex(assignments(:, mapB), B.dim);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% YOUR CODE HERE:
% Correctly populate the factor values of C
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = 1:length(C.val),
    C.val(i) = A.val(indxA(i)) * B.val(indxB(i));
end;