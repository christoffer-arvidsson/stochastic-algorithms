% This function should return the gradient of f_p = f + penalty.
% You may hard-code the gradient required for this specific problem.

function gradF = ComputeGradient(x,mu)
  constraint = x(1)^2 + x(2)^2 - 1;
  if  constraint > 0
    penaltyTerm1 = 4*mu*(x(1)^3 + x(1)*x(2)^2 - x(1));
    penaltyTerm2 = 4*mu*(x(2)^3 + x(1)^2*x(2) - x(2));
  else
    penaltyTerm1 = 0;
    penaltyTerm2 = 0;
  end

  dx1 = 2 * (x(1) - 1) + penaltyTerm1;
  dx2 = 4 * (x(2) - 2) + penaltyTerm2;
  gradF = [dx1 dx2];
end
