function ok = CompareBeliefs(F1,F2,TOL)

if ~exist('TOL'), TOL = 1e-5; end;

ok = length(F1.dim)==length(F2.dim);
ok = ok && all(F1.dim==F2.dim);
ok = ok && all(abs(F1.val - F2.val) < TOL);


