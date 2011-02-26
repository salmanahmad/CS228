% CS228 PA3 Winter 2011
% File: LearnGraphAndCPDs.m
% Copyright (C) 2011, Stanford University
% contact: Huayan Wang, huayanw@cs.stanford.edu

function [P G loglikelihood] = LearnGraphAndCPDs(dataset, InitialClassProb, maxIter)

% dataset: N x 10 x 3, 
% InitialClassProb: initial allocation of examples to classes
% maxIter: max number of iterations allowed

N = size(dataset, 1);
K = size(InitialClassProb,2);

ClassProb = InitialClassProb;
OldClassProb = ClassProb;

loglikelihood = zeros(maxIter,1);

G = zeros(10,2,K); % graph structures to learn
for k=1:K
    G(2:end,1,k) = 2*ones(9,1); % fake data for grading purpose, ignore it
    G(2:end,2,k) = ones(9,1);
end

% EM algorithm
for iter=1:maxIter
    
    % use hard assignment EM
    for i=1:N
        [tmp maxidx] = max(ClassProb(i,:));
        ClassProb(i,:) = zeros(1,K);
        ClassProb(i,maxidx) = 1;
    end
    
    % report error if one class becomes nearly empty
    % (it never happens if you implement correctly and use the
    % InitialClassProb we give you)
    if sum(ClassProb(:,1)) < 20 || sum(ClassProb(:,2)) < 20
        display('Error: one class becomes nearly empty.');
        return
    end
    
    % estimate graph structure for each class
    for k=1:K
        
        %%%%%%%%%%%%%%%%%%%%%%%%%
        % YOUR CODE HERE
        %%%%%%%%%%%%%%%%%%%%%%%%%
       
    end


    % estimate parameters for the class label variable in eq. (1)
    P.c = zeros(1,K); 
    %%%%%%%%%%%%%%%%%%%%%%%%%
    % YOUR CODE HERE
    %%%%%%%%%%%%%%%%%%%%%%%%%
    
    % estimate parameters for each body part variable
    for i=1:10 % for each body part variable (node)
        
        for k=1:K % class label = k
            
            parent = G(i,2,k); % parent body part, if exists
            
            if G(i,1,k) == 0 % parametrized by (2),(3),(4)
             
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
                
                
            elseif G(i,1,k) == 1 % parametrized by (5),(6),(7)
                
                P.clg(i).theta(k,:) = zeros(1,12);
                P.clg(i).sigma_y(k) = 0;
                P.clg(i).sigma_x(k) = 0;
                P.clg(i).sigma_angle(k) = 0;
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                % YOUR CODE HERE
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
            elseif G(i,1,k) == 2 % parametrized by (8),(9),(10)
                
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
