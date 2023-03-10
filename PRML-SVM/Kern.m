function r = Kern(x1, x2)
% r = Kern(x1,x2)
%
% Inhomogeneous second-order polynomial kernel function

r = (x1' * x2 + 1)^2;
