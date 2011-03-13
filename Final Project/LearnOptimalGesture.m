function [ optimal_gesture taus ] = LearnOptimalGesture( training_examples )


    % Configuration Constants
    
    NumberOfTrackingPoints = 20;
    MaximumTauStepSize = 3;
    
    
    
    % Coding style: All variables that are used in the paper
    % should be referenced with a capital letter. We can give them
    % better semantic names at the end of the functions if needed.

    Ys = training_examples;
    
    
    
    
    % Compute the size of the optimal gesture
    
    T = 0;
    
    for i = 1:length(Ys)
       Y = Ys{i};
       T = T + size(Y, 1);
    end
    
    T = T / length(Ys);
    T = ceil(2 * T);
    
    % TODO - in the future, we may need to change the 3. We are
    % hard coding the the fact that x,y,z are 3 values...
    Z = zeros(T, NumberOfTrackingPoints, 3);
   
    
    
    
    
    % Covariance matrices
    
    sigma_Z = eye();
    sigma_Y = eye();
    sigma_Beta = eye();
    sigma_Delta = eye();
    
    
    % initial tau probability params, d
    d = ones(1,MaximumTauStepSize) / MaximumTauStepSize;
    
    % initial, evenly-spaced taus
    taus = cell(1,length(Ys));
    for i = 1:length(Ys),
        tau = 1:length(Ys{i});
        tau = ceil( (tau - 1) * (T - 1) / (length(Ys{i}) - 1) ) + 1;
        taus(i) = {tau};
    end;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % calculate optimal gesture
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    optimal_gesture = Z;
    
end
