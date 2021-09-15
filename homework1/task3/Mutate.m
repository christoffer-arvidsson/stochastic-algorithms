function mutatedIndividual = Mutate(individual, mutationProbability);
  nGenes = size(individual, 2);
  mutationMask = rand(nGenes, 1) < mutationProbability;
  mutatedIndividual = individual;
  mutatedIndividual(mutationMask) = 1 - mutatedIndividual(mutationMask);
end
