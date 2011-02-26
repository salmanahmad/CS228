% CS228 PA3 Winter 2011
% File: FitLinearGaussianParameters.m
% Copyright (C) 2011, Stanford University
% contact: Huayan Wang, huayanw@cs.stanford.edu

function [Beta sigma] = FitLinearGaussianParameters(X, U, W)

% Estimate parameters of the linear Gaussian model:
% X|U ~ N(Beta(1)*U(1) + ... + Beta(K)*U(K) + Beta(K+1), sigma^2);

% Note that Matlab index from 1, we can't write Beta(0). So Beta(K+1) is
% essentially Beta(0) in PA3 description (and the text book).

% X: (N x 1), the child variable, N examples
% U: (N x K), K parent variables, N examples
% W: (N x 1), weights over the examples, for computing expectations

N = size(U,1);
K = size(U,2);

Beta = zeros(K+1,1);
sigma = 1;

% collect expectations and solve the linear system
% A = [ E[U(1)],      E[U(2)],      ... , E[U(K)],      1     ; 
%       E[U(1)*U(1)], E[U(2)*U(1)], ... , E[U(K)*U(1)], E[U(1);
%       ...         , ...         , ... , ...         , ...   ;
%       E[U(1)*U(K)], E[U(2)*U(K)], ... , E[U(K)*U(K)], E[U(K)] ]

% B = [ E[X]; E[X*U(1)]; ... ; E[X*U(K)] ]

% solve A*Beta = B

% then compute sigma according to eq. (17) in PA description

% YOUR CODE HERE
