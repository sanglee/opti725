function [x] = BFGS(f,g,iss,btr,sr,mbt,initVec,stopEps)
    %   inputs:
    %       f: fn handle
    %       g: gradient fn handle
    %       iss: initial step size
    %       btr: back track ratio
    %       sr: slope ratio
    %       mbt: maximum number of back tracks
    %       initVec: initial point
    %       stopEps: stopping criteria epsilon

    x(1,:) = initVec;
    H = eye(size(x,2));
    ct = 1;
    a = 1;
    d = -H*g(x(end,1),x(end,2));
    while norm(g(x(end,1),x(end,2))) > stopEps
        p = a*d;
        x(end+1,:) = x(end,:) + p';
        q = g(x(end,1),x(end,2)) - g(x(end-1,1),x(end-1,2));
        H = H + (1+(q'*H*q)/(p'*q))*((p*p')/(p'*q)) - (p*q'*H+H*q*p')/(q'*p);
        d = -H*g(x(end,1),x(end,2));
        a = iss;
        for i=1:mbt
            if f(x(end,1),x(end,2)) > f(x(end-1,1),x(end-1,2))-sr*a*norm(g(x(end,1),x(end,2)))^2, break; end;
            a = a*btr;
        end
        ct = ct+1; if ct>20000, disp('Failed to converge.'); break; end;
    end
end
