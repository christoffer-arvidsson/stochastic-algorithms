% This method should plot the polynomial and the iterates obtained
% using NewtonRaphsonStep (if any iterates were generated).

function PlotIterations(polynomialCoefficients, iterationValues)
  width = 2;

  yValues = zeros(length(iterationValues),1);
  for i = 1:length(iterationValues)
    yValues(i) = GetPolynomialValue(iterationValues(i), polynomialCoefficients);
  end

  solution = iterationValues(end);
  PlotPolynomial(polynomialCoefficients, solution - width/2, solution + width/2);
  hold on
  plot(iterationValues, yValues, 'ko');

end

function PlotPolynomial(polynomialCoefficients, xMin, xMax)
  xRange = xMin:0.001:xMax;
  yValues = zeros(length(xRange),1);
  for i = 1:length(xRange)
    yValues(i) = GetPolynomialValue(xRange(i), polynomialCoefficients);
  end

  plot(xRange, yValues);
end
