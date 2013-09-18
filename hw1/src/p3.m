% ====================
% script for hw01, p03
% ====================

% function handles
f1 = @(x,y) 1.125*x^2 + 0.5*x*y + 0.75*y^2 + 2*x + 2*y;
f2 = @(x,y) 0.5*(x^2 + y^2) + 50*log(1+exp(-0.5*y)) + 50*log(1+exp(0.2*x));
f3 = @(x,y) 0.1*(x^2 + y - 11)^2 + 0.1*(x + y^2 - 7)^2;
f4 = @(x,y) 0.002*(1-x)^2 + 0.2*(y - x^2)^2;

% gradient handles
g1 = @(x,y)[2.25*x+0.5*y+2, 0.5*x+1.5*y+2];
g2 = @(x,y)[x+10*exp(0.2*x)/(1+exp(0.2*x)), y-25*exp(-0.5*y)/(1+exp(-0.5*y))];
g3 = @(x,y)[0.4*(x^2+y-11)*x+0.2*(x+y^2-7), 0.2*(x^2+y-11)+0.4*(x+y^2-7)*y];
g4 = @(x,y)[-0.004*(1-x)-0.8*(y-x^2)*x, 0.4*(y-x^2)];

% plot three surface functions
figure(1); clf; ezsurfc(f1, [-6,6]);
figure(2); clf; ezsurfc(f2, [-6,6]);
figure(3); clf; ezsurfc(f3, [-6,6]);
figure(4); clf; ezsurfc(f4, [-3,3,-6,6]);

% gradient descent parameters
nb_steps       = 100;
inits(1,:)     = [2,3];
inits(2,:)     = [,];  % make this into random initialization based on ranges

% gradient descent with fixed stepsize
stepsizes = [0.3,0.8];
for st=1:2
    for init=1:2
        stepsize_fixed = stepsizes(st);
        init_X = inits(init,:);
        [Xs, fcn_vals] = gd_fixed_stepsize(fcn,grad_fcn,init_X,nb_steps,stepsize_fixed);
        figure; clf; ezcontour(f1, [-6,6]);  %%% specify which function and range here
        hold on; plot(Xs(:,1), Xs(:,2),'.-');
    end
end

% gradient descent with backtrack
stepsize0_bt   = 1;
bt_rate        = .5;
nb_bt_steps    = 10;
slope_ratio    = .5;
for init=1:2
    init_X = inits(init,:);
    [Xs_bt, fcn_vals_bt, stepsizes_bt] = gd_backtrack(fcn,grad_fcn,init_X,nb_steps,stepsize0_bt,bt_rate,nb_bt_steps,slope_ratio);
    figure; clf; ezcontour(f1, [-6,6]); %%% specify which function and range here
    hold on; plot(Xs_bt(:,1), Xs_bt(:,2),'.-');
end

% gradient descent with poly stepsize
[Xs_p, fcn_vals_p] = gd_poly(fcn,grad_fcn,init_X,nb_steps);
