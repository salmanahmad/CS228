% Make a point move in the 2D plane
% State = (x y xdot ydot). We only observe (x y).

% This code was used to generate Figure 17.9 of "Artificial Intelligence: a Modern Approach",
% Russell and Norvig, 2nd edition, Prentice Hall, in preparation.

% X(t+1) = F X(t) + noise(Q)
% Y(t) = H X(t) + noise(R)

addpath(genpath('KalmanAll'))

ss = 4; % state size
os = 2; % observation size
F = [1 0 1 0; 0 1 0 1; 0 0 1 0; 0 0 0 1]; 
H = [1 0 0 0; 0 1 0 0];
Q = 0.1*eye(ss);
R = 1*eye(os);
initx = [10 10 1 0]';
initV = 10*eye(ss);

seed = 10;
rand('state', seed);
randn('state', seed);
T = 15;
[x,y] = sample_lds(F, H, Q, R, initx, T);

[xfilt, Vfilt, VVfilt, loglik] = kalman_filter(y, F, H, Q, R, initx, initV);
[xsmooth, Vsmooth] = kalman_smoother(y, F, H, Q, R, initx, initV);

dfilt = x([1 2],:) - xfilt([1 2],:);
mse_filt = sqrt(sum(sum(dfilt.^2)))

dsmooth = x([1 2],:) - xsmooth([1 2],:);
mse_smooth = sqrt(sum(sum(dsmooth.^2)))


subplot(2,1,1)
hold on
plot(x(1,:), x(2,:), 'ks-');
plot(y(1,:), y(2,:), 'g*');
plot(xfilt(1,:), xfilt(2,:), 'rx:');
for t=1:T, plotgauss2d(xfilt(1:2,t), Vfilt(1:2, 1:2, t)); end
hold off
legend('true', 'observed', 'filtered', 0)
xlabel('X1')
ylabel('X2')

subplot(2,1,2)
hold on
plot(x(1,:), x(2,:), 'ks-');
plot(y(1,:), y(2,:), 'g*');
plot(xsmooth(1,:), xsmooth(2,:), 'rx:');
for t=1:T, plotgauss2d(xsmooth(1:2,t), Vsmooth(1:2, 1:2, t)); end
hold off
legend('true', 'observed', 'smoothed', 0)
xlabel('X1')
ylabel('X2')



