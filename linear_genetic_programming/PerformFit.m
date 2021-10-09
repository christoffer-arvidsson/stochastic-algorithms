function yEstimate = PerformFit(xValues, chromosome)
  numVariableRegisters = 10;
  numConstantRegisters = 3;
  numOperations = 4;
  operatorSet = cell(numOperations,1);
  operatorSet{1} = @plus;
  operatorSet{2} = @minus;
  operatorSet{3} = @mtimes; 
  operatorSet{4} = @ProtectedDivision;
  numRegisters = numVariableRegisters + numConstantRegisters;

  numDatapoints = size(xValues, 1);

  registers = zeros(numRegisters, 1);
  yEstimate = zeros(numDatapoints, 1);
  for xIndex = 1:numDatapoints
    x = xValues(xIndex);
    registers = 0
    registers(1) = x;
    yEstimate(xIndex) = ExecuteChromosome(chromosome, registers, operatorSet);
  end
end
