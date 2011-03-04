
gesture_class_labels = {'clap' 'flick_left' 'flick_right' 'high_kick' ...
                        'jump' 'low_kick' 'punch' 'throw' 'wave'};

last_training_index = 5;

% number of classes, number of training examples
training_data = cell(length(gesture_class_labels), last_training_index + 1);

% number of samples, 20 (joints)

data_directory = 'gestures_v1';


for i = 1:length(gesture_class_labels),

    label = gesture_class_labels{i};
    
    for j = 0:last_training_index,
        file_name = sprintf('%s/track_%s_%02d.log', data_directory, label, j);
        
        fd = fopen(file_name);
        
        samples = [];
        
        % read all samples
        while(~feof(fd)),
            line = fgets(fd);
            if(line(1) == '#'), continue; end;
            
            numbers = textscan(line, '%f');
            numbers = numbers{1};
            numbers = numbers(2:length(numbers))';
            
            samples(end+1,:,:) = reshape(numbers, 3, 20)';
        end;
        
        points = samples;
        origin = points(:, 1, :);
        
        deltas = points - repmat(origin, 1, 20);
        squares = deltas .* deltas;
        sum_squares = sum(squares, 3);
        distances = sqrt(sum_squares);
        
        training_data(i, j+1) = num2cell(num2cell(distances, 2), 1);
        
    end;
end;

training_data
