function estimate = ExecuteChromosome(chromosome, x, variableRegisters, ...
                                      constantRegisters, operatorSet)

  chromosomeLength = size(chromosome, 1);
  variableRegisters(1) = x;
  for iInstruction = 1:4:chromosomeLength
    operator = operatorSet{chromosome(iInstruction)};
    destination = chromosome(iInstruction+1);
    operand1 = FetchOperand(chromosome(iInstruction+2), variableRegisters, constantRegisters);
    operand2 = FetchOperand(chromosome(iInstruction+3), variableRegisters, constantRegisters);
    variableRegisters(destination) = operator(operand1, operand2);
  end
  estimate = variableRegisters(1);
end

function operand = FetchOperand(index, variableRegisters, ...
                                constantRegisters)
  if index > length(variableRegisters)
    operand = constantRegisters(index-length(variableRegisters));
  else
    operand = variableRegisters(index);
  end
end
