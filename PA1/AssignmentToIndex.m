%ASSIGNMENTTOINDEX Convert assignment to index.
%
%   I = ASSIGNMENTTOINDEX(A, D) converts an assignment, A, over variables
%   with dimensionality D to an index into product table. If A is a matrix
%   then converts each row of A to an index.
%
% CS228 Structured Probabilistic Models (Winter 2011)
% Copyright (C) 2009, Stanford University

function I = AssignmentToIndex(A, D)

%D = D(:)'; % ensure that D is a row vector
if (any(size(A) == 1)),
    I = cumprod([1, D(1:end - 1)]) * (A(:) - 1) + 1;
else
    I = sum(repmat(cumprod([1, D(1:end - 1)]), size(A, 1), 1) .* (A - 1), 2) + 1;
end