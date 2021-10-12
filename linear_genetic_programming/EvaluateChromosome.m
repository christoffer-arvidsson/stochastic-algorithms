function [error, fitness, yEstimate] = EvaluateChromosome(chromosome, variableRegisters, ...
                                                   constantRegisters, operatorSet, ...
                                                   xValues, yTrue, ...
                                                   chromosomeLengthBeforePenalty)
  numSamples = length(yTrue);
  yEstimate = zeros(numSamples, 1);
  for iData = 1:numSamples
    x = xValues(iData);
    yEstimate(iData) = ExecuteChromosome(chromosome, x, variableRegisters, ...
                                         constantRegisters, ...
                                         operatorSet, false);
  end

  penalty = 1;
  chromosomeLength = length(chromosome);
  if chromosomeLength > chromosomeLengthBeforePenalty
    penalty = exp(chromosomeLength - chromosomeLengthBeforePenalty);
  end

  error = RootMeanSquaredError(yTrue, yEstimate);
  fitness = (1 / (error * penalty));
  end
