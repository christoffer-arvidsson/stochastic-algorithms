function population = InitializePopulation(populationSize, operatorSet,...
                                           nVariableRegisters, ...
                                           nConstantRegisters, ...
                                           minLength, maxLength)
  chromosomeLengths = 4 * randsample(minLength:maxLength,populationSize, true);
  nOperators = length(operatorSet);

  for chromosomeIndex = 1:populationSize
    chromosomeLength = chromosomeLengths(chromosomeIndex);
    numberOfInstructions = fix(chromosomeLength / 4);

    genes(1:4:chromosomeLength) = randsample(nOperators, numberOfInstructions, true);
    genes(2:4:chromosomeLength) = randsample(nVariableRegisters, numberOfInstructions, true);
    genes(3:4:chromosomeLength) = randsample(nConstantRegisters, numberOfInstructions, true);
    genes(4:4:chromosomeLength) = randsample(nConstantRegisters, numberOfInstructions, true);

    population(chromosomeIndex).genes = genes';
  end
end
