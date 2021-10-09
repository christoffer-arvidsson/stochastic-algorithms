function estimate = ExecuteChromosome(chromosome, registers, operatorSet)

  chromosomeLength = size(chromosome,1);
  for iInstruction = 1:4:chromosomeLength-3
    operator = operatorSet{chromosome(iInstruction)};
    operand1 = chromosome(iInstruction+1);
    operand2 = chromosome(iInstruction+2);
    destination = chromosome(iInstruction+3);
    registers(destination) = operator(operand1, operand2);
  end
  estimate = registers(1);
end

