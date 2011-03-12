% this file runs all of the tests we're interested in

clear all

[p r] = GestureGetDataByLabel('high_kick');

optimal_gesture = LearnOptimalGesture(r);

size(p)
size(r)
size(optimal_gesture)

%GestureVisualize(optimal_gesture);
