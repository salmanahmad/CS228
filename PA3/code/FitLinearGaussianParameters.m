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
%%%%%%%%%%%%%%%%%%%%%%%%%

A = zeros(K + 1, K + 1);

for j = 1:K,
   [mu, s] = FitGaussianParameters(U(:,j), W);
   A(1,j) = mu;
end;

A(1, K+1) = 1;

for i = 2:K+1,
   for j = 1:K,
       [mu, s] = FitGaussianParameters(U(:,i - 1) .* U(:,j), W);
       A(i,j) = mu;
   end;
   
   [mu, s] = FitGaussianParameters(U(:,i - 1), W);
   A(i,K+1) = mu;
   
end;




B = zeros(K + 1, 1);

[mu, s] = FitGaussianParameters(X, W);
B(1) = mu;

for i = 2:K+1,
    [mu, s] = FitGaussianParameters(X .* U(:,i-1), W);
    B(i) = mu;
end;




Beta = linsolve(A, B);





c = cov(X, X, W);
s = 0;
for i = 1:K,
    for j = 1:K,
        s = s + Beta(i)*Beta(j)*cov(U(:,i), U(:,j), W);
    end;
end;


sigma = sqrt(c - s);




end

function c = cov(X, Y, W)
    
    [mu_xy, s] = FitGaussianParameters(X .* Y, W);    
    [mu_x, s] = FitGaussianParameters(X, W);
    [mu_y, s] = FitGaussianParameters(Y, W);
    
    c = mu_xy - (mu_x * mu_y);
    
end


%%%%%%%%%%%%%%%%%%%%%%%%%


