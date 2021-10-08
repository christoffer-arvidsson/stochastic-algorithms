% This function should return the value of the polynomial f(x) = a0x^0 + a1x^1 + a2x^2 ...
% where a0, a1, ... are obtained from polynomialCoefficients.

function value = GetPolynomialValue(x, polynomialCoefficients)
  res = 0.0;
  for iCoeff = 1:length(polynomialCoefficients)
    res = res + polynomialCoefficients(iCoeff) * x^(iCoeff-1);
  end

  value = res;
end
