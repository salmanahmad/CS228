function TOTAL_POINTS = ExecuteTest(name, result, POINTS, ...
                                    TOTAL_POINTS);

RESULT_STRING = {'FAILED', 'PASSED'};
disp([name ':               ', RESULT_STRING{result + 1}]);
if result
    TOTAL_POINTS = TOTAL_POINTS + POINTS;
end
