function [ processed_data, raw_data ] = GestureGetDataByLabel( label )
%GestureGetDataByLabel Summary of this function goes here
%   Detailed explanation goes here

    label_index = 0;

    gesture_class_labels = GestureClassLabels;
    
    for i = 1:length(gesture_class_labels) 
       current_label = gesture_class_labels{i};
       if(strcmp(label, current_label))
            label_index = i;  
            break; 
       end
    end
    
    if(label_index == 0)
        disp strcat('Could not find label: ', label)
        return
    end
    
    [all_data_processed, all_data_raw] = GestureGetAllData;
    processed_data = all_data_processed(label_index,:);
    raw_data = all_data_raw(label_index, :);
    
end