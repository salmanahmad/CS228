% CS228 PA3 Winter 2011
% File: ComputeConditionalClassProb.m
% Copyright (C) 2011, Stanford University
% contact: Huayan Wang, huayanw@cs.stanford.edu

function ClassProb = ComputeConditionalClassProb(logProb)

N = size(logProb,1); % number of examples
K = size(logProb,2); % number of classes
ClassProb = zeros(N,K);

% YOUR CODE HERE

% ClassProb(i,k) should be the conditional probability of class label k
% for example i in the dataset. (eq. (19) in PA description)