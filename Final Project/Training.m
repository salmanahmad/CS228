


gesture_class_labels = {'clap' 'flick_left' 'flick_right' 'high_kick' ...
                        'jump' 'low_kick' 'punch' 'throw' 'wave'};

last_training_index = 5;
               
% number of classes, number of training examples, number of samples, 20 (joints)
training_data = zeros(length(gesture_class_labels), last_training_index + 1);
         
data_directory = 'gestures_v1';


for i = 1:length(gesture_class_labels)
   label = gesture_class_labels{i};
   for j = 0:training_count 
       file_name = sprintf('%s/track_%s_%02d.log', data_directory, label, j);
       
       fd = fopen(file_name);
        
       training_data(i, j+1) = cell(0);

       
       while(~feof(fd)),
            line = fgets(fd);
            if(line(1) == '#'), continue; end;

            numbers = textscan(line, '%f');
            numbers = numbers{1};
            numbers = numbers(2:length(numbers))';
            
            points = reshape(numbers, 3, 20)';
            origin = points(1, :);
            
            deltas = points - repmat(origin, 20, 1);
            squares = deltas .* deltas;
            sum_squares = sum(squares, 2);
            distances = sqrt(sum_squares);
            
            c = training_data(i, j+1);
            c{end+1} = distances;
            break;
        end;
        break
   end
   break
end