% CS228 PA3 Winter 2011
% File: TestPA3.m
% Copyright (C) 2011, Stanford University
% contact: Huayan Wang, huayanw@cs.stanford.edu

clear
load test.mat;

threshold = 1e-5;

display('Test FitGaussianParameters.m');
[mu sigma1] = FitGaussianParameters(X, W);
if norm(mu - mu_gt) > threshold || norm(sigma1 - sigma1_gt) > threshold
    display('failed');
else
    display('pass');
end


display('Test FitLinearGaussianParameters.m');
[Beta sigma2] = FitLinearGaussianParameters(X, U, W);
if norm(Beta - Beta_gt) > threshold || norm(sigma2 - sigma2_gt) > threshold
    display('failed');
else
    display('pass');
end

display('Test ComputeLogJointProb.m');
logProb1 = ComputeLogJointProb(P1rand, G1, pose);
logProb2 = ComputeLogJointProb(P2rand, G2, pose);
logProb3 = ComputeLogJointProb(P3rand, G3, pose);
logProb4 = ComputeLogJointProb(P3rand, cat(3,G3,G4,G3), pose);
if norm(logProb1 - logProb1_gt) > threshold || norm(logProb2 - logProb2_gt) > threshold || ...
        norm(logProb3 - logProb3_gt) > threshold ||  norm(logProb4 - logProb4_gt) > threshold
    display('failed');
else
    display('pass');
end

display('Test ComputeConditionalClassProb.m');
ClassProb = ComputeConditionalClassProb(logProb);
if norm(ClassProb - ClassProb_gt) > threshold
    display('failed');
else
    display('pass');
end

display('Test ComputeLogLikelihood.m');
loglikelihood = ComputeLogLikelihood(logProb);
ClassProb = ComputeConditionalClassProb(logProb);
if norm(loglikelihood - loglikelihood_gt) > threshold
    display('failed');
else
    display('pass');
end

display('Test LearnCPDsGivenGraph.m');
[P(1) loglikelihood1] = LearnCPDsGivenGraph(dataset, G1, InitialClassProb, 2);
[P(2) loglikelihood2] = LearnCPDsGivenGraph(dataset, G2, InitialClassProb, 2);
[P(3) loglikelihood3] = LearnCPDsGivenGraph(dataset, G3, InitialClassProb, 2);
pass1 = 1;
if norm(loglikelihood1 - loglikelihood1_gt) > threshold || ...
        norm(loglikelihood2 - loglikelihood2_gt) > threshold || ...
        norm(loglikelihood3 - loglikelihood3_gt) > threshold 
    pass1 = 0;
end

for j=1:3
    if norm(P(j).c - P_gt(j).c) > threshold
        pass1 = 0;
    end
    for i=1:10
        if i == 1 || j == 1
            % test mu
            if norm(P(j).clg(i).mu_y - P_gt(j).clg(i).mu_y) > threshold
                pass1 = 0;
            end
            if norm(P(j).clg(i).mu_x - P_gt(j).clg(i).mu_x) > threshold
                pass1 = 0;
            end
            if norm(P(j).clg(i).mu_angle - P_gt(j).clg(i).mu_angle) > threshold
                pass1 = 0;
            end
            
        elseif i ~= 1 && j == 2
            % test theta
            if norm(P(j).clg(i).theta - P_gt(j).clg(i).theta) > threshold
                pass1 = 0;
            end
            
        elseif i ~= 1 && j == 3
            % test gamma
            if norm(P(j).clg(i).gamma - P_gt(j).clg(i).gamma) > threshold
                pass1 = 0;
            end
        end
        
        % test sigma
        if norm(P(j).clg(i).sigma_y - P_gt(j).clg(i).sigma_y) > threshold
            pass1 = 0;
        end
        if norm(P(j).clg(i).sigma_x - P_gt(j).clg(i).sigma_x) > threshold
           pass1 = 0;
        end
        if norm(P(j).clg(i).sigma_angle - P_gt(j).clg(i).sigma_angle) > threshold
            pass1 = 0;
        end
    end
end
if pass1
    display('pass');
else
    display('failed');
end

display('Test GaussianMutualInformation.m');
I = GaussianMutualInformation(Y1, Y2);
if norm(I - I_gt) > threshold
    display('failed');
    return
else
    display('pass');
end


display('Test LearnGraphStructure.m');
[A W] = LearnGraphStructure(dataset, 0);
if norm(A - A_gt) > threshold || norm(W - W_gt) > threshold
    display('failed');
    return
else
    display('pass');
end

