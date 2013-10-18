function [x] = gradientDescent(f,g,initVec,stopEps)
%   inputs: 
%       f: fn handle
%       g: gradient fn handle
%       initVec: initial point
%       stopEps: stopping criteria epsilon

x(1,:) = initVec;
ct = 1;
while norm(g(x(end,1),x(end,2))) > stopEps
    x(end+1,:) = x(end,:) - (1/size(x,1))*(eye(size(x,2))*g(x(end,1),x(end,2)))';
    ct = ct+1; if ct>20000, disp('Failed to converge.'); break; end;
end
