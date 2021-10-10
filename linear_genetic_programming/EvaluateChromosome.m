function [fitness, yEstimate] = EvaluateChromosome(chromosome, variableRegisters, ...
                                                   constantRegisters, operatorSet, ...
                                                   xValues, yTrue, ...
                                                   chromosomeLengthBeforePenalty, ...
                                                   chromosomeLengthPenaltyFactor)
  numSamples = length(yTrue);
  yEstimate = zeros(numSamples, 1);
  for iData = 1:numSamples
    x = xValues(iData);
    yEstimate(iData) = ExecuteChromosome(chromosome, x, variableRegisters, ...
                                         constantRegisters, operatorSet);
  end

  penalty = 0;
  chromosomeLength = length(chromosome);
  if  chromosomeLength >= chromosomeLengthBeforePenalty
    penalty = chromosomeLengthPenaltyFactor * (chromosomeLength - chromosomeLengthBeforePenalty);
  end

  error = RootMeanSquaredError(yTrue, yEstimate);
  fitness = 1 / error - penalty;
  end
