function [ aligned_gesture ] = GestureAlign(gesture, tau, target_length)
    
    aligned_gesture = zeros(target_length, 60);
    
    
    truncated_tau = tau(find(tau));
    aligned_gesture(truncated_tau, :) = gesture(1:length(truncated_tau), :); 
    
    before = 0;
    after = 0;
    number_of_zeros = 0;
    
    for i = 1:size(aligned_gesture)
        if(aligned_gesture(i) == 0)            
            number_of_zeros = number_of_zeros + 1;
        else
            
            if number_of_zeros ~= 0
                before = i - (number_of_zeros + 1);
                current = i;
                
                aligned_gesture((before+1):(current - 1), :) = ...
                    interp1([1 number_of_zeros + 2], ...
                            aligned_gesture([before, current], :), ...
                            2:number_of_zeros+1);
            end
            
            
            
            
            number_of_zeros = 0;
        end
    end
    
    if number_of_zeros ~= 0
        last_row_index = size(aligned_gesture, 1) - number_of_zeros;
        last_row = aligned_gesture(last_row_index,:);
        aligned_gesture(last_row_index + 1:end,:) = repmat(last_row, number_of_zeros, 1);
    end
    
    

end

