set(0, 'defaultaxesfontsize', 20);
rng shuffle;
fcn            = @(X) X'*diag([1;2])*X;
grad_fcn       = @(X) [2;4].*X;
init_X         = rand(2,1)*4*pi-2*pi;
nb_steps       = 10;
stepsize_fixed = .4;
stepsize0_bt   = 1;
bt_rate        = .5;
nb_bt_steps    = 10;
slope_ratio    = .5;


figure(1); clf; ezsurfc(@(x,y) x.^2+2*y.^2);

% gradient descent with fixed stepsize
[Xs, fcn_vals] = gd_fixed_stepsize( fcn, grad_fcn, ...
  init_X, nb_steps, stepsize_fixed);

figure(2); clf; ezcontour(@(x,y) x.^2+2*y.^2);
hold on;   plot(Xs(1,:), Xs(2,:),'.-');

% gradient descent with backtrack
[Xs_bt, fcn_vals_bt, stepsizes_bt] = gd_backtrack( fcn, grad_fcn, ...
  init_X, nb_steps, stepsize0_bt, bt_rate, nb_bt_steps, slope_ratio);

figure(3); clf; ezcontour(@(x,y) x.^2+2*y.^2);
hold on;   plot(Xs_bt(1,:), Xs_bt(2,:), '.-');

% save
saveas(1, 'a_shape.eps', 'psc2'); saveas(2, 'a_fix.eps', 'psc2');
saveas(3, 'a_bt.eps', 'psc2');
