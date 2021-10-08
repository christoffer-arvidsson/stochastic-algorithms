% This function should run the Newton-Raphson method, making use of the
% other relevant functions (StepNewtonRaphson, DifferentiatePolynomial, and
% GetPolynomialValue). Before returning iterationValues any non-plottable values
% (e.g. NaN) that can occur if the method fails (e.g. if the input is a
% first-order polynomial) should be removed, so that only values that
% CAN be plotted are returned. Thus, in some cases (again, the case of
% a first-order polynomial is an example) there may be no points to plot.

function iterationValues = RunNewtonRaphson(polynomialCoefficients, startingPoint, tolerance)
  maxIterations = 100;

  xCurrent = startingPoint;
  iterationValues = zeros(maxIterations, 1);
  iterationValues(1) = startingPoint;
  for i = 2:maxIterations
    fPrime = DifferentiatePolynomial(polynomialCoefficients, 1);
    fDoublePrime = DifferentiatePolynomial(polynomialCoefficients, 2);
    fPrimeEvaluated = GetPolynomialValue(xCurrent, fPrime);
    fDoublePrimeEvaluated = GetPolynomialValue(xCurrent, fDoublePrime);

    xNext = StepNewtonRaphson(xCurrent, fPrimeEvaluated, fDoublePrimeEvaluated);

    if isnan(xNext) == 1
      fprintf('Exiting.\n')
      iterationValues = NaN;
      return
    end

    iterationValues(i) = xNext;

    if abs(xNext - xCurrent) < tolerance
      fprintf('Found solution within tolerance\n')
      break
    elseif i == maxIterations
      fprintf('Failed to converge within %d interations.\n', i)
      iterationValues = NaN;
      break
    end

    xCurrent = xNext;
  end

  iterationValues = iterationValues(1:i);

end
