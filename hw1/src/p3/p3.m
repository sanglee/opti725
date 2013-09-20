% ====================
% script for hw01, p03
% ====================

% function handles
f{1} = @(x,y) 1.125*x^2 + 0.5*x*y + 0.75*y^2 + 2*x + 2*y;
f{2} = @(x,y) 0.5*(x^2 + y^2) + 50*log(1+exp(-0.5*y)) + 50*log(1+exp(0.2*x));
f{3} = @(x,y) 0.1*(x^2 + y - 11)^2 + 0.1*(x + y^2 - 7)^2;
f{4} = @(x,y) 0.002*(1-x)^2 + 0.2*(y - x^2)^2;

% gradient handles
g{1} = @(x,y)[2.25*x+0.5*y+2, 0.5*x+1.5*y+2];
g{2} = @(x,y)[x+10*exp(0.2*x)/(1+exp(0.2*x)), y-25*exp(-0.5*y)/(1+exp(-0.5*y))];
g{3} = @(x,y)[0.4*(x^2+y-11)*x+0.2*(x+y^2-7), 0.2*(x^2+y-11)+0.4*(x+y^2-7)*y];
g{4} = @(x,y)[-0.004*(1-x)-0.8*(y-x^2)*x, 0.4*(y-x^2)];

% range rects
frect{1} = [-6,6,-6,6];
frect{2} = [-6,6,-6,6];
frect{3} = [-6,6,-6,6];
frect{4} = [-3,3,-6,6];

% plot three surface functions
figure;
for fun=1:4
    subplot(2,2,fun); ezsurfc(f{fun},frect{fun});
end

% gradient descent parameters
nb_steps = 1000;
for fun=1:length(f)
    inits{fun}(1,:) = [2,3];
    inits{fun}(2,:) = [unifrnd(frect{fun}(1),frect{fun}(2)),unifrnd(frect{fun}(3),frect{fun}(4))];
end

% gradient descent with fixed stepsize
stepsizes = [0.3,0.8];
spcounter = 1;
figure;
for fun=1:length(f)
    for st=1:2
        for in=1:2
            stepsize_fixed = stepsizes(st);
            init_X = inits{fun}(in,:);
            [Xs,fcn_vals] = gd_fixed_stepsize(f{fun},g{fun},init_X,nb_steps,stepsize_fixed);
            subplot(4,4,spcounter); ezcontour(f{fun},frect{fun});
            hold on; plot(Xs(:,1),Xs(:,2),'.-');
            hold on; plot(Xs(1,1),Xs(1,2),'o');
            spcounter=spcounter+1;
        end
    end
end

% gradient descent with backtrack
spcounter = 1;
figure;
for fun=1:length(f)
    stepsize0_bt = 1;
    bt_rate = 0.5;
    nb_bt_steps = 3;
    slope_ratio = 0.5;
    for in=1:2
        init_X = inits{fun}(in,:);
        [Xs_bt,fcn_vals_bt,stepsizes_bt] = gd_backtrack(f{fun},g{fun},init_X,nb_steps,stepsize0_bt,bt_rate,nb_bt_steps,slope_ratio);
        subplot(4,2,spcounter); ezcontour(f{fun},frect{fun});
        hold on; plot(Xs_bt(:,1),Xs_bt(:,2),'.-');
        hold on; plot(Xs_bt(1,1),Xs_bt(1,2),'o');
        spcounter=spcounter+1;
    end
end

% gradient descent with poly stepsize
spcounter = 1;
figure;
for fun=1:length(f)
    for in=1:2
        init_X = inits{fun}(in,:);
        [Xs_p,fcn_vals_p] = gd_poly(f{fun},g{fun},init_X,nb_steps);
        subplot(4,2,spcounter); ezcontour(f{fun},frect{fun});
        hold on; plot(Xs_p(:,1),Xs_p(:,2),'.-');
        hold on; plot(Xs_p(1,1),Xs_p(1,2),'o');
        spcounter=spcounter+1;
    end
end
