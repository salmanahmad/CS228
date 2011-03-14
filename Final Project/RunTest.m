% this file runs all of the tests we're interested in

clear all

[p r] = GestureGetDataByLabel('high_kick');

[optimal_gesture alignment_indices] = LearnOptimalGesture(r);

p
r
size(optimal_gesture)
alignment_indices

% convert to :,20,3 for GestureVisualize
x = zeros(size(optimal_gesture,1), size(optimal_gesture,2) / 3, 3);
x(:, :, 1) = optimal_gesture(:, ((1:20) * 3) - 2);
x(:, :, 2) = optimal_gesture(:, ((1:20) * 3) - 1);
x(:, :, 3) = optimal_gesture(:, ((1:20) * 3) - 0);

GestureVisualize(x);
