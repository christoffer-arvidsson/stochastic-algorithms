function mutatedChromosome = Mutate(chromosome, mutationProbability, ...
                                                 numVariableRegisters, ...
                                                 numConstantRegisters, numOperations);
  numGenes = size(chromosome, 2);
  numInstructions = fix(numGenes / 4);
  numRegisters = numVariableRegisters + numConstantRegisters;

  mutatedChromosome = chromosome;
  for iGene = 1:numGenes;
    typeIndex = mod(iGene, 4);
    if typeIndex == 0
      mutatedChromosome(iGene) = randi(numOperations);
    elseif typeIndex == 1
      mutatedChromosome(iGene) = randi(numVariableRegisters);
    else
      mutatedChromosome(iGene) = randi(numRegisters);
    end
  end
end

