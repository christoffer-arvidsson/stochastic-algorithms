function mutatedIndividual = Mutate(individual, mutationProbability, creepMutationProbability, creepMutationRate, wMax);
  nGenes = size(individual, 2);
  mutationMask = rand(nGenes, 1) < mutationProbability;

  creepMutationMask = mutationMask & (rand(nGenes, 1) < creepMutationRate);
  ordinaryMutationMask = mutationMask & ~creepMutationMask;

  mutatedIndividual = individual;

  creepRoll = rand(nGenes, 1);
  creepOffset = -creepMutationRate/2 + 2*creepMutationRate .* creepRoll(creepMutationMask);
  ordinaryRoll = rand(nGenes, 1);

  mutatedIndividual(creepMutationMask) = mutatedIndividual(creepMutationMask) + creepOffset';
  mutatedIndividual(ordinaryMutationMask) = ordinaryRoll(ordinaryMutationMask);

  % Clamp values if they are outside bounds
  mutatedIndividual(mutatedIndividual > 1) = 1;
  mutatedIndividual(mutatedIndividual < 0) = 0;
end
