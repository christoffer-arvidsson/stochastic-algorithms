function yEstimate = PerformFit(xValues, yTrue, chromosome)
  numVariableRegisters = 4;
  numConstantRegisters = 1;
  numOperators = 4;
  operatorSet = cell(numOperators,1);
  operatorSet{1} = @plus;
  operatorSet{2} = @minus;
  operatorSet{3} = @mtimes; 
  operatorSet{4} = @ProtectedDivision;
  constants = [-0.8];
  chromosomeLengthBeforePenalty = 256;
  chromosomeLengthPenaltyFactor = 0.95;

  constantRegisters = constants;
  variableRegisters = zeros(numVariableRegisters, 1);
  [fitness, yEstimate] = EvaluateChromosome(chromosome, ...
                                            variableRegisters, ...
                                            constantRegisters, ...
                                            operatorSet, ...
                                            xValues, yTrue,...
                                            chromosomeLengthBeforePenalty, ...
                                            chromosomeLengthPenaltyFactor);
end
