function [population, chromosomeLengths] = InitializePopulation(populationSize, chromosomeLength, operatorSet,...
                                           nVariableRegisters, nConstantRegisters, chromosomeBufferSize)
  numberOfInstructions = fix(chromosomeLength / 4);
  nOperators = length(operatorSet);
  nRegisters = nVariableRegisters+nConstantRegisters;

  population = zeros(populationSize, chromosomeBufferSize);
  for chromosomeIndex = 1:populationSize
    % population(chromosomeIndex,:,1) = randsample(nOperators, numberOfInstructions, true);
    population(chromosomeIndex, 1:4:chromosomeLength) = randsample(nOperators, numberOfInstructions, true);
    population(chromosomeIndex, 2:4:chromosomeLength) = randsample(nRegisters, numberOfInstructions, true);
    population(chromosomeIndex, 3:4:chromosomeLength) = randsample(nRegisters, numberOfInstructions, true);
    population(chromosomeIndex, 4:4:chromosomeLength) = randsample(nVariableRegisters, numberOfInstructions, true);
  end
  chromosomeLengths = zeros(populationSize,1);
  chromosomeLengths(:) = chromosomeLength;
end
