% CS228 PA3 Winter 2011
% File: VisualizeModels.m
% Copyright (C) 2011, Stanford University
% contact: Huayan Wang, huayanw@cs.stanford.edu

function VisualizeModels(P, G)
K = length(P.c);

figure
while(1)
    for k=1:K
        subplot(1,K,k);
        if size(G,3) == 1  % same graph structure for all classes
            
            pose = SamplePose(P,G,k);
            
        else  % different graph structure for each class
            
            pose = SamplePose(P,G(:,:,k),k);
            
        end
        
        img = ShowPose(pose);
        imshow(img);
        pause(0.3)
    end
end
