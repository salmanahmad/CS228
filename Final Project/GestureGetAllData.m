
function [ processed_data, raw_data ] = GestureGetAllData



    gesture_class_labels = GestureClassLabels;

    last_training_index = 5;

    % number of classes, number of training examples
    processed_data = cell(length(gesture_class_labels), last_training_index + 1);
    raw_data = cell(length(gesture_class_labels), last_training_index + 1);
    
    % number of samples, 20 (joints)

    data_directory = 'gestures_v1';


    for i = 1:length(gesture_class_labels),

        label = gesture_class_labels{i};

        for j = 0:last_training_index,
            file_name = sprintf('%s/track_%s_%02d.log', data_directory, label, j);

            fd = fopen(file_name);

            samples = [];
            raw_samples = [];
            
            % read all samples
            while(~feof(fd)),
                line = fgets(fd);
                if(line(1) == '#'), continue; end;

                numbers = textscan(line, '%f');
                numbers = numbers{1};
                numbers = numbers(2:length(numbers))';
    
                samples(end+1,:,:) = reshape(numbers, 3, 20)';
                raw_samples(end+1, :, :) = numbers(:);
            end;
            
                        
            points = samples;
            origin = points(:, 1, :);

            deltas = points - repmat(origin, 1, 20);
            squares = deltas .* deltas;
            sum_squares = sum(squares, 3);
            distances = sqrt(sum_squares);

            processed_data(i, j+1) = num2cell(num2cell(distances, 2), 1);
			raw_data(i, j+1) = {raw_samples};

            
			fclose('all');
			
        end;
    end;

end



