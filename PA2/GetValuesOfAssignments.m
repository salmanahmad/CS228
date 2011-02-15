%GETVALUESOFASSIGNMENT
%
%   Get the values of multiple assignments to a given factor.  The same logic as
%   GetValueOfAssignment, but accepts multiple assignments given in A in the format
%         [<Assignment 1>;
%          <Assignment 2>;
%          <Assignment 3>;
%           etc.]
% Note that the values in each assignment must be in the order of the variables in F.var.

function v = GetValuesOfAssignments(F, A);

indx = AssignmentToIndex(A, F.dim);
v = F.val(indx);
