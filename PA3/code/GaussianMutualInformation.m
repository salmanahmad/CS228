% CS228 PA3 Winter 2011
% File: GaussianMutualInformation.m
% Copyright (C) 2011, Stanford University
% contact: Huayan Wang, huayanw@cs.stanford.edu

function I = GaussianMutualInformation(X, Y)

% X: (N x D1), D1 dimensions, N samples 
% Y: (N x D2), D2 dimensions, N samples

% I(X, Y) = 1/2 * log( | Sigma_XX | * | Sigma_YY | / | Sigma |)
% Sigma = [ Sigma_XX, Sigma_XY ; 
%           Sigma_XY, Sigma_YY ]

% Use 'det' to compute determinant of matrix

I = 0;

% YOUR CODE HERE
