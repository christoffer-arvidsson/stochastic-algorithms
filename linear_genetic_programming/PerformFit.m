function yEstimate = PerformFit(xValues, yTrue, chromosome)
  numVariableRegisters = 4;
  numConstantRegisters = 3;
  numOperators = 4;
  operatorSet = cell(numOperators,1);
  operatorSet{1} = @Addition;
  operatorSet{2} = @Subtraction;
  operatorSet{3} = @Multiplication; 
  operatorSet{4} = @ProtectedDivision;
  constants = [-1, 1, 3];
  chromosomeLengthBeforePenalty = 4*64;

  constantRegisters = constants;
  variableRegisters = zeros(numVariableRegisters, 1);
  [error, fitness, yEstimate] = EvaluateChromosome(chromosome, ...
                                            variableRegisters, ...
                                            constantRegisters, ...
                                            operatorSet, ...
                                            xValues, yTrue,...
                                            chromosomeLengthBeforePenalty);
end
