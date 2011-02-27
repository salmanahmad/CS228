% CS228 PA3 Winter 2011
% File: ComputeConditionalClassProb.m
% Copyright (C) 2011, Stanford University
% contact: Huayan Wang, huayanw@cs.stanford.edu

function ClassProb = ComputeConditionalClassProb(logProb)

N = size(logProb,1); % number of examples
K = size(logProb,2); % number of classes
ClassProb = zeros(N,K);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% YOUR CODE HERE

ClassProb = exp(logProb);

% These lines just divide each row in ClassProb by the
% sum of the row, producing rows normalized to one

s = sum(ClassProb')';
ClassProb = diag( 1 ./ s ) * ClassProb;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ClassProb(i,k) should be the conditional probability of class label k
% for example i in the dataset. (eq. (19) in PA description)