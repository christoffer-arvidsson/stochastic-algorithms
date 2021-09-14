% Note: Each component of x should take values in [-a,a], where a = maximumVariableValue.

function x = DecodeChromosome(chromosome,numberOfVariables,maximumVariableValue);
  chromosomeLength = size(chromosome, 2);
  k = fix(chromosomeLength / numberOfVariables)
  d = maximumVariableValue;

  variables = zeros(numberOfVariables, 1);
  elementsPerSlice = transpose(repelem(k, numberOfVariables));
  slices = mat2cell(chromosome, 1, elementsPerSlice);

  factors = 2.^(-(1:k));
  for iVariable = 1:numberOfVariables
    variables(iVariable) = -d + (2*d)/(1-2^(-k)) .* sum(factors .* cell2mat(slices(1, iVariable)));
  end
end
