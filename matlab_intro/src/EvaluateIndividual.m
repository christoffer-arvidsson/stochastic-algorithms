function fitness = EvaluateIndividual(x)
  fNumerator = exp(-x(1)^2 - x(2)^2);
  fNumerator += sqrt(5) * sin(x(2)*x(1)^2)^2;
  fNumerator += 2*cos(2*x(1) + 3*x(2))^2;
  fDenominator = 1 + x(1)^2 + x(2)^2;

  fitness = fNumerator / fDenominator;
end
