% TESTPA2 Tests for programming assignment #2.

% Set the random seed (for Gibbs and Metropolis-Hastings)
rand('seed', 0);

load tests1

TOLERANCE = 1.0e-9;
TOTAL_POINTS = 0;

% Test FactorProduct and FactorMarginalization ---------------
A = INPUT.Factors.A;
B = INPUT.Factors.B;
E = INPUT.Factors.E;
F = INPUT.Factors.F;

% Test 1 (2 points)
POINTS = 2;
C = FactorProduct(A, B);

expected = OUTPUT.Factors.C.val;
result = (sum(abs(C.val(:) - expected(:))) < TOLERANCE);
TOTAL_POINTS = ExecuteTest('FactorProduct',result,POINTS,TOTAL_POINTS);

% Test 2 (3 points)
POINTS = 3;
D = FactorMarginalization(FactorProduct(A, B), 2);

expected = OUTPUT.Factors.D.val;
result = (sum(abs(D.val(:) - expected(:))) < TOLERANCE);
TOTAL_POINTS = ExecuteTest('FactorMarginalization',result,POINTS,TOTAL_POINTS);

% Test 3 (2 points)
POINTS = 2;
G = FactorProduct(E, F);

expected = OUTPUT.Factors.G.val;
result = (sum(abs(G.val(:) - expected(:))) < TOLERANCE);
TOTAL_POINTS = ExecuteTest('FactorProduct',result,POINTS,TOTAL_POINTS);

% Test 4 (3 points)
POINTS = 3;
H = FactorMarginalization(FactorProduct(E, F), 2);

expected = OUTPUT.Factors.H.val;
result = (sum(abs(H.val(:) - expected(:))) < TOLERANCE);
TOTAL_POINTS = ExecuteTest('FactorMarginalization',result,POINTS,TOTAL_POINTS);

% Test Inference -----------------------------------------------

load insurance.mat;

NUMTESTS = INPUT.Inference.NUMTESTS;
EVIDENCE = INPUT.Inference.EVIDENCE;






% Exact Inference -----------------------------------------------

% Test 5 (5 points)
POINTS = 5;
EVIDENCE = INPUT.Observe.EVIDENCE;
F = insurance_factors;
for i = 1:length(EVIDENCE),
    if (EVIDENCE(i) > 0),
        F = ObserveEvidence(F, [i, EVIDENCE(i)]);
    end;
end;

A = F(1);
for i=2:5
    A = FactorProduct(A,F(i));
end

expected = OUTPUT.Observe.A.val;
result = (sum(abs(A.val(:) - expected(:))) < TOLERANCE);
TOTAL_POINTS = ExecuteTest('ObserveEvidence',result,POINTS,TOTAL_POINTS);

NUMTESTS = INPUT.Inference.NUMTESTS;
EVIDENCE = INPUT.Inference.EVIDENCE;

RESULTS = OUTPUT.Inference.Clique.RESULTS;
for i = 1:NUMTESTS,
    % Test 6 (4 points each, total 20)
    POINTS = 4;
    T = insurance_clique_tree;
    F = insurance_factors;
    for j = 1:size(EVIDENCE,2),
        if (EVIDENCE(i,j) > 0),
            F = ObserveEvidence(F, [j, EVIDENCE(i,j)]);
        end;
    end;
    P = CliqueTreeCalibrate(T, F);

    result = 1;
    for j = 1:length(RESULTS{i}),
        if ((length(P(j).val(:)) ~= length(RESULTS{i}(j).val(:))) || ...
            any(abs(P(j).val(:) - RESULTS{i}(j).val(:)) > TOLERANCE)),
            result = 0;
            disp(['Mismatch in marginal of ', insurance_network.names{j}]);
        end;
    end;
    TOTAL_POINTS = ExecuteTest('CliqueTreeCalibrate',result,POINTS,TOTAL_POINTS);
    
end;


RESULTS = OUTPUT.Inference.Exact.RESULTS;
TOLERANCE = 1.0e-5;
for i = 1:NUMTESTS,
    M = ExactInference(insurance_clique_tree, insurance_factors, EVIDENCE(i, :));

    % Test 7 (1 points each, total 5)
    POINTS = 1;
    result = 1;
    for j = 1:length(RESULTS{i}),
        if ((length(M(j).val(:)) ~= length(RESULTS{i}(j).val(:))) || ...
            any(abs(M(j).val(:) - RESULTS{i}(j).val(:)) > TOLERANCE)),
            result = 0;
            disp(['Mismatch in marginal of ', insurance_network.names{j}]);
        end;
    end;
    TOTAL_POINTS = ExecuteTest('ExactInference',result,POINTS,TOTAL_POINTS);
    
end;

% Approximate Inference -----------------------------------------------
RESULTS = OUTPUT.Inference.Approx.RESULTS;
TOLERANCE = 1.0e-2;
for i = 1:NUMTESTS,
    M = ApproxInference(insurance_cluster_graph, insurance_factors, EVIDENCE(i, :));

    % Test 8 (6 points each, total 30)
    POINTS = 6;
    result = 1;
    for j = 1:length(RESULTS{i}),
        if ((length(M(j).val(:)) ~= length(RESULTS{i}(j).val(:))) || ...
            any(abs(M(j).val(:) - RESULTS{i}(j).val(:)) > TOLERANCE)),
            result = 0;
            disp(['Mismatch in marginal of ', insurance_network.names{j}]);
        end;
    end;
    TOTAL_POINTS = ExecuteTest('ApproxInference',result,POINTS,TOTAL_POINTS);    
end;







% MCMC Inference ----------------------------------------------------
gen_tests = false;
TOLERANCE = 1e-3;

