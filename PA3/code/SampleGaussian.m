% CS228 PA3 Winter 2011
% File: SampleGuassian.m
% Copyright (C) 2011, Stanford University
% contact: Huayan Wang, huayanw@cs.stanford.edu

function sample = SampleGaussian(mu, sigma)

% sample from the Gaussian distribution specifed by mean value mu and standard deviation sigma

    sample = mu + sigma*randn(1,1);
