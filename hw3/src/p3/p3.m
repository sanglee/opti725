% ====================
% script for hw03, p03
% ====================

% function handles
f{1} = @(x,y) 1.125*x^2 + 0.5*x*y + 0.75*y^2 + 2*x + 2*y;
f{2} = @(x,y) 0.5*(x^2 + y^2) + 50*log(1+exp(-0.5*y)) + 50*log(1+exp(0.2*x));
f{3} = @(x,y) 0.1*(x^2 + y - 11)^2 + 0.1*(x + y^2 - 7)^2;
f{4} = @(x,y) 0.002*(1-x)^2 + 0.2*(y - x^2)^2;

% gradient handles
g{1} = @(x,y)[2.25*x+0.5*y+2; 0.5*x+1.5*y+2];
g{2} = @(x,y)[x+10*exp(0.2*x)/(1+exp(0.2*x)); y-25*exp(-0.5*y)/(1+exp(-0.5*y))];
g{3} = @(x,y)[0.4*(x^2+y-11)*x+0.2*(x+y^2-7); 0.2*(x^2+y-11)+0.4*(x+y^2-7)*y];
g{4} = @(x,y)[-0.004*(1-x)-0.8*(y-x^2)*x; 0.4*(y-x^2)];

% hessian (component) handles
h{1} = @(x,y)[2.25, 0.5; 0.5, 1.5];
h{2} = @(x,y)[1+(((1+exp(0.2*x))*(2*exp(0.2*x))-(10*exp(0.2*x))*(0.2*exp(0.2*x)))/(1+exp(0.2*x))^2), 0;... 
                0, 1-((((-25/2)*exp(-0.5*y))*(1+exp(-0.5*y))-(25*exp(-0.5*y))*(1-0.5*exp(-0.5*y)))/(1+exp(-0.5*y))^2)];
h{3} = @(x,y)[0.4*(x^2+y-11)+0.8*x^2+0.2, 0.4*x+0.4*y; 0.4*x+0.4*y, 0.2+0.4*(x+y^2-7)+0.8*y^2];
h{4} = @(x,y)[0.004-0.8*(y-x^2)+1.6*x^2, -0.8*x; -0.8*x, 0.4];

% range rects
frect{1} = [-6,6,-6,6];
frect{2} = [-6,6,-6,6];
frect{3} = [-6,6,-6,6];
frect{4} = [-3,3,-6,6];

warning('off','MATLAB:ezplotfeval:NotVectorized');
stopEps = 1e-6;
inits = {[1,1],[2,2],[3,3]};

% newton's method
spcounter = 1;
for fun=1:length(f)
    for in=1:length(inits)
        init = inits{in};
        Xs = newtonsMethod(f{fun},g{fun},h{fun},init,stopEps);
        subplot(length(f),length(inits),spcounter); ezcontour(f{fun},frect{fun});
        hold on; plot(Xs(:,1),Xs(:,2),'.-');
        hold on; plot(Xs(1,1),Xs(1,2),'s','MarkerSize',3);
        hold on; plot(Xs(end,1),Xs(end,2),'*');
        fprintf('Newton. Init=%d. NumIter=%d.\n',in,size(Xs,1));
        spcounter=spcounter+1;
    end
end

% BFGS
spcounter = 1;
for fun=1:length(f)
    for in=1:length(inits)
        init = inits{in};
        Xs = BFGS(f{fun},g{fun},1,0.5,0.5,10,init,stopEps);
        subplot(length(f),length(inits),spcounter); 
        hold on; plot(Xs(:,1),Xs(:,2),'r--');
        hold on; plot(Xs(1,1),Xs(1,2),'ro','MarkerSize',3);
        hold on; plot(Xs(end,1),Xs(end,2),'r^');
        fprintf('BFGS. Init=%d. NumIter=%d.\n',in,size(Xs,1));
        spcounter=spcounter+1;
    end
end
