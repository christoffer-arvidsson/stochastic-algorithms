% This function should run gradient descent until the L2 norm of the
% gradient falls below the specified threshold.

function x = RunGradientDescent(xStart, mu, eta, gradientTolerance)
  x = xStart;

  % Do while loop
  while true
    gradF = ComputeGradient(x, mu);
    x = x - eta * gradF;

    if norm(gradF) < gradientTolerance
      break
    end
  end
end
