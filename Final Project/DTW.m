function [ tau ] = DTW(y, z_average, z_standard_deviation, tau_probability_params)
%DTW Summary of this function goes here
%   Detailed explanation goes here
%   This is stupid
    
    
    if(length(z_average) ~= length(z_standard_deviation))
        disp 'Error: z_average and z_standard_deviation must be the same length'
        return;
    end
        
    if(length(z_average) < length(y))
        disp 'Error: the z vector must be larger than y'
        return;
    end
    
    tau = zeros(1, length(y));
    q = zeros(length(y), length(z_average));
    
    q(1, 1) = log(normpdf(y(1), z_average(1), z_standard_deviation(1))) + log(1);
    q(1, 2:length(z_average)) = log(0);
    tau(1) = 1;
     
    
    for s = 2:length(y) 
        
        maximum_q = -Inf;
        
        for t = 1:length(z_average)
            q(s, t) = log(normpdf(y(s), z_average(t), z_standard_deviation(t)));
            
            maximum = -Inf;
            for t_prime = 1:t-1
                value = log(tau_probability(tau_probability_params, t_prime, t));
                value = value + q(s-1, t_prime);
                
                if(value > maximum) 
                    maximum = value;
                end
            end
            
            q(s,t) = q(s,t) + maximum;
            
            if(q(s,t) > maximum_q) 
               maximum_q = q(s,t);
               tau(s) = t;
            end        
        end
    end
    
end


function probability = tau_probability(tau_probability_params, tau1, tau2)
% This is going to calculate the probability of tau2 given tau1
% Make sure that tao2 greater than tau1 and that they are integers (don't be stupid)

    difference = tau2 - tau1;
    if(difference < 1 || difference > length(tau_probability_params))
        probability = 0;
    else
        probability = tau_probability_params(difference);
    end
    
end
