% this file runs all of the tests we're interested in

clear

[p r] = GestureGetDataByLabel('high_kick');

[optimal_gesture alignment_indices] = LearnOptimalGesture(r);

% for i = 1:length(alignment_indices),
%     alignment_indices{i}
% end;

% GestureVisualize now works for 60x1 or 20x3
GestureVisualize(optimal_gesture);
