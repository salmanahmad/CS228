% this file runs all of the tests we're interested in

clear

[p r] = GestureGetDataByLabel('high_kick');



new_r = cell(1, 3);

r1 = r{1};
new_r(1) = {r1};
new_r(2) = {r1((1:floor(end/2)) * 2, :)};

two_thirds_indices = (1:floor(size(r1,1)/3)) * 3;
two_thirds_indices = unique([two_thirds_indices two_thirds_indices-1]);
new_r(3) = {r1(two_thirds_indices, :)};


[optimal_gesture alignment_indices] = LearnOptimalGesture(new_r);


aligned_gestures = cell(size(new_r));

for i = 1:length(alignment_indices),
    alignment_indices{i}
    aligned = GestureAlign(new_r{i}, alignment_indices{i}, length(optimal_gesture)); 
    aligned_gestures(i) = {aligned};
end;

% GestureVisualize now works for 60x1 or 20x3

%GestureVisualize(optimal_gesture);

GestureVisualize(aligned_gestures, true, false);
GestureVisualize(new_r, true, false);



