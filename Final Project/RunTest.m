% this file runs all of the tests we're interested in

clear

[p r] = GestureGetDataByLabel('high_kick');

new_r = r([1 2 4 5 6]);

aligned_gestures = cell(size(new_r));

[optimal_gesture alignment_indices] = LearnOptimalGesture(new_r);

save alignment

for i = 1:length(alignment_indices),
    aligned = GestureAlign(new_r{i}, alignment_indices{i}, length(optimal_gesture)); 
    aligned_gestures(i) = {aligned};
end;

% GestureVisualize now works for 60x1 or 20x3
%GestureVisualize(aligned_gestures, true, true);
GestureVisualize(new_r, true, true);
