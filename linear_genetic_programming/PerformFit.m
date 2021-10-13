function yEstimate = PerformFit(xValues, yTrue, chromosome)
  numVariableRegisters = 4;
  numConstantRegisters = 1;
  numOperators = 1;
  operatorSet = cell(numOperators,1);
  operatorSet{1} = @Addition;
  operatorSet{2} = @Subtraction;
  operatorSet{3} = @Multiplication; 
  operatorSet{4} = @ProtectedDivision;
  constants = [-1];
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
