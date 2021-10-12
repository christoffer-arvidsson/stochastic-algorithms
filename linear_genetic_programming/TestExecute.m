function r = TestExecute(x)
  chromosome = [1 1 1 4 2 1 1 5 3 1 1 3 4 1 1 5].'
  numVariableRegisters = 2;
  numConstantRegisters = 1;
  numOperations = 4;
  constants = [-1, 1, 3];
  operatorSet = cell(numOperations,1);
  operatorSet{1} = @Addition;
  operatorSet{2} = @Subtraction;
  operatorSet{3} = @Multiplication; 
  operatorSet{4} = @ProtectedDivision;


  constantRegisters = constants;
  variableRegisters = zeros(numVariableRegisters, 1);
  r = ExecuteChromosome(chromosome, x, variableRegisters, ...
                        constantRegisters, operatorSet);
