function [x] = newtonsMethod(f,g,h,initVec,stopEps)
%   inputs: 
%       f: fn handle
%       g: gradient fn handle
%       h: hessian fn handle 
%       initVec: initial point
%       stopEps: stopping criteria epsilon

x(1,:) = initVec;
while norm(g(x(end,1),x(end,2))) > stopEps
    x(end+1,:) = x(end,:) - (inv(h(x(end,1),x(end,2)))*g(x(end,1),x(end,2)))';
end
