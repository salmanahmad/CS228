
% myfucntion: separate the positive part and negative part of a matrix A

function [posA negA] = myfunction(A)

posA = (A>0).*A;
negA = (A<0).*A;

% you don't have to worry about the type/shape/size of A
