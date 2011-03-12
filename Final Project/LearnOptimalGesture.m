function [ optimal_gesture ] = LearnOptimalGesture( training_examples )


    % Configuration Constants
    
    NumberOfTrackingPoints = 20;
    
    
    
    
    % Coding style: All variables that are used in the paper
    % shoudl be referenced with a capital letter. We can give them
    % better semantic names at the end of the functions if needed.

    Ys = training_examples;
    
    
    
    
    % Compute the size of the optimial gesture
    
    T = 0;
    
    for i = 1:length(Ys)
       Y = Ys{i};
       T = T + size(Y, 1);
    end
    
    T = T / length(Ys);
    T = ceil(2 * T);
    
    Z = zeros(T, NumberOfTrackingPoints);
   
    
    
    
    
    % Covariance matrices
    
    sigma_Z = eye();
    sigma_Y = eye();
    sigma_Beta = eye();
    sigma_Delta = eye();
    
    
    
    
    % Omegas
    
    
    
    
    
    
    optimal_gesture = Z;
    
    
end

