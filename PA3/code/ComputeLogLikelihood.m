% CS228 PA3 Winter 2011
% File: ComputeLogLikelihood.m
% Copyright (C) 2011, Stanford University
% contact: Huayan Wang, huayanw@cs.stanford.edu

function loglikelihood = ComputeLogLikelihood(logProb)

N = size(logProb,1); % number of examples
K = size(logProb,2); % number of classes

loglikelihood = 1;

% You should compute the log likelihood of data as in eq. (20) in the PA
% description

% YOUR CODE HERE

for i = 1:N,
    
    x = 0;
   for j = 1:K,
       x = x + exp(logProb(i,j));
   end;
   
    loglikelihood = loglikelihood * x;

   
end;

loglikelihood = log(loglikelihood);

i = 5;
