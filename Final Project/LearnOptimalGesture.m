function [ optimal_gesture taus ] = LearnOptimalGesture( training_examples )


    % Configuration Constants
    MaximumTauStepSize = 3;
    
    % Coding style: All variables that are used in the paper
    % should be referenced with a capital letter. We can give them
    % better semantic names at the end of the functions if needed.

    Ys = training_examples;
    NumberOfTrackingVariables = size(Ys{1}, 2)
    
    % Compute the size of the optimal gesture
    
    T = 0;
    
    for i = 1:length(Ys)
       Y = Ys{i};
       T = T + size(Y, 1);
    end
    
    T = T / length(Ys);
    T = ceil(2 * T);
    
    % Initialize Z distribution params...
    Z_aligned_samples = cell(1,T);
    Z_means = zeros(T, NumberOfTrackingVariables);
    Z_variances = zeros(T, NumberOfTrackingVariables);
    
    
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
    
    % collect aligned samples
    for i = 1:length(Ys),
        Y = Ys{i};
        tau = taus{i};
        
        for j = 1:size(Y,1),
            sample = Y(j,:);
            z_index = tau(j);
            Z_aligned_samples(z_index) = {[ Z_aligned_samples{z_index}; sample ]};
        end;
    end;
    
    % calculate Z_means and Z_variances
    for i = 1:length(Z_aligned_samples),
        Z_means(i,:) = mean(Z_aligned_samples{i});
        Z_variances(i,:) = var(Z_aligned_samples{i});
    end;
    
    % run dynamic time warping for each training example
    % TODO: need to update DTW to work for the multi-variate case
    for i = 1:length(Ys),
        Y = Ys{i}
        taus(i) = { DTW(Y, Z_means, sqrt(Z_variances), d) };
    end;
    
    % TODO: update estimate of d from taus
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    optimal_gesture = Z_means;
    
end
