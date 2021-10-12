function mutatedChromosome = Mutate(chromosome, mutationProbability, ...
                                                 numVariableRegisters, ...
                                                 numConstantRegisters, numOperations);
  numGenes = size(chromosome, 1);
  numRegisters = numVariableRegisters + numConstantRegisters;

  mutatedChromosome = chromosome;
  rolls = rand(numGenes, 1);
  for iGene = 1:numGenes;
    if rolls(iGene) < mutationProbability
      typeIndex = mod(iGene-1, 4);
      if typeIndex == 0
        mutatedChromosome(iGene) = randi(numOperations);
      elseif typeIndex == 1
        mutatedChromosome(iGene) = randi(numVariableRegisters);
      else
        mutatedChromosome(iGene) = randi(numRegisters);
      end
    end
  end
end

