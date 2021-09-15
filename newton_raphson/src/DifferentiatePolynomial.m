% This method should return the coefficients of the k-th derivative (defined by
% the derivativeOrder) of the polynomial given by the polynomialCoefficients (see also GetPolynomialValue)

function derivativeCoefficients = DifferentiatePolynomial(polynomialCoefficients, derivativeOrder)
  newCoefficients = polynomialCoefficients;

  for k = 1:derivativeOrder
    newCoefficients = SingleDifferentiatePolynomial(newCoefficients);
  end

  derivativeCoefficients = newCoefficients;
end

function derivativeCoefficients = SingleDifferentiatePolynomial(polynomialCoefficients)
  n = length(polynomialCoefficients);

  powers = 0:n-1;
  powers = polynomialCoefficients .* powers;
  derivativeCoefficients = powers(2:n);
end
