function [ optimal_gesture taus ] = LearnOptimalGesture( training_examples )


    % Configuration Constants
    MaximumTauStepSize = 3;
    
    % Coding style: All variables that are used in the paper
    % should be referenced with a capital letter. We can give them
    % better semantic names at the end of the functions if needed.

    Ys = training_examples;
    NumberOfTrackingVariables = size(Ys{1}, 2);
    
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
    
    
    for c = 1:100,
        
        disp(sprintf('Iteration %d', c));
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % calculate optimal gesture
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % store old taus to check for convergence
        old_taus = taus;
        
        % collect aligned samples
        for i = 1:length(Ys),
            Y = Ys{i};
            tau = taus{i};
            
            for j = 1:size(Y,1),
                sample = Y(j,:);
                z_index = tau(j);
                if(z_index ~= 0),
                    Z_aligned_samples(z_index) = {[ Z_aligned_samples{z_index}; sample ]};
                end;
            end;
        end;
        
        % calculate Z_means and Z_variances
        for i = 1:length(Z_aligned_samples),
            Z_means(i,:) = mean(Z_aligned_samples{i});
            Z_variances(i,:) = var(Z_aligned_samples{i});
        end;
        
        % Removes NaNs
        % By definition, n=1 is mapped to the first Z
        for n=2:size(Z_means, 1)
           if isnan(Z_means(n, 1))
               Z_means(n,:) = Z_means(n-1,:);
               Z_variances(n,:) = Z_variances(n-1,:);
           end
        end

        
        
        for i = 1:size(Z_means,2) 
            Z_means(:,i) = smooth(Z_means(:,i), 'lowess');
        end
        
        % rlowess - good but slow and weird legs
        % lowess - fast and decent
        % moving - good...
        
        
        
        
        %Z_means = smooth(Z_means);
        
        % run dynamic time warping for each training example
        % TODO: need to update DTW to work for the multi-variate case
        for i = 1:length(Ys),
            Y = Ys{i};
            taus(i) = { DTW(Y, Z_means, sqrt(Z_variances), d) };
        end;
        
        % TODO: update estimate of d from taus
        totalTransitions = 0;
        for i = 1:length(taus),
            tau = taus{i};
            totalTransitions = totalTransitions + (length(tau) - 1);
        end;
        
        for d_index = 1:MaximumTauStepSize,
            d_count = 0;
            
            for i = 1:length(taus),
                tau = taus{i};
                d_count = d_count + length(find(tau(2:end) - tau(1:end-1) == d_index));
            end;
            
            d(d_index) = d_count / totalTransitions;
        end;
        
        % check for convergence in taus
        allSame = true;
        for i = 1:length(taus),
            allSame = allSame && all(taus{i} == old_taus{i});
        end;
        if allSame,
            break;
        end;
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    end;
    
    optimal_gesture = Z_means;
    
end
