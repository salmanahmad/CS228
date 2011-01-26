%PERFORMINFERENCE runs inference on a list of factors
%
% output = PERFORMINFERENCE(factors) takes factors, prepares them for
%   inference, and returns the output of inference in 'output'
%   factors is a list of markov factors with fields
%     factors(i).var = the variables in factor i
%     facotrs(i).dim = a list of dimensions of the variables in factor i
%     factors(i).data is an energy matrix with dimension factors(i).dim
%       if the variables are 1 and 2, then factors(i).data(3,1) is the 
%       energy for variable 1 having value 3 and 2 having value 1.
%   output is a list with the same length as factors giving the
%     assignment to each factor after inference.
%
% CS228 Structured Probabilistic Models (Winter 2011)
% Copyright (C) 2010, Stanford University

function output = PerformInference(factors)
for i = 1:length(factors)
  factors(i).vars = factors(i).vars-1;
  factors(i).data = -reshape(factors(i).data,[1 prod(factors(i).cards)]);
end
display('Performing graph inference...');
tic
output = mexFactorGraphInference(factors, struct('infAlgorithm', 'LOGMAXPROD', ...
    'singletonOnly', 0, 'verbose', 0, 'maxIterations', 300));
toc
for i = 1:length(output)
  output(i).value = output(i).value+1;
end
