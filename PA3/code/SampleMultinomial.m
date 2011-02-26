% CS228 PA3 Winter 2011
% File: SampleMultinomial.m
% Copyright (C) 2011, Stanford University
% contact: Huayan Wang, huayanw@cs.stanford.edu


function sample = SampleMultinomial(probabilities)

dice = rand(1,1);
accumulate = 0;
for i=1:length(probabilities)
    accumulate = accumulate + probabilities(i);
   if accumulate/sum(probabilities) > dice
       break
   end
end
sample = i;


