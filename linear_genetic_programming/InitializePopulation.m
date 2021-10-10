function population = InitializePopulation(populationSize, chromosomeLength, operatorSet,...
                                           nVariableRegisters, nConstantRegisters)
  numberOfInstructions = fix(chromosomeLength / 4)
  nOperators = length(operatorSet);

  for chromosomeIndex = 1:populationSize
    % population(chromosomeIndex,:,1) = randsample(nOperators, numberOfInstructions, true);
    genes(1:4:chromosomeLength) = randsample(nOperators, numberOfInstructions, true);
    genes(2:4:chromosomeLength) = randsample(nVariableRegisters, numberOfInstructions, true);
    genes(3:4:chromosomeLength) = randsample(nConstantRegisters, numberOfInstructions, true);
    genes(4:4:chromosomeLength) = randsample(nConstantRegisters, numberOfInstructions, true);
    population(chromosomeIndex).genes = genes';
  end
end