% Add small uniform prior to factors to get rid of zero terms
for f = 1:length(insurance_factors)
    insurance_factors(f).val = insurance_factors(f).val ...
        + (0.01 / length(insurance_factors(f).val));
    insurance_factors(f).val = insurance_factors(f).val / sum(insurance_factors(f).val);
end

[toy_network, toy_factors] = ConstructToyNetwork(1.0, 0.1);

% Test BlockLogDistribution
if gen_tests, INPUT.BLD.A0 = ceil(rand(1, length(toy_network.names)) .* toy_network.dim); end;
rand('seed', 0);
A0 = INPUT.BLD.A0;
bld1 = BlockLogDistribution([1], toy_network, toy_factors, A0);
bld2 = BlockLogDistribution([10], toy_network, toy_factors, A0);
bld3 = BlockLogDistribution([15], toy_network, toy_factors, A0);
if gen_tests, OUTPUT.BLD.OUT = [bld1, bld2, bld3]; end;
result = all(abs(OUTPUT.BLD.OUT - [bld1, bld2, bld3]) < TOLERANCE);
POINTS = 1;
TOTAL_POINTS = ExecuteTest('BlockLogDistribution',result,POINTS,TOTAL_POINTS);

% Test ExtractMarginalsFromSamples
if gen_tests,
    INPUT.Sample.AA = ceil(rand(30, length(insurance_network.names)) .* ...
                           repmat(insurance_network.dim, 30, 1));
end
rand('seed', 0);
AA = INPUT.Sample.AA;
M = ExtractMarginalsFromSamples(insurance_network, AA, [1 3 5]);
result = 1;
for i = 1:length(M)
    if gen_tests, OUTPUT.Sample.Extract.M(i) = M(i); end;
    if any(abs(OUTPUT.Sample.Extract.M(i).val -  M(i).val) > TOLERANCE)
        result = 0;
        break;
    end
end
POINTS = 1;
TOTAL_POINTS = ExecuteTest('ExtractMarginalsFromSamples',result,POINTS,TOTAL_POINTS);

% Test GibbsTrans
if gen_tests, INPUT.Sample.A0 = ceil(rand(1, length(toy_network.names)) .* toy_network.dim); end;
rand('seed', 0);
A0 = INPUT.Sample.A0;
AA = [A0];
for i = 1:20
    AA = [AA; GibbsTrans(AA(end, :), toy_network, toy_factors)];
end
if gen_tests, OUTPUT.Sample.Gibbs.AA = AA; end;
result = all(abs(OUTPUT.Sample.Gibbs.AA(:) - AA(:)) < TOLERANCE);
POINTS = 1;
TOTAL_POINTS = ExecuteTest('GibbsTrans',result,POINTS,TOTAL_POINTS);

% Test MHSWTrans
rand('seed', 0);
[u, v] = find(toy_network.edges);
q_list = [[u, v] repmat(0.5, size(u, 1), 1)];
toy_network.q_list = q_list;
AA = [A0];
for i = 1:20
    AA = [AA; MHSWTrans(AA(end,:), toy_network, toy_factors, 1)];
end
if gen_tests, OUTPUT.Sample.MHSW1.AA = AA; end;
result = all(abs(OUTPUT.Sample.MHSW1.AA(:) - AA(:)) < TOLERANCE);

AA = [A0];
for i = 1:20
    AA = [AA; MHSWTrans(AA(end,:), toy_network, toy_factors, 2)];
end
if gen_tests, OUTPUT.Sample.MHSW2.AA = AA; end;
result = result && all(abs(OUTPUT.Sample.MHSW2.AA(:) - AA(:)) < TOLERANCE);
POINTS = 1;
TOTAL_POINTS = ExecuteTest('MHSWTrans',result,POINTS,TOTAL_POINTS);

% Test MHUniformTrans
rand('seed', 0);
AA = [A0];
for i = 1:20
    AA = [AA; MHUniformTrans(AA(end,:), toy_network, toy_factors)];
end
if gen_tests, OUTPUT.Sample.MHUniform.AA = AA; end;
result = all(abs(OUTPUT.Sample.MHUniform.AA(:) - AA(:)) < TOLERANCE);
POINTS = 1;
TOTAL_POINTS = ExecuteTest('MHUniformTrans',result,POINTS,TOTAL_POINTS);

% Test MCMC Inference
transition_names = {'Gibbs', 'MHUniform', 'MHGibbs', 'MHSwendsenWang1', 'MHSwendsenWang2'};
for j = 1:length(transition_names)
    rand('seed', 0);
    result = 1;
    A0 = ceil(rand(1, length(toy_network.names)) .* toy_network.dim);
    [M, all_samples] = MCMCInference(toy_network, toy_factors, EVIDENCE(1, :), ...
                                     transition_names{j}, 0, 500, 1, A0);
    if gen_tests, OUTPUT.Inference.MCMC{j}.samples = all_samples; end;
    if any(abs(OUTPUT.Inference.MCMC{j}.samples(:) - all_samples(:)) > TOLERANCE)
        result = 0;
    end
    for k = 1:length(M)
        if gen_tests, OUTPUT.Inference.MCMC{j}.M(k) = M(k); end;
        if any(abs(OUTPUT.Inference.MCMC{j}.M(k).val - M(k).val) > TOLERANCE)
            result = 0;
        end
    end
    POINTS = 1;
    TOTAL_POINTS = ExecuteTest(['MCMCInference with ',transition_names{j}],result,POINTS,TOTAL_POINTS);
end

if gen_tests, save('tests1', 'INPUT', 'OUTPUT'); end;