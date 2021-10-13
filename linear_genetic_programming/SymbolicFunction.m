function [f, simpleF] = SymbolicFunction(chromosome)
  syms x

  numVariableRegisters = 4;
  numConstantRegisters = 3;
  numOperators = 4;
  operatorSet = cell(numOperators,1);
  operatorSet{1} = @Addition;
  operatorSet{2} = @Subtraction;
  operatorSet{3} = @Multiplication; 
  operatorSet{4} = @ProtectedDivision;
  constants = [sym(-1), sym(1), sym(3)];

  constantRegisters = constants;
  for i = 1:numVariableRegisters
    variableRegisters(i) = sym(0);
  end

  f = ExecuteChromosome(chromosome, x, variableRegisters, constantRegisters, operatorSet, true);
  simpleF = simplify(f);

end
