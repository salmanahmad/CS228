function [ tau ] = DTW(y, z_average, z_standard_deviation, tau_probability_params)
%DTW Summary of this function goes here
%   Detailed explanation goes here
%   This is stupid
    
    if(size(z_average,1) ~= size(z_standard_deviation,1))
        disp 'Error: z_average and z_standard_deviation must be the same length'
        return;
    end
        
    if(size(z_average,1) < size(y,1))
        disp 'Error: the z vector must be larger than y'
        return;
    end
    
    % By definition, n=1 is mapped to the first Z
    for n=2:size(z_average, 1)
       if isnan(z_average(n, 1))
           z_average(n,:) = z_average(n-1,:);
           z_standard_deviation(n,:) = z_standard_deviation(n-1,:);
       end
    end
    
    tau = zeros(1, size(y,1));
    q = zeros(size(y,1), size(z_average,1));
    
    q(1, 1) = sum(log(normpdf(y(1,:), z_average(1,:), z_standard_deviation(1,:)))) + log(1);
    q(1, 2:length(z_average)) = log(0);
    tau(1) = 1;
     
    
    for s = 2:size(y,1) 
        
        maximum_q = -Inf;
        
        for t = tau(s-1)+1:min(tau(s-1)+3,size(z_average,1)),
        
            C = 5;
            if t > (2 * s) + C || t < (2 * s) - C,
                continue;
            end;
        
            q(s, t) = sum(log(0.0000001 + normpdf(y(s,:), z_average(t,:), z_standard_deviation(t,:))));
            
            maximum = -Inf;
            for t_prime = max(1,t-3):t-1
                value = log(tau_probability(tau_probability_params, t_prime, t));
                value = value + q(s-1, t_prime);
                
                if(value > maximum) 
                    maximum = value;
                end
            end
            
            q(s,t) = q(s,t) + maximum;
            
%             if s==7 && t==tau(6)+1,
%                 s
%                 t
%                 maximum
%                 y(s,:)
%                 z_average(t,:)
%                 z_standard_deviation(t,:)
%                 normpdf(y(s,:), z_average(t,:), z_standard_deviation(t,:))
%                 log(normpdf(y(s,:), z_average(t,:), z_standard_deviation(t,:)))
%                 sum(log(normpdf(y(s,:), z_average(t,:), z_standard_deviation(t,:))))
%             end;

            if(q(s,t) > maximum_q) 
               maximum_q = q(s,t);
               tau(s) = t;
            end        
        end
    end
    
%    q'
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
