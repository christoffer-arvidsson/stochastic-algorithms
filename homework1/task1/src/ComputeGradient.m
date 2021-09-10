% This function should return the gradient of f_p = f + penalty.
% You may hard-code the gradient required for this specific problem.

function gradF = ComputeGradient(x,mu)
  dx1 = 2 * (x(1) - 1);
  dx2 = 4 * (x(2) - 2);
  gradF = [dx1 dx2];
end
