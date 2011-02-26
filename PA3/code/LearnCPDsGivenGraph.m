% CS228 PA3 Winter 2011
% File: LearnCPDsGivenGraph.m
% Copyright (C) 2011, Stanford University
% contact: Huayan Wang, huayanw@cs.stanford.edu

function [P loglikelihood] = LearnCPDsGivenGraph(dataset, G, InitialClassProb, maxIter)

% dataset: N x 10 x 3,
% G: graph parametrization as explained in PA description
% InitialClassProb: initial allocation of examples to classes
% maxIter: max number of iterations allowed

N = size(dataset, 1);
K = size(InitialClassProb,2);

ClassProb = InitialClassProb;
OldClassProb = ClassProb;

loglikelihood = zeros(maxIter,1);

% EM algorithm
for iter=1:maxIter

    % estimate parameters
    
    P.c = zeros(1,K); 
    %%%%%%%%%%%%%%%%%%%%%%%%%
    % YOUR CODE HERE
    %%%%%%%%%%%%%%%%%%%%%%%%%
        
    for i=1:10 % for each body part variable (node)
        
        parent = G(i,2); % parent body part, if exists
        
        for k=1:K % class label = k
            
            if G(i,1) == 0 % parametrized by (2),(3),(4)
             
                % fit CPD for y
                P.clg(i).mu_y(k) = 0;
                P.clg(i).sigma_y(k) = 0;
                
                % fit CPD for x
                P.clg(i).mu_x(k) = 0;
                P.clg(i).sigma_x(k) = 0;
                
                % fit CPD for angle
                P.clg(i).mu_angle(k) = 0;
                P.clg(i).sigma_angle(k) = 0;
                
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%
                % YOUR CODE HERE
                %%%%%%%%%%%%%%%%%%%%%%%%%%
                
            elseif G(i,1) == 1 % parametrized by (5),(6),(7)
                
                P.clg(i).theta(k,:) = zeros(1,12);
                P.clg(i).sigma_y(k) = 0;
                P.clg(i).sigma_x(k) = 0;
                P.clg(i).sigma_angle(k) = 0;
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                % YOUR CODE HERE
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
            elseif G(i,1) == 2 % parametrized by (8),(9),(10)
                
                P.clg(i).gamma(k,:) = zeros(1,14);
                P.clg(i).sigma_y(k) = 0;
                P.clg(i).sigma_x(k) = 0;
                P.clg(i).sigma_angle(k) = 0;
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                % YOUR CODE HERE
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
            end
        end
    end
    
    % re-infer class label using the new parameters
    logJointProb = zeros(N,K);
    for i=1:N % for each training example
        pose = reshape(dataset(i,:,:), [10 3]); % trivial reshape
        logJointProb(i,:) = ComputeLogJointProb(P, G, pose);
    end
    ClassProb = ComputeConditionalClassProb(logJointProb);
    loglikelihood(iter) = ComputeLogLikelihood(logJointProb);
    
    display(sprintf('EM iteration %d: log likelihood: %f', ...
        iter, loglikelihood(iter)));

    change = norm(OldClassProb-ClassProb)/norm(OldClassProb);
    if change < 1e-8 % converged
        break
    end
    OldClassProb = ClassProb;
end

loglikelihood = loglikelihood(1:iter);

